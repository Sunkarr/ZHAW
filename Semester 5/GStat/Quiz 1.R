# Aufgabe 10

nsim <- 100000
stichprobengrösse <- 5

# create empty matrix nsim x stichprobengrösse
matrix_data <- matrix(NA, nrow = nsim, ncol = 2)

s1 <- function(data) {
  mean(log(data))
}

s2 <- function(data) {
  n <- length(data)
  log(mean(data))
}

for (n in 1:nsim) {
  data <- rlnorm(stichprobengrösse, meanlog = 3, sdlog = 2)
  # compute s1 and s2
  matrix_data[n, 1] <- s1(data)
  matrix_data[n, 2] <- s2(data)
}

s1_mean <- mean(matrix_data[, 1])
s2_mean <- mean(matrix_data[, 2])

s1_var <- var(matrix_data[, 1])
s2_var <- var(matrix_data[, 2])


# Aufgabe 5

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/schraubenlaengen.rda")

t.test(schraubenlaengen, conf.level = 0.9)$conf.int
mean(schraubenlaengen)
sd(schraubenlaengen)


# Aufgabe 7

n <- 10

bias1 <- 4
bais2 <- 3
bais3 <- 0

var1 <- 1/5
var2 <- 1 + exp(-3*n)
var3 <- 1/n

mse1 <- bias1^2 + var1
mse2 <- bais2^2 + var2
mse3 <- bais3^2 + var3
  

# Aufgabe 6

alpha <- 0.1
mu <- 38.5
sigma <- 1.6
n <- 59

# Konfidenzintervall
ci_lower <- mu - qnorm(1 - alpha/2) * (sigma / sqrt(n))
ci_upper <- mu + qnorm(1 - alpha/2) * (sigma / sqrt(n))
ci <- c(ci_lower, ci_upper)
ci_length <- ci_upper - ci_lower
ci_half_length <- ci_length / 2

ci_length <- 0

while (ci_length > ci_half_length) {
  n <- n + 1
  ci_lower <- mu - qnorm(1 - alpha/2) * (sigma / sqrt(n))
  ci_upper <- mu + qnorm(1 - alpha/2) * (sigma / sqrt(n))
  ci_length <- ci_upper - ci_lower
}

# Aufgabe 9

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/mikrowellen.rda")



# Aufgabe 6 Simuliert

library(boot)

n <- 59
nsim <- 10000

data <- matrix(NA, nrow = nsim, ncol = n)
for (i in 1:nsim) {
  data[i, ] <- rnorm(n, mean = 38.5, sd = 1.6)
}

estimator <- function(data, indices) {
  d <- data[indices]
  return (mean(d))
}

# calc bootstrat CI for every row, store lower bounds in vector
lower_bounds <- numeric(nsim)
upper_bounds <- numeric(nsim)

for (i in 1:nsim) {
  boot_result <- boot(data[i, ], statistic = estimator, R = 500)
  ci <- boot.ci(boot_result, type = "perc")$percent[4:5]
  lower_bounds[i] <- ci[1]
  upper_bounds[i] <- ci[2]
}
mean(lower_bounds)
mean(upper_bounds)


# Aufgabe 3

library(boot)

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/simDat.rda")
set.seed(540)

sigma_hut <- IQR(simDat) / 1.34898

est_sigma_hut <- function(data, indices) {
  d <- data[indices]
  return (IQR(d) / 1.34898)
}

boot_restult <- boot(simDat, statistic = est_sigma_hut, R = 10000)
boot.ci(boot_restult, conf = 0.78, type = "perc")


# Aufgabe 9, maximum likelihood Weibull-Verteilung with optim(), starting value = 1

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/mikrowellen.rda")

one_divided_lambda <- 13.5
n <- length(mikrowellen)
log_likelihood <- function(one_divided_lambda, beta, data) {
  scale <- one_divided_lambda
  shape <- beta
  ll <- sum(dweibull(data, shape = shape, scale = scale, log = TRUE))
  return (-ll)
}
lik <- function(params, data) {
  -log_likelihood(params[1], params[2], data)
}
result <- optim(c(one_divided_lambda, 1), lik, data = mikrowellen,
                method = "L-BFGS-B", lower = c(0.0001, 0.0001))
