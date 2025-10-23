# Aufgabe 1
# a)

n <- 30
m <- 10000

matrix_data <- matrix(rnorm(n * m, mean = 50, sd = 10), nrow = n, ncol = m)

data_vec <- as.vector(matrix_data)
hist(data_vec)

# b) calculate a vector of lenght m with confidence intervals

# install.packages("BSDA")
library(BSDA)

conf_intervalls <- function(data, conf_level) {
  n <- nrow(data)
  m <- ncol(data)
  lower_bounds <- numeric(m)
  upper_bounds <- numeric(m)
  
  for (i in 1:m) {
    sample <- data[, i]
    ci <- z.test(sample, sigma.x = sd(sample), conf.level = conf_level)$conf.int
    lower_bounds[i] <- ci[1]
    upper_bounds[i] <- ci[2]
  }
  
  return (data.frame(lower = lower_bounds, upper = upper_bounds))
}

conf_level <- 0.95
conf_intervals_95 <- conf_intervalls(matrix_data, conf_level)

# c) calculate the proportion of intervals that contain the true mean

true_mean <- 50
contains_true_mean <- function(conf_intervals, true_mean) {
  count <- 0
  m <- nrow(conf_intervals)
  
  for (i in 1:m) {
    if (conf_intervals$lower[i] <= true_mean && conf_intervals$upper[i] >= true_mean) {
      count <- count + 1
    }
  }
  
  proportion <- count / m
  return (proportion)
}
proportion_95 <- contains_true_mean(conf_intervals_95, true_mean)
proportion_95


# Aufgabe 2
# a)

n <- 1219
x_strich <- 6.048
sd_x <- 0.02
conf_level <- 0.95

ci_lower <- x_strich - qnorm(conf_level) * (sd_x / sqrt(n))
ci_upper <- x_strich + qnorm(conf_level) * (sd_x / sqrt(n))
ci <- c(ci_lower, ci_upper)
ci

# b)

pnorm(6.00, mean = x_strich, sd = sd_x)

# c)

(2 * 0.02 / 0.001 * qnorm(0.95))^2


# Aufgabe 3
# a)

library(car)

n <- 3
m <- 10000
mu <- 42
sd <- 4
matrix_data <- matrix(rnorm(n * m, mean = mu, sd = sd), nrow = n, ncol = m)

z <- (colMeans(matrix_data) - 42) / (4 / sqrt(n))
par(mfrow = c(1, 2), mar = c(4, 4, 1, 1))
hist(x = z, freq = FALSE, breaks = 100, xlim = c(-5,5), main = "")
dd <- seq(from = -5, to = 5, by = 0.1)
lines(x = dd, y = dnorm(x = dd, mean = 0, sd = 1), col = "red")
invisible(qqPlot(z))

# b)

colSD <- function(x) {
  apply(x, 2, sd)
}
z_sigma_geschätzt <- (colMeans(matrix_data) - 42) / (colSD(matrix_data) / sqrt(n))
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
hist(z_sigma_geschätzt, freq = FALSE, xlim = c(-5,5), breaks = 1000, ylim = c(0, 0.4), main = "")
dd <- seq(from = -5, to = 5, by = 0.1)
lines(dd, dnorm(dd, mean = 0, sd = 1), col="red")
invisible(qqPlot(z_sigma_geschätzt))
hist(z_sigma_geschätzt, freq = FALSE, xlim = c(-5, 5), breaks = 1000, ylim = c(0, 0.4), main = "")
dd <- seq(-5, 5, 0.1)
lines(dd, dt(dd, df = 2), col = "green")
invisible(qqPlot(z_sigma_geschätzt, distribution = "t", df = 2))


# Aufgabe 4

m <- 10000
n <- c(5, 10, 20, 100)

# create a vector of matrices with random standard normal numbers
list_matrix_data <- lapply(n, function(size) {
  matrix(rnorm(size * m, mean = 0, sd = 1), nrow = size, ncol = m)
})

calc_ci <- function(data, conf_level) {
  sigma_bekannt <- 1
  sigma_unbekannt <- sd(data)
  
  ci_sigma_bekannt <- z.test(data, sigma.x = sigma_bekannt, conf.level = conf_level)$conf.int
  ci_sigma_geschummelt <- z.test(data, sigma.x = sigma_unbekannt, conf.level = conf_level)$conf.int
  ci_sigma_unbekannt <- t.test(data, conf.level = conf_level)$conf.int
  
  return (list(bekannt = ci_sigma_bekannt,
               geschummelt = ci_sigma_geschummelt,
               unbekannt = ci_sigma_unbekannt))
}

conf_level <- 0.95
calc_ci(list_matrix_data[[1]][,1], conf_level)


# Aufgabe 5

x <- c(104, 103, 107, 105, 102, 109, 105, 104, 106)
n <- length(x)
mu0 <- 100

t.test(x, mu = mu0, conf.level = 0.95)$conf.int


