library("boot")
library("car")
library("MASS")
library("moonboot")
library("Sleuth3")
library("car")
library(fitdistrplus)
library(BSDA)
library(coin)


# Aufgabe 1
dat <- data("ex0125")
boxplot(Zinc ~ Group, data = ex0125)

qqPlot(ex0125$Zinc)

wilcox_test(formula = Zinc ~ Group,
            data = ex0125,
            distribution = "exact")

# Aufgabe 2

set.seed(20250115)
x <- rbeta(n = 30, shape1 = 1/3, shape = 1/3)

neg_log_likeli <- function(theta, data){
  neg_log_likeli <- (-sum(log(((gamma(2 * theta)) / (gamma(theta))^2) * (data^(theta -1)) * (1-data)^(theta -1))))
  return(neg_log_likeli)
}

start <- 0.219
optim(par = start, fn= neg_log_likeli, method = "BFGS", data = x)


# Aufgabe 3

dat <- SP500[999:1498]
hist(dat)
mid <- mean(dat)
mean(dat[dat < mid])

lower <- dat[dat < mid]

estimator <- function(data, indices) {
  return(mean(data[indices]))
}
boot.res <- boot(data = lower, statistic = estimator, R = 5000)
boot.res
boot.ci(boot.res, type = "perc", conf = 0.99)


B <- 5000
Ti <- matrix(NA, nrow = B)
for (i in 1:B) {
  boot_sample <- sample(dat[dat < mid], size = length(lower), replace = TRUE)
  Ti[i] <- mean(boot_sample)
}
alpha <- 0.01
quantile(Ti, probs = c(alpha/2, 1 - alpha/2))


# Aufbabe 4

s1 <- function(data){
  return(mad(data))
}
s2 <- function(data){
  return((1/1.349) * (quantile(data, 0.75) - quantile(data, 0.25)))
}

n <- 10000
data_5_s1 <- numeric(length = n)
data_5_s2 <- numeric(length = n)

data_10_s1 <- numeric(length = n)
data_10_s2 <- numeric(length = n)

data_100_s1<- numeric(length = n)
data_100_s2<- numeric(length = n)


for (i in 1:n){
  data_5_s1[i] <- s1(rnorm(5, mean = 0, sd = 1))
  data_5_s2[i] <- s2(rnorm(5, 0, 1))
  
  data_10_s1[i] <- s1(rnorm(100, 0, 1))
  data_10_s2[i] <- s2(rnorm(100, 0, 1))
  
  data_100_s1[i] <- s1(rnorm(10000, 0, 1))
  data_100_s2[i] <- s2(rnorm(10000, 0, 1))
  
}

hist(rnorm(1000, mean = 0, sd = 1))
hist(data_100_s1)
hist(data_100_s2)

mean(data_5_s1)
mean(data_10_s1)
mean(data_100_s1)

mean(data_5_s2)
mean(data_10_s2)
mean(data_100_s2)

bias_s1 <- function(data, theta){
  return(mad(data) - theta)
}

bias_s2 <- function(data, theta){
  return((1/1.349) * IQR(data) - theta)
}

bias_s1(data_5_s1, 0)
bias_s2(data_100_s2, 0)

var(data_100_s1)
var(data_10_s2)

MSE <- var(data_100_s2) + bias_s1(data_100_s2, 0)^2
MSE


# Aufgabe 5
power.t.test(n = 100, delta = 0.1, sd = 1, sig.level = 0.8, power = NULL)

binom.test(x = 11, n = 77)$conf.int

binom.test(x = 11, n = 33)$conf.int
