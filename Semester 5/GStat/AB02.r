install.packages(pkgs = "car", dependencies = TRUE)
library(car)

# Aufgabe 2
# a)
kunden <- read.csv("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/kunden.csv")
q <-c(0.05, 0.25, 0.5, 0.75, 0.90, 0.975)

# Calculate qunatiles (q) of kunden$x
quantile(kunden$x, probs = q)

# b)
hist(kunden$x, breaks = 50)
par(mfrow=c(1,1))
qqPlot(kunden$x)

# c) Check if Data is exponentially distributed with parameter 0.65 or 0.5
# Plot the two Q-Q Plots side by side
par(mfrow=c(1,2))
qqPlot(x = kunden$x, distribution="exp", rate=0.65, main="Q-Q Plot Exponential Distribution (rate=0.65)")
qqPlot(x = kunden$x, distribution="exp", rate=0.5, main="Q-Q Plot Exponential Distribution (rate=0.5)")


# Aufgabe 4

n <- 20
m <- 2
sd <- 3

data <- replicate(1000, rnorm(n, mean = m, sd = sd))
par(mfrow=c(2, 2))
hist()