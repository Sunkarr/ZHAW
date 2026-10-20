import sys
from pathlib import Path
from typing import NamedTuple

import gymnasium as gym
from gymnasium.envs.toy_text.frozen_lake import generate_random_map
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set_theme(style="whitegrid")

class Params(NamedTuple):
    total_episodes: int
    alpha: float
    gamma: float
    epsilon_start: float
    epsilon_min: float
    epsilon_decay_rate: float
    map_size: int
    seed: int
    is_slippery: bool
    n_runs: int
    action_size: int
    state_size: int
    proba_frozen: float
    savefig_folder: Path


# -------------------------------------------------------------
# Agent Definitions
# -------------------------------------------------------------
class MonteCarloRandomPolicyAgent:
    def __init__(self, env: gym.Env, params: Params):
        self.env = env
        self.params = params
        self.gamma = params.gamma
        self.state_value = np.zeros(self.params.state_size)
        self.returns_sum = np.zeros(self.params.state_size)
        self.returns_count = np.zeros(self.params.state_size)

    def reset(self):
        self.state_value = np.zeros(self.params.state_size)
        self.returns_sum = np.zeros(self.params.state_size)
        self.returns_count = np.zeros(self.params.state_size)

    def choose_action(self, state: int) -> int:
        return int(self.env.action_space.sample())

    def update_state_value(self, episode: list):
        G = 0.0
        for t in reversed(range(len(episode))):
            state, action, reward = episode[t]
            G = self.gamma * G + reward
            self.returns_sum[state] += G
            self.returns_count[state] += 1
            self.state_value[state] = self.returns_sum[state] / self.returns_count[state]


class IncrementalMonteCarloControlAgent:
    def __init__(self, env: gym.Env, params: Params):
        self.env = env
        self.params = params
        self.gamma = params.gamma
        self.alpha = params.alpha
        self.epsilon_start = params.epsilon_start
        self.epsilon_min = params.epsilon_min
        self.epsilon_decay_rate = params.epsilon_decay_rate
        self.reset()

    def reset(self):
        self.q_values = np.zeros((self.params.state_size, self.params.action_size), dtype=float)

    @property
    def state_value(self) -> np.ndarray:
        return np.max(self.q_values, axis=1)

    def choose_action(self, state: int, episode: int) -> int:
        epsilon = max(
            self.epsilon_min,
            self.epsilon_start * np.exp(-self.epsilon_decay_rate * episode),
        )
        if np.random.rand() < epsilon:
            return int(self.env.action_space.sample())
        else:
            q = self.q_values[state]
            max_q = np.max(q)
            actions_with_max_q = np.where(q == max_q)[0]
            return int(np.random.choice(actions_with_max_q))

    def update_q_values(self, episode: list):
        G = 0.0
        for state, action, reward in reversed(episode):
            G = self.gamma * G + reward
            self.q_values[state, action] += self.alpha * (G - self.q_values[state, action])


class QLearningAgent:
    def __init__(self, env: gym.Env, params: Params):
        self.env = env
        self.params = params
        self.gamma = params.gamma
        self.alpha = params.alpha
        self.epsilon_start = params.epsilon_start
        self.epsilon_min = params.epsilon_min
        self.epsilon_decay_rate = params.epsilon_decay_rate
        self.reset()

    def reset(self):
        self.q_values = np.zeros((self.params.state_size, self.params.action_size), dtype=float)

    @property
    def state_value(self) -> np.ndarray:
        return np.max(self.q_values, axis=1)

    def choose_action(self, state: int, episode: int) -> int:
        epsilon = max(
            self.epsilon_min,
            self.epsilon_start * np.exp(-self.epsilon_decay_rate * episode),
        )
        if np.random.rand() < epsilon:
            return int(self.env.action_space.sample())
        else:
            q = self.q_values[state]
            max_q = np.max(q)
            actions_with_max_q = np.where(q == max_q)[0]
            return int(np.random.choice(actions_with_max_q))

    def update_q_values(self, state: int, action: int, reward: float, next_state: int, done: bool):
        max_next_q = 0.0 if done else np.max(self.q_values[next_state])
        td_target = reward + self.gamma * max_next_q
        td_error = td_target - self.q_values[state, action]
        self.q_values[state, action] += self.alpha * td_error


