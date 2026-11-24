"""
High-Performance Vectorized Replay Buffer for DQN.
Supports fast batch insertion for vectorized environments (e.g. n_envs=16)
and uniform random mini-batch sampling directly onto PyTorch tensors.
"""

from typing import Tuple
import numpy as np
import torch


class ReplayBuffer:
    """
    Fixed-size cyclic replay buffer with pre-allocated NumPy storage.
    Optimized for vectorized environments and PyTorch GPU/MPS training.
    """

    def __init__(
        self,
        capacity: int = 100_000,
        state_dim: int = 8,
        action_dim: int = 1,
        seed: int = 42,
    ):
        self.capacity = capacity
        self.state_dim = state_dim
        self.pos = 0
        self.size = 0
        self.rng = np.random.default_rng(seed)

        # Pre-allocate contiguous NumPy arrays for maximum memory throughput
        self.states = np.zeros((capacity, state_dim), dtype=np.float32)
        self.actions = np.zeros(capacity, dtype=np.int64)
        self.rewards = np.zeros(capacity, dtype=np.float32)
        self.next_states = np.zeros((capacity, state_dim), dtype=np.float32)
        self.dones = np.zeros(capacity, dtype=np.float32)

    def add(
        self,
        state: np.ndarray,
        action: int,
        reward: float,
        next_state: np.ndarray,
        done: bool,
    ) -> None:
        """Add a single transition (s, a, r, s', done)."""
        self.states[self.pos] = state
        self.actions[self.pos] = action
        self.rewards[self.pos] = reward
        self.next_states[self.pos] = next_state
        self.dones[self.pos] = float(done)

        self.pos = (self.pos + 1) % self.capacity
        self.size = min(self.size + 1, self.capacity)

    def add_batch(
        self,
        states: np.ndarray,
        actions: np.ndarray,
        rewards: np.ndarray,
        next_states: np.ndarray,
        dones: np.ndarray,
    ) -> None:
        """
        Add a batch of transitions from a vectorized environment (e.g. shape (16, ...)).
        Handles ring buffer wrap-around efficiently with slicing.
        """
        n = len(states)
        if self.pos + n <= self.capacity:
            idx = slice(self.pos, self.pos + n)
            self.states[idx] = states
            self.actions[idx] = actions
            self.rewards[idx] = rewards
            self.next_states[idx] = next_states
            self.dones[idx] = dones.astype(np.float32)
            self.pos = (self.pos + n) % self.capacity
        else:
            # Wrap-around boundary
            first_chunk = self.capacity - self.pos
            second_chunk = n - first_chunk

            # First part up to capacity
            idx1 = slice(self.pos, self.capacity)
            self.states[idx1] = states[:first_chunk]
            self.actions[idx1] = actions[:first_chunk]
            self.rewards[idx1] = rewards[:first_chunk]
            self.next_states[idx1] = next_states[:first_chunk]
            self.dones[idx1] = dones[:first_chunk].astype(np.float32)

            # Second part from beginning
            idx2 = slice(0, second_chunk)
            self.states[idx2] = states[first_chunk:]
            self.actions[idx2] = actions[first_chunk:]
            self.rewards[idx2] = rewards[first_chunk:]
            self.next_states[idx2] = next_states[first_chunk:]
            self.dones[idx2] = dones[first_chunk:].astype(np.float32)

            self.pos = second_chunk

        self.size = min(self.size + n, self.capacity)

    def sample(
        self,
        batch_size: int,
        device: torch.device,
    ) -> Tuple[torch.Tensor, torch.Tensor, torch.Tensor, torch.Tensor, torch.Tensor]:
        """
        Sample a random batch of transitions and convert directly to PyTorch tensors.
        Returns:
            (states, actions, rewards, next_states, dones) on specified device.
        """
        indices = self.rng.integers(0, self.size, size=batch_size)

        states = torch.from_numpy(self.states[indices]).to(device)
        actions = torch.from_numpy(self.actions[indices]).to(device)
        rewards = torch.from_numpy(self.rewards[indices]).to(device)
        next_states = torch.from_numpy(self.next_states[indices]).to(device)
        dones = torch.from_numpy(self.dones[indices]).to(device)

        return states, actions, rewards, next_states, dones

    def __len__(self) -> int:
        return self.size
