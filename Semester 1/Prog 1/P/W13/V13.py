import numpy as np
import matplotlib.pyplot as plt
import random

# Generate a random size for x and y
size = random.randint(1, 100)

# Define the variables
x = np.arange(0, size)
y = np.arange(0, size)

# Create a scatter plot with marker style 'o'
plt.scatter(x, y, marker='o')

# Add labels and title
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Scatter Plot of X and Y')

# Display the plot
plt.show()