# -------------------------------------------------------------
# Runner Functions
# -------------------------------------------------------------
def run_mc_random(env, params):
    rewards = np.zeros((params.total_episodes, params.n_runs))
    steps = np.zeros((params.total_episodes, params.n_runs))
    state_values = np.zeros((params.n_runs, params.state_size))
    agent = MonteCarloRandomPolicyAgent(env, params)

    for run in range(params.n_runs):
        agent.reset()
        for episode in range(params.total_episodes):
            state, info = env.reset()
            done = False
            history = []
            while not done:
                action = agent.choose_action(state)
                next_state, reward, terminated, truncated, info = env.step(action)
                done = terminated or truncated
                history.append((state, action, reward))
                state = next_state
            agent.update_state_value(history)
            rewards[episode, run] = sum(r for _, _, r in history)
            steps[episode, run] = len(history)
        state_values[run, :] = agent.state_value
    return rewards, steps, state_values


def run_mc_control(env, params):
    rewards = np.zeros((params.total_episodes, params.n_runs))
    steps = np.zeros((params.total_episodes, params.n_runs))
    state_values = np.zeros((params.n_runs, params.state_size))
    agent = IncrementalMonteCarloControlAgent(env, params)

    for run in range(params.n_runs):
        agent.reset()
        for episode in range(params.total_episodes):
            state, info = env.reset()
            done = False
            history = []
            while not done:
                action = agent.choose_action(state, episode)
                next_state, reward, terminated, truncated, info = env.step(action)
                done = terminated or truncated
                history.append((state, action, reward))
                state = next_state
            agent.update_q_values(history)
            rewards[episode, run] = sum(r for _, _, r in history)
            steps[episode, run] = len(history)
        state_values[run, :] = agent.state_value
    return rewards, steps, state_values


def run_q_learning(env, params):
    rewards = np.zeros((params.total_episodes, params.n_runs))
    steps = np.zeros((params.total_episodes, params.n_runs))
    state_values = np.zeros((params.n_runs, params.state_size))
    agent = QLearningAgent(env, params)

    for run in range(params.n_runs):
        agent.reset()
        for episode in range(params.total_episodes):
            state, info = env.reset()
            done = False
            tot_r = 0.0
            st_count = 0
            while not done:
                action = agent.choose_action(state, episode)
                next_state, reward, terminated, truncated, info = env.step(action)
                done = terminated or truncated
                agent.update_q_values(state, action, reward, next_state, done)
                tot_r += reward
                st_count += 1
                state = next_state
            rewards[episode, run] = tot_r
            steps[episode, run] = st_count
        state_values[run, :] = agent.state_value
    return rewards, steps, state_values


