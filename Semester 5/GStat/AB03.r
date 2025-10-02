# GSTAT Arbeitsblatt 3

# Aufgabe 1
# a) 
lambda_true <- 2
lambda_hat <- replicate(10000, 1 / mean (rexp(n = 5, rate = lambda_true)))
mean(lambda_hat)

# b) MSE of dat
mean((lambda_hat - lambda_true)^2)
var(lambda_hat)+(mean(lambda_hat) - lambda_true)^2


# Aufgabe 2: Varianzschätzung verzerrt (biased) und unverzerrt (unbiased)
n <- 3
N <- 10000
dat <- replicate(N, rnorm(n = n))
s_1_2 <- function(x) (1/(n-1)) * mean((x - mean(x))^2)
s_2_2 <- function(x) 1/n * mean((x - mean(x))^2)


# Aufgabe 4: Effizienz: Mittelwert vs. Median
# a)
n <- 20
N <- 10000

data <- matrix(replicate(N, rnorm(n = n)), nrow = n, ncol = N)
MSE <- function(x) mean((x - 0)^2)
mean_MSE <- apply(data, 2, mean)
median_MSE <- apply(data, 2, median)
MSE_mean <- MSE(mean_MSE)
MSE_median <- MSE(median_MSE)
MSE_mean
MSE_median
# Der Mittelwert ist effizienter als der Median

# b)
# install.packages("ExtDist")
library(ExtDist)

data <- matrix(replicate(N, rLaplace(n = n, lambda = 1)), nrow = n, ncol = N)
MSE <- function(x) mean((x - 0)^2)
mean_MSE <- apply(data, 2, mean)
median_MSE <- apply(data, 2, median)
MSE_mean <- MSE(mean_MSE)
MSE_median <- MSE(median_MSE)
MSE_mean
MSE_median
# Der Median ist effizienter als der Mittelwert


# Aufgabe 5: Robustheit: Ein einfaches Kontaminationsmodell
# Create matrix with 17xrnorm(0, 1) and 3xrnorm(0, 3)
n <- 20
N <- 10000
data_dirty <- matrix(c(replicate(N, c(rnorm(n = 17, mean = 0, sd = 1),
                                      rnorm(n = 3, mean = 0, sd = 3)))),
                     nrow = n, ncol = N)

# Stichprobenmittel
mean_dirty <- apply(data_dirty, 2, mean)
MSE_mean_dirty <- mean((mean_dirty - 0)^2)
MSE_mean_dirty

# Stichprobenmedian
median_dirty <- apply(data_dirty, 2, median)
MSE_median_dirty <- mean((median_dirty - 0)^2)
MSE_median_dirty

# Ratio
MSE_mean_dirty / MSE_median_dirty


