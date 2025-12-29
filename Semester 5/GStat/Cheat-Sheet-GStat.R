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