# -------------------------------------------------------------
# Main execution & figure generation
# -------------------------------------------------------------
def main():
    fig_dir = Path("Semester 7/RL/Graded Lab 1/figures")
    fig_dir.mkdir(parents=True, exist_ok=True)

    base_params = {
        "total_episodes": 2000,
        "alpha": 0.1,
        "gamma": 0.95,
        "epsilon_start": 1.0,
        "epsilon_min": 0.05,
        "epsilon_decay_rate": 0.001,
        "seed": 123,
        "is_slippery": True,
        "n_runs": 20,
        "proba_frozen": 0.9,
        "savefig_folder": fig_dir,
    }

    print("Initializing 4x4 and 11x11 environments...")
    # 4x4
    env_4x4 = gym.make(
        "FrozenLake-v1",
        is_slippery=base_params["is_slippery"],
        render_mode="rgb_array",
        desc=generate_random_map(size=4, p=base_params["proba_frozen"], seed=base_params["seed"]),
    )
    p_4x4 = Params(**base_params, map_size=4, action_size=int(env_4x4.action_space.n), state_size=int(env_4x4.observation_space.n))

    # 11x11
    env_11x11 = gym.make(
        "FrozenLake-v1",
        is_slippery=base_params["is_slippery"],
        render_mode="rgb_array",
        desc=generate_random_map(size=11, p=base_params["proba_frozen"], seed=base_params["seed"]),
    )
    p_11x11 = Params(**base_params, map_size=11, action_size=int(env_11x11.action_space.n), state_size=int(env_11x11.observation_space.n))

    # Plot initial maps side by side
    fig, axes = plt.subplots(1, 2, figsize=(9, 4.5))
    env_4x4.reset(seed=p_4x4.seed)
    axes[0].imshow(env_4x4.render())
    axes[0].axis("off")
    axes[0].set_title(r"$\mathbf{4 \times 4\ Map}$ (16 States)", fontsize=11, fontweight="bold")

    env_11x11.reset(seed=p_11x11.seed)
    axes[1].imshow(env_11x11.render())
    axes[1].axis("off")
    axes[1].set_title(r"$\mathbf{11 \times 11\ Map}$ (121 States)", fontsize=11, fontweight="bold")
    plt.tight_layout()
    fig.savefig(fig_dir / "fig1_env_maps.png", dpi=300)
    plt.close(fig)
    print("Saved fig1_env_maps.png")

    # ----------------- Run Simulations -----------------
    print("Running Task 1: Monte Carlo Random Policy (4x4 & 11x11)...")
    r_mc_4, s_mc_4, v_mc_4 = run_mc_random(env_4x4, p_4x4)
    r_mc_11, s_mc_11, v_mc_11 = run_mc_random(env_11x11, p_11x11)

    print("Running Task 2: Incremental MC Control (4x4 & 11x11)...")
    r_mcc_4, s_mcc_4, v_mcc_4 = run_mc_control(env_4x4, p_4x4)
    r_mcc_11, s_mcc_11, v_mcc_11 = run_mc_control(env_11x11, p_11x11)

    print("Running Task 3: Q-Learning (4x4 & 11x11)...")
    r_ql_4, s_ql_4, v_ql_4 = run_q_learning(env_4x4, p_4x4)
    r_ql_11, s_ql_11, v_ql_11 = run_q_learning(env_11x11, p_11x11)

    # ----------------- Figure Generation -----------------
    window = 100

    def get_rolling(arr):
        df = pd.DataFrame(arr)
        r = df.rolling(window=window, min_periods=1).mean()
        return r.mean(axis=1), r.std(axis=1).fillna(0)

    # Function to plot dual performance (4x4 vs 11x11)
    def plot_dual_perf(r_4, s_4, r_11, s_11, algo_title, fname):
        m_s4, std_s4 = get_rolling(s_4)
        m_r4, std_r4 = get_rolling(r_4)
        m_s11, std_s11 = get_rolling(s_11)
        m_r11, std_r11 = get_rolling(r_11)
        eps = np.arange(len(m_s4))

        fig, axes = plt.subplots(1, 2, figsize=(10, 3.8))
        # 1. Trajectory length
        axes[0].plot(eps, m_s4, label=r"$4 \times 4$ (Mean)", color="#1f77b4", lw=1.8)
        axes[0].fill_between(eps, m_s4 - std_s4, m_s4 + std_s4, color="#1f77b4", alpha=0.15)
        axes[0].plot(eps, m_s11, label=r"$11 \times 11$ (Mean)", color="#d62728", lw=1.8, linestyle="--")
        axes[0].fill_between(eps, m_s11 - std_s11, m_s11 + std_s11, color="#d62728", alpha=0.15)
        axes[0].set_title(f"Trajectory Length - {algo_title}", fontsize=11, fontweight="bold")
        axes[0].set_xlabel("Episode", fontsize=10)
        axes[0].set_ylabel("Steps per Episode", fontsize=10)
        axes[0].legend(loc="best", fontsize=9)
        axes[0].grid(True, linestyle="--", alpha=0.5)

        # 2. Learning curve
        axes[1].plot(eps, m_r4, label=r"$4 \times 4$ (Mean)", color="#2ca02c", lw=1.8)
        axes[1].fill_between(eps, m_r4 - std_r4, m_r4 + std_r4, color="#2ca02c", alpha=0.15)
        axes[1].plot(eps, m_r11, label=r"$11 \times 11$ (Mean)", color="#ff7f0e", lw=1.8, linestyle="--")
        axes[1].fill_between(eps, m_r11 - std_r11, m_r11 + std_r11, color="#ff7f0e", alpha=0.15)
        axes[1].set_title(f"Learning Curve (Reward) - {algo_title}", fontsize=11, fontweight="bold")
        axes[1].set_xlabel("Episode", fontsize=10)
        axes[1].set_ylabel("Success Rate (Reward)", fontsize=10)
        axes[1].set_ylim([-0.05, 1.05])
        axes[1].legend(loc="best", fontsize=9)
        axes[1].grid(True, linestyle="--", alpha=0.5)

        plt.tight_layout()
        fig.savefig(fig_dir / fname, dpi=300)
        plt.close(fig)
        print(f"Saved {fname}")

    # Plot dual performance for all 3 tasks
    plot_dual_perf(r_mc_4, s_mc_4, r_mc_11, s_mc_11, "Monte Carlo (Random Policy)", "fig2_mc_random_perf.png")
    plot_dual_perf(r_mcc_4, s_mcc_4, r_mcc_11, s_mcc_11, "Incremental MC Control", "fig4_mc_control_perf.png")
    plot_dual_perf(r_ql_4, s_ql_4, r_ql_11, s_ql_11, "Q-Learning", "fig6_q_learning_perf.png")

    # Function to plot dual heatmaps (4x4 and 11x11)
    def plot_dual_heatmaps(v_4, v_11, env_4, env_11, p_4, p_11, algo_title, fname):
        v_mean_4 = np.mean(v_4, axis=0).reshape((4, 4))
        desc_4 = env_4.unwrapped.desc.astype(str)

        v_mean_11 = np.mean(v_11, axis=0).reshape((11, 11))
        desc_11 = env_11.unwrapped.desc.astype(str)

        fig, axes = plt.subplots(1, 2, figsize=(11, 4.8), gridspec_kw={"width_ratios": [1, 1.25]})

        # 4x4 Heatmap
        sns.heatmap(
            v_mean_4,
            annot=True,
            fmt=".3f",
            cmap="viridis",
            cbar=True,
            linewidths=1,
            linecolor="white",
            annot_kws={"size": 9, "weight": "bold"},
            ax=axes[0],
        )
        for r in range(4):
            for c in range(4):
                axes[0].text(c + 0.5, r + 0.2, desc_4[r, c], ha="center", va="center", fontsize=10,
                             color="white" if v_mean_4[r, c] < 0.2 else "black", weight="heavy")
        axes[0].set_title(r"$\mathbf{4 \times 4}$ Value Function $V(s)$", fontsize=11, fontweight="bold")
        axes[0].set_xlabel("Column")
        axes[0].set_ylabel("Row")

        # 11x11 Heatmap
        sns.heatmap(
            v_mean_11,
            annot=False,
            cmap="viridis",
            cbar=True,
            linewidths=0.5,
            linecolor="white",
            ax=axes[1],
        )
        for r in range(11):
            for c in range(11):
                sym = desc_11[r, c]
                if sym in ["S", "G", "H"]:
                    axes[1].text(c + 0.5, r + 0.5, sym, ha="center", va="center", fontsize=7.5,
                                 color="white" if v_mean_11[r, c] < 0.2 else "black", weight="heavy")
        axes[1].set_title(r"$\mathbf{11 \times 11}$ Value Function $V(s)$", fontsize=11, fontweight="bold")
        axes[1].set_xlabel("Column")
        axes[1].set_ylabel("Row")

        plt.suptitle(f"Learned Value Functions $V(s)$ – {algo_title}", fontsize=13, fontweight="bold", y=0.98)
        plt.tight_layout()
        fig.savefig(fig_dir / fname, dpi=300)
        plt.close(fig)
        print(f"Saved {fname}")

    plot_dual_heatmaps(v_mc_4, v_mc_11, env_4x4, env_11x11, p_4x4, p_11x11, "Monte Carlo (Random Policy)", "fig3_mc_random_heatmaps.png")
    plot_dual_heatmaps(v_mcc_4, v_mcc_11, env_4x4, env_11x11, p_4x4, p_11x11, "Incremental MC Control", "fig5_mc_control_heatmaps.png")
    plot_dual_heatmaps(v_ql_4, v_ql_11, env_4x4, env_11x11, p_4x4, p_11x11, "Q-Learning", "fig7_q_learning_heatmaps.png")

    # ----------------- Comparative Summary Plot -----------------
    m_r_mc4, _ = get_rolling(r_mc_4)
    m_r_mcc4, _ = get_rolling(r_mcc_4)
    m_r_ql4, _ = get_rolling(r_ql_4)

    m_r_mc11, _ = get_rolling(r_mc_11)
    m_r_mcc11, _ = get_rolling(r_mcc_11)
    m_r_ql11, _ = get_rolling(r_ql_11)

    eps = np.arange(len(m_r_mc4))

    fig, axes = plt.subplots(1, 2, figsize=(11, 4))
    # 4x4 comparison
    axes[0].plot(eps, m_r_mc4, label="MC Random Policy", color="#7f7f7f", lw=1.8, linestyle=":")
    axes[0].plot(eps, m_r_mcc4, label="Incremental MC Control", color="#ff7f0e", lw=2)
    axes[0].plot(eps, m_r_ql4, label="Q-Learning", color="#2ca02c", lw=2)
    axes[0].set_title(r"$\mathbf{4 \times 4\ Environment}$ – Learning Comparison", fontsize=11, fontweight="bold")
    axes[0].set_xlabel("Episode", fontsize=10)
    axes[0].set_ylabel("Rolling Mean Success Rate", fontsize=10)
    axes[0].set_ylim([-0.05, 1.05])
    axes[0].legend(loc="upper left", fontsize=9)
    axes[0].grid(True, linestyle="--", alpha=0.5)

    # 11x11 comparison
    axes[1].plot(eps, m_r_mc11, label="MC Random Policy", color="#7f7f7f", lw=1.8, linestyle=":")
    axes[1].plot(eps, m_r_mcc11, label="Incremental MC Control", color="#ff7f0e", lw=2)
    axes[1].plot(eps, m_r_ql11, label="Q-Learning", color="#2ca02c", lw=2)
    axes[1].set_title(r"$\mathbf{11 \times 11\ Environment}$ – Scaling Comparison", fontsize=11, fontweight="bold")
    axes[1].set_xlabel("Episode", fontsize=10)
    axes[1].set_ylabel("Rolling Mean Success Rate", fontsize=10)
    axes[1].set_ylim([-0.05, 0.4])
    axes[1].legend(loc="upper left", fontsize=9)
    axes[1].grid(True, linestyle="--", alpha=0.5)

    plt.tight_layout()
    fig.savefig(fig_dir / "fig8_algorithm_comparison.png", dpi=300)
    plt.close(fig)
    print("Saved fig8_algorithm_comparison.png")

    # Print summary statistics
    print("\n=== SUMMARY METRICS (Last 200 Episodes Mean) ===")
    print(f"4x4 MC Random Success Rate:     {np.mean(r_mc_4[-200:]):.4f}")
    print(f"4x4 MC Control Success Rate:    {np.mean(r_mcc_4[-200:]):.4f}")
    print(f"4x4 Q-Learning Success Rate:    {np.mean(r_ql_4[-200:]):.4f}")
    print(f"11x11 MC Random Success Rate:   {np.mean(r_mc_11[-200:]):.4f}")
    print(f"11x11 MC Control Success Rate:  {np.mean(r_mcc_11[-200:]):.4f}")
    print(f"11x11 Q-Learning Success Rate:  {np.mean(r_ql_11[-200:]):.4f}")

if __name__ == "__main__":
    main()
