"""
Training script for LunarLander DQN Agent.
Supports training on vectorized environments (n_envs=16) with Apple Silicon MPS acceleration.
Configurable hyperparameters, exploration schedules, and run tagging.
Saves training curves (CSV/JSON), evaluation results, and model checkpoints.
"""

import os
import time
import json
import argparse
from typing import Dict, List, Any
import numpy as np
import gymnasium as gym

# Ensure LunarLander-v2 compatibility
try:
    gym.register(
        id="LunarLander-v2",
        entry_point="gymnasium.envs.box2d.lunar_lander:LunarLander",
        max_episode_steps=1000,
        reward_threshold=200,
    )
except Exception:
    pass

from stable_baselines3.common.env_util import make_vec_env
from src import DQNAgent, get_device


def train_dqn(
    agent_type: str = "vanilla",  # 'vanilla', 'double', 'dueling'
    run_tag: str = "run5",
    total_timesteps: int = 600_000,
    n_envs: int = 16,
    batch_size: int = 128,
    learning_rate: float = 5e-4,
    target_update_interval: int = 1000,
    use_soft_update: bool = False,
    tau: float = 1e-3,
    gradient_steps: int = 2,
    buffer_capacity: int = 100_000,
    epsilon_start: float = 1.0,
    epsilon_min: float = 0.02,
    epsilon_schedule: str = "linear",  # 'linear' or 'exponential'
    decay_steps: int = 200_000,
    seed: int = 42,
    save_dir: str = "models",
    log_dir: str = "logs",
) -> Dict[str, Any]:
    """
    Trains a DQN agent on vectorized LunarLander environment.
    """
    os.makedirs(save_dir, exist_ok=True)
    os.makedirs(log_dir, exist_ok=True)

    print(f"\n{'='*70}")
    print(f"Starting Training: {agent_type.upper()} DQN (Tag: {run_tag})")
    print(f"Device: {get_device()} | Envs: {n_envs} | Target Timesteps: {total_timesteps:,}")
    print(f"Batch Size: {batch_size} | LR: {learning_rate} | Buffer: {buffer_capacity:,} | Grad Steps: {gradient_steps}")
    print(f"Target Update: {'Soft (tau=' + str(tau) + ')' if use_soft_update else 'Hard (' + str(target_update_interval) + ' steps)'}")
    print(f"Exploration: {epsilon_schedule} (over {decay_steps:,} steps, min {epsilon_min})")
    print(f"{'='*70}\n")

    # Configure agent parameters according to selected type
    double_dqn = agent_type in ["double", "dueling"]
    dueling = agent_type == "dueling"
    if agent_type in ["double", "dueling"]:
        use_soft_update = True

    agent = DQNAgent(
        state_dim=8,
        action_dim=4,
        hidden_dim=128,
        learning_rate=learning_rate,
        gamma=0.99,
        tau=tau,
        use_soft_update=use_soft_update,
        target_update_interval=target_update_interval,
        double_dqn=double_dqn,
        dueling=dueling,
        buffer_capacity=buffer_capacity,
        batch_size=batch_size,
        epsilon_start=epsilon_start,
        epsilon_min=epsilon_min,
        epsilon_decay=0.996,
        seed=seed,
    )

    # Create vectorized environment
    env_id = "LunarLander-v2"
    env = make_vec_env(env_id, n_envs=n_envs, seed=seed)

    states = env.reset()

    # Tracking metrics
    episode_rewards = []
    episode_lengths = []
    current_ep_rewards = np.zeros(n_envs, dtype=np.float32)
    current_ep_lengths = np.zeros(n_envs, dtype=np.int32)

    logged_steps: List[int] = []
    mean_100_history: List[float] = []
    losses: List[float] = []

    total_steps = 0
    episodes_completed = 0
    start_time = time.time()
    best_mean_reward = -np.inf

    prefix = f"{agent_type}_dqn_{run_tag}"
    checkpoint_path = os.path.join(save_dir, f"{prefix}.pt")
    best_checkpoint_path = os.path.join(save_dir, f"{prefix}_best.pt")

    while total_steps < total_timesteps:
        # Update linear epsilon if selected
        if epsilon_schedule == "linear":
            agent.update_epsilon_linear(total_steps, decay_steps)

        # 1. Action selection
        actions = agent.select_action(states)

        # 2. Environment step
        next_states, rewards, dones, infos = env.step(actions)

        # 3. Handle true terminal states in vectorized environment
        real_next_states = next_states.copy()
        for idx, done in enumerate(dones):
            if done:
                if "terminal_observation" in infos[idx]:
                    real_next_states[idx] = infos[idx]["terminal_observation"]
                elif "final_observation" in infos[idx]:
                    real_next_states[idx] = infos[idx]["final_observation"]

        # 4. Agent step & Replay buffer update
        metrics = agent.step(states, actions, rewards, real_next_states, dones)
        if metrics and "loss" in metrics:
            losses.append(metrics["loss"])
        for _ in range(gradient_steps - 1):
            if len(agent.replay_buffer) >= agent.batch_size:
                extra_m = agent.train_step()
                if extra_m and "loss" in extra_m:
                    losses.append(extra_m["loss"])

        # 5. Track episode returns
        current_ep_rewards += rewards
        current_ep_lengths += 1

        for idx, done in enumerate(dones):
            if done:
                ep_reward = float(current_ep_rewards[idx])
                ep_length = int(current_ep_lengths[idx])
                episode_rewards.append(ep_reward)
                episode_lengths.append(ep_length)
                episodes_completed += 1

                # If exponential decay selected
                if epsilon_schedule == "exponential":
                    agent.decay_epsilon()

                current_ep_rewards[idx] = 0.0
                current_ep_lengths[idx] = 0

        states = next_states
        total_steps += n_envs

        # Log progress periodically
        if total_steps % (n_envs * 100) == 0 and len(episode_rewards) > 0:
            mean_100 = float(np.mean(episode_rewards[-100:]))
            mean_100_history.append(mean_100)
            logged_steps.append(total_steps)

            elapsed = time.time() - start_time
            fps = int(total_steps / elapsed) if elapsed > 0 else 0

            print(
                f"Step {total_steps:7,d}/{total_timesteps:,d} | "
                f"Eps: {episodes_completed:5d} | "
                f"Mean100: {mean_100:6.1f} | "
                f"Latest: {episode_rewards[-1]:6.1f} | "
                f"Eps: {agent.epsilon:.3f} | "
                f"FPS: {fps:4d}"
            )

            # Save best model
            if mean_100 > best_mean_reward and len(episode_rewards) >= 50:
                best_mean_reward = mean_100
                agent.save(best_checkpoint_path)

    env.close()

    # Save final model
    agent.save(checkpoint_path)

    # Save training logs for plotting
    history = {
        "agent_type": agent_type,
        "run_tag": run_tag,
        "total_timesteps": total_timesteps,
        "episodes_completed": episodes_completed,
        "batch_size": batch_size,
        "learning_rate": learning_rate,
        "target_update_interval": target_update_interval,
        "epsilon_schedule": epsilon_schedule,
        "decay_steps": decay_steps,
        "logged_steps": logged_steps,
        "mean_100_history": mean_100_history,
        "episode_rewards": episode_rewards,
        "episode_lengths": episode_lengths,
        "best_mean_reward": best_mean_reward,
        "total_time_seconds": time.time() - start_time,
    }

    log_path = os.path.join(log_dir, f"{prefix}_history.json")
    with open(log_path, "w") as f:
        json.dump(history, f, indent=2)

    print(f"\nTraining finished in {time.time() - start_time:.1f}s.")
    print(f"Saved model to: {checkpoint_path}")
    print(f"Saved best model (score: {best_mean_reward:.1f}) to: {best_checkpoint_path}")
    print(f"Saved log history to: {log_path}\n")

    return history


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--type", type=str, default="vanilla", choices=["vanilla", "double", "dueling"])
    parser.add_argument("--tag", type=str, default="run4")
    parser.add_argument("--steps", type=int, default=600_000)
    parser.add_argument("--envs", type=int, default=16)
    parser.add_argument("--batch_size", type=int, default=128)
    parser.add_argument("--lr", type=float, default=5e-4)
    parser.add_argument("--target_update", type=int, default=1000)
    parser.add_argument("--soft", action="store_true", help="Enable Polyak soft target updates")
    parser.add_argument("--tau", type=float, default=1e-3)
    parser.add_argument("--grad_steps", type=int, default=2, help="Gradient steps per vectorized env step")
    parser.add_argument("--buffer_size", type=int, default=100_000)
    parser.add_argument("--eps_start", type=float, default=1.0)
    parser.add_argument("--eps_min", type=float, default=0.02)
    parser.add_argument("--eps_schedule", type=str, default="linear", choices=["linear", "exponential"])
    parser.add_argument("--decay_steps", type=int, default=200_000)
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()

    train_dqn(
        agent_type=args.type,
        run_tag=args.tag,
        total_timesteps=args.steps,
        n_envs=args.envs,
        batch_size=args.batch_size,
        learning_rate=args.lr,
        target_update_interval=args.target_update,
        use_soft_update=args.soft,
        tau=args.tau,
        gradient_steps=args.grad_steps,
        buffer_capacity=args.buffer_size,
        epsilon_start=args.eps_start,
        epsilon_min=args.eps_min,
        epsilon_schedule=args.eps_schedule,
        decay_steps=args.decay_steps,
        seed=args.seed,
    )
