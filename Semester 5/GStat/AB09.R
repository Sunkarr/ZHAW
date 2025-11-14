# Aufgabe 2

poisson.test(x = c(107, 126), r = 1, alternative = "less")

poisson.test(x = c(302, 327), r = 1, alternative = "less")


# Aufgabe 3
unterlegscheiben <- readRDS("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/unterlegscheiben.rds")

Z <- function(data, mean0, sd0) {
  result <- ((mean(data) - mean0) / sd0) * sqrt(length(data))
  return (result)
}

Z_unterlegescheiben <- Z(unterlegscheiben, mean0 = 0.3, sd0 = 0.003)

2 * (1 - pnorm(abs(Z_unterlegescheiben)))

library(BSDA)
z.test(x = unterlegscheiben, sigma.x = 0.003, mu = 0.3)


# Aufgabe 4
# b)

t <- (-2.3)
alpha <- 0.05
n <- 18
pt(t, df = n - 1)

# c)
t <- (-2.7)
alpha <- 0.01
pt(t, df = n - 1)

# d)
2*(1 - pt(abs(t), df = n-1))


# Aufgabe 5

alpha <- 0.05
mu0 <- 150
mu_hat <- 148
sd_hat <- 3
n <- 50

t_stat <- (mu_hat - mu0) / (sd_hat / sqrt(n))
t_stat
pt(t_stat, df = n-1)
