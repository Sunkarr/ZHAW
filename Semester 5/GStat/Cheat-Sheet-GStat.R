# Cheat Sheet Gstat


## QQ-Plot
library("car")
x <- rnorm(n = 100, mean = 1, sd = 2)
par(mfrow = c(1,2))
hist(x, breaks = 10, main = "Histogramm von x", xlab = "x-Werte", ylab = "Häufigkeit")
qqPlot(x, distribution = "norm", mean = 0, sd = 1, main = "QQ-Plot von x")
par(mfrow = c(1,1))

### log Transformierte Daten
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/qqplot.RData")
qqPlot(lohn)
qqPlot(log(lohn))


## Daten unabhängig?
sample_data_unabhängig <- rnorm(500)
sample_data_abhängig <- numeric(n)
rho <- 0.8 # Stärke der Korrelation
for(i in 2:n) {
  sample_data_abhängig[i] <- rho * sample_data_abhängig[i-1] + rnorm(1, sd = 0.6)
}
par(mfrow = c(2,2))
plot(sample_data_unabhängig[1:50], type = "b", pch = 19, main = "Unabhängig", 
     xlab = "", ylab = "Stichprobe 1")
plot(sample_data_abhängig[1:50], type = "b", pch = 19, main = "Abhängig", 
     xlab = "", ylab = "Stichprobe 2")  
plot(sample_data_unabhängig[-1], sample_data_unabhängig[-length(sample_data_unabhängig)], xlab = "x_n", ylab = "x_(n-1)", 
     pch = 21)
plot(sample_data_abhängig[-1], sample_data_abhängig[-length(sample_data_abhängig)], xlab = "x_n", ylab = "x_(n-1)", 
     pch = 21)
par(mfrow = c(1,1))


## Schätzer

MSE_Estimator <- function(lambda_hat, lambda_true) {
  var(lambda_hat) + (mean(lambda_hat) - lambda_true)^2
}


## Maximum Likelihood

### Beispiel für Binomialverteilung
#### x = Anzahl Rote Würfe, n = Anzahl Würfe, p = Wahrscheinlichkeit Rot
p <- seq(0, 6)/6
x_erfolg <- 34
n <- 100
wahr <- dbinom(x = x_erfolg, size = n, prob = p, log = T)
plot(würfel, wahr, 
     type = "b", 
     pch = 19, 
     col = "blue",
     xlab = "Parameter p (Wahrscheinlichkeit Rot)", 
     ylab = "Log-Likelihood", 
     main = "Log-Likelihood Funktion (Binomial)")
# Markierung des Maximums (MLE)
mle_p <- x_erfolg / n
abline(v = mle_p, col = "red", lty = 2)


## Log-Likelihood

### Beispiel für Gammaverteilung
#### Parameter shape = 3, rate = 1/9 sollen geschätzt werden
set.seed(801)
x.gamma <- rgamma(n = 20, shape = 3, rate = 1/9)
x.gamma
negative_log_likelihood <- function(params, data) {
  shape <- params[1]
  rate <- params[2]
  -sum(dgamma(x = data, shape = shape, rate = rate, log = TRUE))
}
start <- c(mean(x.gamma)^2 / var(x.gamma), mean(x.gamma) / var(x.gamma))
start
optim(par = start, fn = negative_log_likelihood, method = "BFGS", data = x.gamma)

library(fitdistrplus)
x.gamma.mle <- fitdist(data = x.gamma, distr = "gamma", method = "mle")
x.gamma.mle$estimate

### SW04 Aufgabe 2: Maximum-Likelihood-Schätzung bei Normalverteilung

xs <- c(-0.033, -0.76, 2.02, 1.13, 0.65, 0.49, 0.76, 0.40, 0.10, 0.61)
loglik <- function(mu, sigma, dat) {
  sum(dnorm(x = dat, mean = mu, sd = sigma, log = TRUE))
}
loglik(mu = 0, sigma = 1, dat = xs)

gitter <- expand.grid(mu = seq(0.5, 0.6, 0.001), sigma = seq(0.6, 0.75, 0.001))
m <- dim(gitter)[1]
lik <- rep(-Inf, m)
for (i in 1:m) {
  lik[i] <- loglik(mu = gitter[i, 1], sigma = gitter[i, 2], dat = xs)
}
gitter[which.max(lik), ]

lik <- function(param) {
  -loglik(mu = param[1], sigma = param[2], dat = xs)
}
optim(c(0.5,0.5), lik)

norm.mle <- fitdist(data = xs, distr = "norm", method = "mle")
norm.mle$estimate


## Konfidenzintervall

### Varianz bekannt
data <- rnorm(n = 100, mean = 50, sd = 10)
#### Manuell
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qnorm(1 - alpha/2)*sd_data/sqrt(n)
#### via z.test
library(BSDA)
z.test(x = data, mu = mean_data, sigma.x = sd_data, conf.level = 1-alpha)$conf.int

### Varianz unbekannt (mit Student-t-Verteilung)
data <- rnorm(n = 100, mean = 50, sd = 10)
#### Manuell
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qt(1 - alpha/2, df = n-1)*sd_data/sqrt(n)
#### via t.test
library(BSDA)
t.test(x = data, conf.level = 1-alpha)$conf.int

### Asymptitisches Konfidenzintervall
data <- rnorm(n = 100, mean = 50, sd = 10)
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qnorm(1 - alpha/2)*sd_data/sqrt(n)

### Clopper-Pearson Intervall für Binomialverteilung
#### Weil binomiale Verteilungen sehr schlecht approximiert werden mit Asymptotischen KI's
#### verwendet man in diesem Fall besser Clopper-Pearson Intervalle
data <- rbinom(n = 1, size = 100, prob = 0.3) # 100 Versuche, 30 Erfolge
library(BSDA)  
binom.test(x = data, n = 100, conf.level = 0.95)$conf.int
#### Auch für Poissonverteilung
data <- rpois(n = 1, lambda = 5) # 5 Ereignisse
poisson.test(x = data, conf.level = 0.95)$conf.int # KI für Ereignis pro Zeit
  
### Bootstrap Konfidenzintervall
#### Manuell
xn <- rnorm(5)
B <- 500
Ti <- matrix(NA, nrow = B)
for (i in 1:B) {
  boot_sample <- sample(xn, size = length(xn), replace = TRUE)
  Ti[i] <- mean(boot_sample)
}
alpha <- 0.05
quantile(Ti, probs = c(alpha/2, 1 - alpha/2))
#### via boot Paket
library(boot)
xn <- rnorm(5)
estimator <- function(data, indices) {
  return(mean(data[indices]))
}
boot.res <- boot(data = xn, statistic = estimator, R = 500)
boot.ci(boot.res, type = "perc", conf = 0.95)


## Statistischen Testen

### Binomialtest

binom.test(x = 47, n = 120, conf.level = 0.95, alternative = "greater", p = 0.3)

### Poissontest

## Annahmebereich
qpois(0.95, lambda = 8.4)
1 - sum(dpois(x = 0:13, lambda = 8.4))
### Der Annahmebereich ist [0, 13]
### Der Verwerfungsbereich ist [14, ∞)
## p-Wert
1 - ppois(10, lambda = 8.4)
poisson.test(x = 11, r = 8.4, alternative = "greater")$p.value

poisson.test(x = 9 + 8 + 12, T = 9, r = 3, alternative = "greater")

### Z-Test
library(BSDA)
unterlegescheiben <- load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/unterlegscheiben.rda")
z.test(x = x, sigma.x = 0.003, mu = 0.3)

### T-Test
