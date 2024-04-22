import matplotlib.pyplot as plt
import numpy as np

# Degree input
degree = 0

# Convert degree to radians
radian = np.radians(degree)

# Create a figure and axes
fig, ax = plt.subplots(figsize=(6, 6))

# Create a circle
circle = plt.Circle((0, 0), 1, fill=False, color='black', linewidth=2)
ax.add_artist(circle)

# Draw a line from the center to the specified degree
x1, y1 = np.cos(radian), np.sin(radian)
ax.arrow(0, 0, x1, y1, head_width=0.05, head_length=0.1, fc='r', ec='r')

# Set axis limits and aspect ratio
ax.set_xlim(-1.2, 1.2)
ax.set_ylim(-1.2, 1.2)
ax.set_aspect('equal')

# Set labels and title
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title(f'Circle Plot ({degree} degrees)')

# Remove axis ticks
ax.set_xticks([])
ax.set_yticks([])

# Show the plot
plt.show()