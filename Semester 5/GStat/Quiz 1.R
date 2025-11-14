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

