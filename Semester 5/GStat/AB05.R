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


# Aufgabe 4
# a)

x1 <- c(5.08774228592843, 4.68263159130066, 5.10245924334245, 4.97815588066122,
        4.91573144670804, 4.94022379251288, 4.67149365210807, 5.08403749479561,
        5.15667283221903, 5.12188176748088)

n <- length(x1)

