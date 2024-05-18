import scipy.stats as stats
import seaborn as sns
import matplotlib.pyplot as plt

# Generate Poisson-distributed data
data_poisson = stats.poisson.rvs(mu=3, size=10000)

# Plot the distribution
ax = sns.histplot(data_poisson,
                  bins=30,
                  kde=False,
                  color='skyblue',
                  edgecolor='black',
                  linewidth=1)

ax.set(xlabel='Poisson Distribution', ylabel='Frequency')

# Display the plot
plt.show()
