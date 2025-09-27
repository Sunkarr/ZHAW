install.packages(pkgs = "car", dependencies = TRUE)
library(car)

# Aufgabe 1
# a)
# E(x) = 2/3, Var(x) = 1/18, calculate P(X < 0.75)
pnorm(0.75, mean = 2/3, sd = sqrt(1/18)/sqrt(30))

# b)
n <-  30
N <- 10000

# F(X) = x^2, genererate 10000 realisations of the random variable of 30 samples
par(mfrow=c(1,1))
data <- sqrt(runif(n * N, min = 0, max = 1))
hist(data, freq = F)
abline( b = 2, a =0, col = 2, lwd = 2)

s <- matrix(data, nrow = n, ncol = N)
x.bar <- colMeans(s)
hist(x.bar, freq = F, breaks = 50)

sum(x.bar < 0.75) / length(x.bar)


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


# Aufgabe 3

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/qqplot.RData")
hist(brust)
hist(lohn)
hist(waerme)

qqPlot(brust)
qqPlot(lohn)
qqPlot(log(lohn))

qqPlot(waerme)



# Aufgabe 4

n <- 20
m <- 2
sd <- 3

data <- replicate(1000, rnorm(n, mean = m, sd = sd))
par(mfrow=c(2, 2))

# create a  hist of the means of the 1000 samples
hist(colMeans(data), freq = F, breaks = 30)

# create a hist of the first element of each sample
hist(data[1,], freq = F, breaks = 30)

# create a hist of the smallest element of each sample
hist(apply(data, 2, min), freq = F, breaks = 30)

# create a hist of th var of each sample
hist(apply(data, 2, var), freq = F, breaks = 30)
