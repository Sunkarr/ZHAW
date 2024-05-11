# Aufgabe 1

pnorm(5, mean=0, sd=sqrt(225/12)) - pnorm(-5, mean=0, sd=sqrt(225/12))


n <- 100000
M <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  M[i,] <- sum(runif(225, -0.5, 0.5))
  }
ecdf(M)(5)


# Aufgabe 2

1 - pnorm(1000, 69*14, sqrt(69*9))


# Aufgabe 3

n <- 100
M <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  M[i,] <- sum(sample(0:1, i, replace = TRUE, prob = c(0.5, 0.5)))
}

plot(M)


N <- 10000
erwartungswert <- 0.5
stichprobe <- sample(c(0, 1), N, replace = TRUE, prob = c(0.5, 0.5))
mittelwerte <- numeric(N)
for (n in 1:N) {
  mittelwerte[n] <- mean(stichprobe[1:n])
}
plot(1:N, mittelwerte, type = "l", xlab = "n", ylab = "Mittelwert", main = "Gesetz der großen Zahlen")
abline(h = erwartungswert, col = "red")






