"""
Neural Network Architectures for DQN on LunarLander-v2/v3.
Supports both standard QNetwork (Vanilla/Double DQN) and DuelingQNetwork.
Hardware accelerated with Apple Silicon Metal (MPS), CUDA, or CPU fallback.
"""

import torch
import torch.nn as nn
import torch.nn.functional as F


def get_device() -> torch.device:
    """Detects and returns the best available device (MPS, CUDA, or CPU)."""
    if torch.backends.mps.is_available():
        return torch.device("mps")
    elif torch.cuda.is_available():
        return torch.device("cuda")
    return torch.device("cpu")


class QNetwork(nn.Module):
    """
    Standard Deep Q-Network MLP.
    Architecture: State (8) -> Linear(hidden) -> ReLU -> Linear(hidden) -> ReLU -> Linear(action_dim)
    """

    def __init__(self, state_dim: int = 8, action_dim: int = 4, hidden_dim: int = 128):
        super().__init__()
        self.fc1 = nn.Linear(state_dim, hidden_dim)
        self.fc2 = nn.Linear(hidden_dim, hidden_dim)
        self.fc3 = nn.Linear(hidden_dim, action_dim)

    def forward(self, state: torch.Tensor) -> torch.Tensor:
        """
        Forward pass computing Q-values for all actions.
        Args:
            state: Tensor of shape (batch_size, state_dim) or (state_dim,)
        Returns:
            Tensor of shape (batch_size, action_dim) with Q-values
        """
        x = F.relu(self.fc1(state))
        x = F.relu(self.fc2(x))
        return self.fc3(x)


class DuelingQNetwork(nn.Module):
    """
    Dueling Deep Q-Network (Wang et al., 2016).
    Decomposes Q(s, a) into State Value V(s) and Action Advantage A(s, a):
        Q(s, a) = V(s) + (A(s, a) - mean_{a'}(A(s, a')))
    """

    def __init__(
        self,
        state_dim: int = 8,
        action_dim: int = 4,
        hidden_dim: int = 128,
        stream_dim: int = 64,
    ):
        super().__init__()
        # Shared feature extractor
        self.feature_fc1 = nn.Linear(state_dim, hidden_dim)
        self.feature_fc2 = nn.Linear(hidden_dim, hidden_dim)

        # State Value Stream V(s): outputs 1 scalar
        self.value_fc = nn.Linear(hidden_dim, stream_dim)
        self.value_out = nn.Linear(stream_dim, 1)

        # Advantage Stream A(s, a): outputs action_dim scalars
        self.advantage_fc = nn.Linear(hidden_dim, stream_dim)
        self.advantage_out = nn.Linear(stream_dim, action_dim)

    def forward(self, state: torch.Tensor) -> torch.Tensor:
        """
        Forward pass with mean-centered aggregation.
        """
        features = F.relu(self.feature_fc1(state))
        features = F.relu(self.feature_fc2(features))

        value = F.relu(self.value_fc(features))
        value = self.value_out(value)  # (batch_size, 1)

        advantage = F.relu(self.advantage_fc(features))
        advantage = self.advantage_out(advantage)  # (batch_size, action_dim)

        # Centered aggregation to ensure identifiability
        q_values = value + (advantage - advantage.mean(dim=-1, keepdim=True))
        return q_values
