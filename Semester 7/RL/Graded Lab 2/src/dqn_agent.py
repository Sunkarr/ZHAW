"""
DQN Agent Implementation for LunarLander.
Supports:
- Vanilla DQN (Mnih et al., 2015)
- Double DQN (Van Hasselt et al., 2016)
- Dueling DQN (Wang et al., 2016)
- Soft target updates (Polyak averaging) or hard target updates
- Apple Silicon (Metal/MPS), CUDA, and CPU execution
"""

from typing import Union, Optional, Dict, Any
import numpy as np
import torch
import torch.nn.functional as F
import torch.optim as optim

from .networks import QNetwork, DuelingQNetwork, get_device
from .replay_buffer import ReplayBuffer


class DQNAgent:
    """
    Standardized Deep Q-Network Agent.
    Implements:
        actions = agent.select_action(states)
    """

    def __init__(
        self,
        state_dim: int = 8,
        action_dim: int = 4,
        hidden_dim: int = 128,
        learning_rate: float = 5e-4,
        gamma: float = 0.99,
        tau: float = 1e-3,
        use_soft_update: bool = False,
        target_update_interval: int = 1000,
        double_dqn: bool = False,
        dueling: bool = False,
        buffer_capacity: int = 100_000,
        batch_size: int = 64,
        epsilon_start: float = 1.0,
        epsilon_min: float = 0.01,
        epsilon_decay: float = 0.996,
        device: Optional[torch.device] = None,
        seed: int = 42,
    ):
        self.state_dim = state_dim
        self.action_dim = action_dim
        self.gamma = gamma
        self.tau = tau
        self.use_soft_update = use_soft_update
        self.target_update_interval = target_update_interval
        self.double_dqn = double_dqn
        self.dueling = dueling
        self.batch_size = batch_size

        # Exploration schedule
        self.epsilon_start = epsilon_start
        self.epsilon = epsilon_start
        self.epsilon_min = epsilon_min
        self.epsilon_decay = epsilon_decay

        # Device selection (defaults to MPS if on Apple Silicon Mac)
        self.device = device or get_device()
        self.rng = np.random.default_rng(seed)
        torch.manual_seed(seed)

        # Network selection (Standard MLP vs Dueling)
        network_cls = DuelingQNetwork if dueling else QNetwork
        self.online_net = network_cls(state_dim, action_dim, hidden_dim).to(self.device)
        self.target_net = network_cls(state_dim, action_dim, hidden_dim).to(self.device)
        self.target_net.load_state_dict(self.online_net.state_dict())
        self.target_net.eval()

        self.optimizer = optim.Adam(self.online_net.parameters(), lr=learning_rate)
        self.replay_buffer = ReplayBuffer(capacity=buffer_capacity, state_dim=state_dim, seed=seed)

        self.total_steps = 0
        self.train_steps = 0

    def select_action(
        self,
        states: Union[np.ndarray, torch.Tensor],
        evaluate: bool = False,
    ) -> Union[int, np.ndarray]:
        """
        Standard interface required by the lab:
            actions = agent.select_action(states)
        Supports both single state of shape (8,) and vectorized batch of shape (N, 8).

        Args:
            states: np.ndarray or torch.Tensor of shape (8,) or (N, 8)
            evaluate: If True, executes pure greedy policy without exploration.

        Returns:
            int action if single state, or np.ndarray of shape (N,) if vectorized.
        """
        # Determine whether input is single observation or batch
        if isinstance(states, np.ndarray):
            states_np = states
        else:
            states_np = states.detach().cpu().numpy()

        is_single = states_np.ndim == 1

        if is_single:
            states_np = states_np[np.newaxis, :]

        n_samples = states_np.shape[0]

        # Epsilon-greedy action selection
        if not evaluate and self.rng.random() < self.epsilon:
            # Random exploration for the batch
            actions = self.rng.integers(0, self.action_dim, size=n_samples)
        else:
            # Greedy action from online network
            states_tensor = torch.from_numpy(states_np).float().to(self.device)
            with torch.no_grad():
                q_values = self.online_net(states_tensor)
                actions = q_values.argmax(dim=-1).cpu().numpy()

        # If epsilon exploration triggered on a vectorized batch, individual random exploration:
        if not evaluate and n_samples > 1 and self.epsilon > self.epsilon_min:
            # Per-env random roll for vectorized environments
            rand_mask = self.rng.random(size=n_samples) < self.epsilon
            random_actions = self.rng.integers(0, self.action_dim, size=n_samples)
            actions = np.where(rand_mask, random_actions, actions)

        if is_single:
            return int(actions[0])
        return actions

    def step(
        self,
        states: np.ndarray,
        actions: Union[int, np.ndarray],
        rewards: Union[float, np.ndarray],
        next_states: np.ndarray,
        dones: Union[bool, np.ndarray],
    ) -> Optional[Dict[str, float]]:
        """
        Record transition(s) in replay buffer and perform training step if buffer is ready.
        Supports single transition and vectorized transitions.
        """
        # Vectorized check
        if isinstance(rewards, (np.ndarray, list)):
            actions_arr = np.asarray(actions, dtype=np.int64)
            rewards_arr = np.asarray(rewards, dtype=np.float32)
            dones_arr = np.asarray(dones, dtype=np.float32)
            self.replay_buffer.add_batch(states, actions_arr, rewards_arr, next_states, dones_arr)
            step_increment = len(rewards_arr)
        else:
            self.replay_buffer.add(states, int(actions), float(rewards), next_states, bool(dones))
            step_increment = 1

        self.total_steps += step_increment

        metrics = None
        # Train once buffer has sufficient experiences
        if len(self.replay_buffer) >= self.batch_size:
            metrics = self.train_step()

        return metrics

    def train_step(self) -> Dict[str, float]:
        """
        Sample a mini-batch from replay buffer, compute Q loss and optimize.
        """
        states, actions, rewards, next_states, dones = self.replay_buffer.sample(
            self.batch_size, self.device
        )

        # 1. Compute current Q values: Q(s, a)
        current_q = self.online_net(states).gather(1, actions.unsqueeze(1)).squeeze(1)

        # 2. Compute target Q values
        with torch.no_grad():
            if self.double_dqn:
                # Double DQN: Action selection from online net, evaluation from target net
                best_actions = self.online_net(next_states).argmax(dim=-1, keepdim=True)
                next_q = self.target_net(next_states).gather(1, best_actions).squeeze(1)
            else:
                # Vanilla DQN: Standard Bellman max_a' Q_target(s', a')
                next_q = self.target_net(next_states).max(dim=-1)[0]

            # Bellman equation: y = r + gamma * (1 - done) * Q_next
            target_q = rewards + (self.gamma * (1.0 - dones) * next_q)

        # 3. Compute loss (Smooth L1 / Huber loss is standard for stability in DQN)
        loss = F.smooth_l1_loss(current_q, target_q)

        # 4. Optimization
        self.optimizer.zero_grad()
        loss.backward()
        # Gradient clipping to prevent gradient explosion
        torch.nn.utils.clip_grad_norm_(self.online_net.parameters(), max_norm=10.0)
        self.optimizer.step()

        self.train_steps += 1

        # 5. Target Network Update
        if self.use_soft_update:
            # Soft update: theta_target = tau * theta_online + (1 - tau) * theta_target
            for target_param, online_param in zip(
                self.target_net.parameters(), self.online_net.parameters()
            ):
                target_param.data.copy_(
                    self.tau * online_param.data + (1.0 - self.tau) * target_param.data
                )
        else:
            # Hard periodic update
            if self.train_steps % self.target_update_interval == 0:
                self.target_net.load_state_dict(self.online_net.state_dict())

        return {
            "loss": loss.item(),
            "mean_q": current_q.mean().item(),
            "epsilon": self.epsilon,
        }

    def decay_epsilon(self) -> None:
        """Decay exploration rate epsilon multiplicatively."""
        self.epsilon = max(self.epsilon_min, self.epsilon * self.epsilon_decay)

    def update_epsilon_linear(self, current_step: int, total_decay_steps: int = 300_000) -> float:
        """Decay exploration rate epsilon linearly based on total environment steps."""
        fraction = min(1.0, current_step / max(1, total_decay_steps))
        self.epsilon = max(self.epsilon_min, self.epsilon_start - fraction * (self.epsilon_start - self.epsilon_min))
        return self.epsilon

    def save(self, filepath: str) -> None:
        """Save model checkpoint."""
        torch.save(
            {
                "online_state_dict": self.online_net.state_dict(),
                "target_state_dict": self.target_net.state_dict(),
                "optimizer_state_dict": self.optimizer.state_dict(),
                "total_steps": self.total_steps,
                "train_steps": self.train_steps,
                "epsilon": self.epsilon,
                "dueling": self.dueling,
                "double_dqn": self.double_dqn,
            },
            filepath,
        )

    def load(self, filepath: str) -> None:
        """Load model checkpoint."""
        checkpoint = torch.load(filepath, map_location=self.device)
        self.online_net.load_state_dict(checkpoint["online_state_dict"])
        self.target_net.load_state_dict(checkpoint["target_state_dict"])
        self.optimizer.load_state_dict(checkpoint["optimizer_state_dict"])
        self.total_steps = checkpoint.get("total_steps", 0)
        self.train_steps = checkpoint.get("train_steps", 0)
        self.epsilon = checkpoint.get("epsilon", self.epsilon_min)
