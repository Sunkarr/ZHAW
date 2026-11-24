# Environment & Setup

A virtual environment is configured for this lab using [`uv`](https://github.com/astral-sh/uv) with Python 3.11.

## 1. Activate the Virtual Environment

From the project root or the lab directory:

```bash
cd "Semester 7/RL/Graded Lab 2"
source .venv/bin/activate
```

## 2. Install Dependencies

Install the core dependencies required for Deep Q-Networks (DQN) and the Lunar Lander (Box2D) environment:

```bash
uv pip install torch "gymnasium[box2d]" matplotlib numpy ipykernel tqdm imageio moviepy
```

## 3. Register Jupyter Kernel

To make this virtual environment available inside Jupyter notebooks / VS Code / Cursor:

```bash
python -m ipykernel install --user --name rl-graded-lab-2 --display-name "Python 3.11 (RL Graded Lab 2)"
```
