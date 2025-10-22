# install.packages("fitdistrplus")
library(fitdistrplus)


# Aufgabe 1

# a)

n <- 1000
m <- 0
s <- 1

data <- rlogis(n, m, s)

# lineplot
hist(data, breaks = 30, main = "Histogramm der logistischen Verteilung",
     xlab = "Werte", ylab = "Häufigkeit", col = "lightblue", border = "black")
curve(dlogis(x, m, s) * n * (max(data) - min(data)) / 30, add = TRUE, col = "red", lwd = 2)
legend("topright", legend = c("Histogramm", "Dichtefunktion"), col = c("lightblue", "red"), lwd = 2)

# b)

(var_calc <- (s^2 * pi^2) / 3)
(expected_value <- m)

# c)

# calculate m and s with optim
neg_log_likelihood <- function(params, data) {
  m <- params[1]
  s <- params[2]
  -sum(dlogis(data, m, s, log = TRUE))
}
initial_params <- c(0, 1)
fit <- optim(initial_params, neg_log_likelihood, data = data,
             method = "L-BFGS-B", lower = c(-Inf, 0.0001))
fitted_m <- fit$par[1]
fitted_s <- fit$par[2]
fitted_m
fitted_s


# Aufgabe 2
# a)
likelihood <- function(lambda) {
  return (lambda * exp(-lambda * 4.47))
}

nenner <- integrate(likelihood, lower = 0, upper = 1)$value

# b)

posterior <- function(lambda) {
  return (likelihood(lambda) / nenner)
}


# if 0 < x < 1 return 1 else return 0
g <- function(x) {
  if (x < 0 || x > 1) {
    return (0)
  } else {
    return (1)
  }
}

# Plot lines of posterior, g and likelihood

xvals <- seq(0,2,0.005)

curve(posterior, from = 0, to = 1, col = "blue", lwd = 2,
      ylab = "Dichte", xlab = expression(lambda),
      main = "Posterior, Likelihood und Prior")
curve(likelihood, from = 0, to = 2, col = "red", lwd = 2, add = TRUE)
lines(c(1,2), c(0,0), col='green')
lines(c(0,1), c(1,1), col='green')
legend("topright", legend = c("Posterior", "Likelihood", "Prior"),
       col = c("blue", "red", "green"), lwd = 2)


# Aufgabe 4
# a)

x1 <- c(5.08774228592843, 4.68263159130066, 5.10245924334245, 4.97815588066122,
        4.91573144670804, 4.94022379251288, 4.67149365210807, 5.08403749479561,
        5.15667283221903, 5.12188176748088)

x2 <- c(5.25241969628093, 5.42904043376296, 5.18137613561775, 5.08732299979658,
      4.87818940768848, 4.97768870963484, 4.92892245991247, 5.34359733511405,
      4.67414779074627, 4.8478412685637)

# x <- x1
x <- c(x1, x2)

n <- length(x)
mu0 <- 5
sigma0 <- 0.1

# A-Priori Verteilung

xachse <- seq(4.8, 5.2, 0.001)
plot(xachse, dnorm(xachse, mean = mu0, sd = sigma0), type = "l",
     main = "Prior Verteilung", xlab = expression(mu), ylab = "Dichte",
     col = "blue", lwd = 2, ylim = c(0, 10))

# Likelihood

xquer <- mean(x)
sigma <- 0.2

likelihood <- function(mu) {
  return (prod(dnorm(x, mean = mu, sd = sigma)))
}

# Eine Möglichkeit der Berechung

L <- Vectorize(FUN = likelihood, vectorize.args = "mu")

# Die Likelihood ist auf einer anderen Skala als die beiden
# Dichten, wir teilen willkürlich durch 6, damit sie gut in
# den Plot passt

lines(xachse, L(xachse) / 6, col = "red", lwd = 2)

# Posterior: Daten und Vorwissen

mu1 <- ((n / sigma ^ 2) * xquer + (1 / sigma0 ^ 2) * mu0) / (n / sigma ^ 2 + 1 / sigma0 ^ 2)
sigma1 <- sqrt(1 / (n / sigma ^ 2 + 1 / sigma0 ^ 2))

lines(xachse, dnorm(xachse, mean = mu1, sd = sigma1), col = "green", lwd = 2)
legend("topright", legend = c("Prior", "Likelihood", "Posterior"),
       col = c("blue", "red", "green"), lwd = 2)

# calculate max of posterior and mean of data
max_posterior <- mu1
max_posterior
mean_data <- mean(x)
mean_data


# Aufgabe 5
# a)

par(mfrow = c(2, 3))
p <- seq(0, 1, 0.01)

plot(p, dbeta(p, shape1 = 2, shape2 = 2), ylim = c(0, 5), type = "l", ylab = "Dichte")
plot(p, dbeta(p, shape1 = 4, shape2 = 6), ylim = c(0, 5), type = "l", ylab = "Dichte")
plot(p, dbeta(p, shape1 = 1, shape2 = 1), ylim = c(0,5), type = "l", ylab = "Dichte")
plot(p, dbeta(p, shape1 = 10, shape2 = 15), ylim = c(0, 5), type = "l", ylab = "Dichte")
plot(p, dbeta(p, shape1 = 1/4, shape2 = 1), ylim = c(0, 5), type = "l", ylab = "Dichte")

# b) Posterior Distribution

par(mfrow = c(2, 3))
p <- seq(0, 1, 0.01)
k <- 13
n <- 50

plot(p, dbeta(p, shape1 = 2 + k, shape2 = 2 + n - k), ylim = c(0, 7.5), type = "l", ylab = "Dichte", main = "a'=14, b'=38 (A)")
abline(v = k / n)
plot(p, dbeta(p, shape1 = 4 + k, shape2 = 6 + n - k), ylim = c(0, 7.5), type = "l", ylab = "Dichte", main = "a'=15, b'=39 (B)")
abline(v = k / n)
plot(p, dbeta(p, shape1 = 1 + k, shape2 = 1 + n - k), ylim = c(0, 7.5), type = "l", ylab = "Dichte", main = "a'=23, b'=52 (C)")
abline(v = k / n)
plot(p, dbeta(p, shape1 = 10 + k, shape2 = 15 + n - k), ylim = c(0, 7.5), type = "l", ylab = "Dichte", main = "a'=17, b'=43 (D)")
abline(v = k / n)
plot(p, dbeta(p, shape1 = 1 / 4 + k, shape2 = 1 + n - k), ylim = c(0, 7.5), type = "l", ylab = "Dichte", main = "a'=13.25, b'=38 (E)")
abline(v = k / n)


