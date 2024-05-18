import math

def funktion(t, x):
    return math.cos(t+x) + math.sin(t-x)

x_start = 0
t_start = 0
t_ziel = 1
n = 10000

# Step size
h = (t_ziel - t_start) / n

# Initial values
x = x_start
t = t_start

print(f"Step 0: t = {t:.3f}, x = {x:.3f}")

# Euler method loop
for i in range(n):
    x = x + h * funktion(t, x)
    print(f"Step {i + 1}: t = {t:.3f}, x = {x:.3f}")
    t = t + h
