"""
Evaluation and Video Recording Script for trained DQN LunarLander agents.
Evaluates agent on 10 test episodes and generates replay videos.
"""

import os
import argparse
from typing import Tuple, List, Dict, Any
import numpy as np
import gymnasium as gym
import imageio

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

from src import DQNAgent, get_device


def evaluate_agent(
    model_path: str,
    n_episodes: int = 10,
    seed: int = 123,
    dueling: bool = False,
    double_dqn: bool = False,
) -> Tuple[float, float, List[float], Dict[str, Any]]:
    """
    Evaluates agent on n_episodes evaluation episodes without exploration.
    Returns:
        (mean_reward, std_reward, rewards_list, stats)
    """
    # Auto-detect architecture flags from saved checkpoint
    import torch
    ckpt = torch.load(model_path, map_location="cpu")
    dueling = ckpt.get("dueling", dueling)
    double_dqn = ckpt.get("double_dqn", double_dqn)

    agent = DQNAgent(
        state_dim=8,
        action_dim=4,
        dueling=dueling,
        double_dqn=double_dqn,
        seed=seed,
    )
    agent.load(model_path)

    env = gym.make("LunarLander-v2")
    rewards = []
    successes = 0
    crashes = 0

    for ep in range(n_episodes):
        state, _ = env.reset(seed=seed + ep)
        ep_reward = 0.0
        done = False

        while not done:
            action = agent.select_action(state, evaluate=True)
            next_state, reward, terminated, truncated, _ = env.step(action)
            ep_reward += reward
            done = terminated or truncated
            state = next_state

        rewards.append(ep_reward)
        if ep_reward >= 200.0:
            successes += 1
        elif ep_reward < -50.0:
            crashes += 1

    env.close()

    mean_reward = float(np.mean(rewards))
    std_reward = float(np.std(rewards))
    stats = {
        "mean_reward": mean_reward,
        "std_reward": std_reward,
        "success_rate": successes / n_episodes,
        "crash_rate": crashes / n_episodes,
        "episodes": rewards,
    }

    return mean_reward, std_reward, rewards, stats


def record_video(
    model_path: str,
    output_video_path: str = "videos/trained_agent.mp4",
    seed: int = 42,
    dueling: bool = False,
    double_dqn: bool = False,
    fps: int = 50,
) -> float:
    """
    Renders and records an episode of the trained agent into an MP4 video.
    """
    os.makedirs(os.path.dirname(output_video_path) or ".", exist_ok=True)

    # Auto-detect architecture flags from saved checkpoint
    import torch
    ckpt = torch.load(model_path, map_location="cpu")
    dueling = ckpt.get("dueling", dueling)
    double_dqn = ckpt.get("double_dqn", double_dqn)

    agent = DQNAgent(
        state_dim=8,
        action_dim=4,
        dueling=dueling,
        double_dqn=double_dqn,
        seed=seed,
    )
    agent.load(model_path)

    env = gym.make("LunarLander-v2", render_mode="rgb_array")
    state, _ = env.reset(seed=seed)
    frames = []
    total_reward = 0.0
    done = False

    while not done:
        frame = env.render()
        frames.append(frame)

        action = agent.select_action(state, evaluate=True)
        next_state, reward, terminated, truncated, _ = env.step(action)
        total_reward += reward
        done = terminated or truncated
        state = next_state

    # Add last frame
    frames.append(env.render())
    env.close()

    # Save to MP4 using imageio
    imageio.mimsave(output_video_path, frames, fps=fps)
    print(f"Video saved to: {output_video_path} (Episode Reward: {total_reward:.1f}, Frames: {len(frames)})")

    return total_reward


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=str, default="models/vanilla_dqn_best.pt")
    parser.add_argument("--episodes", type=int, default=10)
    parser.add_argument("--video", action="store_true")
    parser.add_argument("--video_out", type=str, default="videos/vanilla_dqn_replay.mp4")
    parser.add_argument("--dueling", action="store_true")
    parser.add_argument("--double", action="store_true")
    args = parser.parse_args()

    if os.path.exists(args.model):
        mean_r, std_r, rewards, stats = evaluate_agent(
            model_path=args.model,
            n_episodes=args.episodes,
            dueling=args.dueling,
            double_dqn=args.double,
        )
        print(f"\nEvaluation ({args.episodes} episodes):")
        print(f"Mean Reward: {mean_r:.2f} +/- {std_r:.2f}")
        print(f"Success Rate: {stats['success_rate']*100:.1f}%")
        print(f"Crash Rate: {stats['crash_rate']*100:.1f}%")

        if args.video:
            record_video(
                model_path=args.model,
                output_video_path=args.video_out,
                dueling=args.dueling,
                double_dqn=args.double,
            )
    else:
        print(f"Model path does not exist: {args.model}")
