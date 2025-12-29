# GStat Lernhpase Übungen

## SW02 Aufgabe 1: Zentraler Grenzwertsatz

# Parameter
mu <- 2/3
var_x <- 1/18
n <- 30

# Standardabweichung des Stichprobenmittels (Standardfehler)
sd_quer <- sqrt(var_x / n)

# Wahrscheinlichkeit berechnen P(X_quer < 0.75)
pnorm(0.75, mean = mu, sd = sd_quer)

# Simulation
n <- 30
N <- 100000
data <- matrix(NA, nrow = N)
for (i in 1:N) {
  sample_data <- rnorm(n, mu, sqrt(var_x))
  data[i] <- mean(sample_data)
}
hist(data)
sum(data < 0.75) / N


## SW02 Aufgabe 2: QQ-Plot

library(readr)
kunden <- read_csv("Documents/GitHub/ZHAW/Semester 5/GStat/Daten/kunden.csv")
kunden <- kunden$x
quant <- c(0.05, 0.25, 0.5, 0.75, 0.9, 0.975)
quantile(kunden, quant)

hist(kunden)
library("car")
par(mfrow = c(1,2))
qqPlot(kunden, distribution = "norm", main = "QQ-Plot Normalverteilung")
qqPlot(kunden, distribution = "exp", main = "QQ-Plot Exponentialverteilung")
par(mfrow = c(1,1))

par(mfrow = c(1,2))
qqPlot(kunden, distribution = "exp", rate = 0.65, main = "lambda = 0.65")
qqPlot(kunden, distribution = "exp", rate = 0.5, main = "lambda = 0.5")
par(mfrow = c(1,1))


## SW03 Aufgabe 1: Schätzung von λ bei der Exponentialverteilung

n <- 5
N <- 10000
data <- matrix(NA, nrow = N)
for (i in 1:N) {
  sample_data <- rexp(n, rate = 2)
  lambda_hat <- 1 / mean(sample_data)
  data[i] <- lambda_hat
}
hist(data, breaks = 30, main = "Verteilung der Schätzer λ̂", xlab = "λ̂")
mean(data)
bias <- mean(data) - 2
bias
MSE <- var(data) + bias^2
MSE
