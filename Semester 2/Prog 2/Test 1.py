import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# Parameters for the distributions
mu1, sigma1 = 50, 10
mu2, sigma2 = 30, 5

# Generate data for the two distributions
data1 = np.random.normal(mu1, sigma1, 1000)
data2 = np.random.normal(mu2, sigma2, 1000)

# Standardize the data
data1_standardized = (data1 - mu1) / sigma1
data2_standardized = (data2 - mu2) / sigma2

# Plotting
fig, axes = plt.subplots(2, 2, figsize=(12, 8))

# Original distributions
axes[0, 0].hist(data1, bins=30, alpha=0.5, label='Verteilung 1')
axes[0, 0].hist(data2, bins=30, alpha=0.5, label='Verteilung 2')
axes[0, 0].set_title('Originalverteilungen')
axes[0, 0].legend()

# Standardized distributions
axes[0, 1].hist(data1_standardized, bins=30, alpha=0.5, label='Verteilung 1 (standardisiert)')
axes[0, 1].hist(data2_standardized, bins=30, alpha=0.5, label='Verteilung 2 (standardisiert)')
axes[0, 1].set_title('Standardisierte Verteilungen')
axes[0, 1].legend()

# Probability density functions (PDFs) for original distributions
x = np.linspace(mu1 - 4*sigma1, mu1 + 4*sigma1, 1000)
y1 = norm.pdf(x, mu1, sigma1)
axes[1, 0].plot(x, y1, label='Verteilung 1')
x = np.linspace(mu2 - 4*sigma2, mu2 + 4*sigma2, 1000)
y2 = norm.pdf(x, mu2, sigma2)
axes[1, 0].plot(x, y2, label='Verteilung 2')
axes[1, 0].set_title('PDFs der Originalverteilungen')
axes[1, 0].legend()

# PDFs for standardized distributions
x = np.linspace(-4, 4, 1000)
y1_standardized = norm.pdf(x, 0, 1)
y2_standardized = norm.pdf(x, 0, 1)
axes[1, 1].plot(x, y1_standardized, label='Verteilung 1 (standardisiert)')
axes[1, 1].plot(x, y2_standardized, label='Verteilung 2 (standardisiert)')
axes[1, 1].set_title('PDFs der standardisierten Verteilungen')
axes[1, 1].legend()

plt.tight_layout()
plt.show()