fitted_one_divided_lambda <- result$par[1]
fitted_beta <- result$par[2]
fitted_one_divided_lambda
fitted_beta


# Chat

# Daten laden
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/mikrowellen.rda")

# Charakteristische Lebensdauer (scale parameter)
lambda <- 13.5

# Negative Log-Likelihood-Funktion für Weibull-Verteilung
# Parameter: beta (shape parameter)
# Die Weibull-Dichte: f(x) = (beta/lambda) * (x/lambda)^(beta-1) * exp(-(x/lambda)^beta)
neg_log_likelihood <- function(beta, data, lambda) {
  n <- length(data)
  if (beta <= 0) return(Inf)  # beta muss positiv sein
  
  # Log-Likelihood für Weibull
  ll <- n * log(beta) - n * beta * log(lambda) + 
    (beta - 1) * sum(log(data)) - 
    sum((data / lambda)^beta)
  
  return(-ll)  # Negativ, weil optim minimiert
}

# Maximum-Likelihood-Schätzung mit BFGS-Methode
result <- optim(
  par = 1,                                    # Startwert für beta
  fn = neg_log_likelihood,                    # Zielfunktion
  data = mikrowellen,                         # Daten
  lambda = lambda,                            # Fixierter scale-Parameter
  method = "BFGS"                             # Optimierungsmethode
)

# Geschätzter Formparameter (beta)
beta_hat <- result$par
beta_hat


# Claude

# Maximum-Likelihood-Schätzung des Formparameters einer Weibull-Verteilung
# für Mikrowellen-Lebensdauer

# Daten laden (passe den Pfad an, wo die Datei gespeichert ist)
data <- load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/mikrowellen.rda")

# Falls die Variable einen anderen Namen hat, verwende:
# data <- mikrowellen  # oder den entsprechenden Variablennamen

# Annahme: Die geladenen Daten heißen 'mikrowellen'
# Falls anders, bitte anpassen

# Gegebene Parameter
scale_param <- 13.5  # charakteristische Lebensdauer (scale)

# Negative Log-Likelihood-Funktion
# Wir minimieren die negative Log-Likelihood
neg_log_likelihood <- function(shape, data, scale) {
  # Log-Likelihood für Weibull-Verteilung
  # dweibull(x, shape, scale, log = TRUE) gibt log(f(x)) zurück
  log_lik <- sum(dweibull(data, shape = shape, scale = scale, log = TRUE))
  
  # Rückgabe der negativen Log-Likelihood
  return(-log_lik)
}

# Startwert für den Formparameter
start_value <- 1

# Optimierung mit optim und Methode BFGS
result <- optim(
  par = start_value,
  fn = neg_log_likelihood,
  data = mikrowellen,  # Anpassen falls Variable anders heißt
  scale = scale_param,
  method = "BFGS"
)

# Geschätzter Formparameter
shape_estimate <- result$par

# Ausgabe
cat("Geschätzter Formparameter (shape):", round(shape_estimate, 3), "\n")
cat("Mit höherer Genauigkeit:", shape_estimate, "\n")
cat("\nKonvergenz:", result$convergence, "(0 = erfolgreich)\n")

# Visualisierung (optional)
hist(mikrowellen, breaks = 20, freq = FALSE, 
     main = "Histogramm der Mikrowellen-Lebensdauer mit geschätzter Weibull-Dichte",
     xlab = "Lebensdauer (Jahre)", ylab = "Dichte")

# Theoretische Dichte mit geschätztem Parameter
x_seq <- seq(0, max(mikrowellen), length.out = 200)
y_theo <- dweibull(x_seq, shape = shape_estimate, scale = scale_param)
lines(x_seq, y_theo, col = "red", lwd = 2)
legend("topright", legend = c("Beobachtete Daten", "Geschätzte Weibull-Dichte"), 
       col = c("gray", "red"), lwd = c(10, 2))
