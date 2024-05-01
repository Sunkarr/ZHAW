# Aufgaabe 1

pnorm(0.305 , mean = 0.302, sd = 0.003) - pnorm(0.295 , mean = 0.302, sd = 0.003)

q <- qnorm(0.02, mean = 0, sd=4)
mue <- 400-q
qnorm(0.02, mean = mue, sd=4)

q <- qnorm(0.02, 0, 2.5)
mue <- 400-q
qnorm(0.02, mue, 2.5)


# Aufgabe 2

x <- 0:20000
plot(x, dlnorm(x, 8.5, 0.97), type = "l", lwd = 2, col = "red")
plot(x, dlnorm(x, 7.5, 1.20), type = "l", lwd = 2, col = "blue")

x <- 0:20000
pdf1 <- dlnorm(x, 8.5, 0.97)
pdf2 <- dlnorm(x, 7.5, 1.20)
plot(x, pdf1, type = "l", lwd = 2, col = "red", ylim = c(0, max(pdf1, pdf2)), 
     xlab = "x", ylab = "Density", main = "Comparison of Log-Normal Distributions")
lines(x, pdf2, type = "l", lwd = 2, col = "blue")


EX <- function(mue, roh) {
  exp(mue + ((roh)^2)/2)
}

SDX <- function(mue, roh){
  sqrt(exp(2*mue+roh^2)*(exp(roh^2) - 1))
}

EX(8.5, 0.97)
EX(7.8, 1.2)
SDX(8.5, 0.97)
SDX(7.8, 1.2)

qlnorm(0.5, 8.5, 0.97)
exp(8.5)
qlnorm(0.5, 7.8, 1.2)
exp(7.8)

abline(v = EX(8.5, 0.97), col = "red")
abline(v = exp(8.5), col = "red")
abline(v = EX(7.8, 1.2), col = "blue")
abline(v = exp(7.8), col = "blue")


# Aufgabe 3

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- rbinom(1, 1, 0.8) + rbinom(1, 1, 0.82) + rbinom(1, 1, 0.66)
}
count <- sum(m >= 2)
count/n

Anmeldungen <- rpois(n,lambda=100)
(k_32 <- mean(ceiling(Anmeldungen/32)))

Anmeldungen <- rpois(n,lambda=100)
(k_40 <- mean(ceiling(Anmeldungen/40)))

k <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  k[i,] <- (ceiling(rpois(1, 100)/32) - ceiling(rpois(1, 100)/40)) * 150000
}
mean(k)


df <- data.frame(Anmeldungen = integer(n))
df$Anmeldungen <- rpois(n,lambda=100)
df$Vollzeit <- sapply(df$Anmeldungen, function(x) rbinom(1, x, 0.8))
df$Teilzeit <- df$Anmeldungen - df$Vollzeit

df$Vollzeit_k_32 <- sapply(df$Vollzeit, function(x) ceiling(x/32)) * 150000
df$Teilzeit_k_32 <- sapply(df$Teilzeit, function(x) ceiling(x/32)) * 150000

df$Vollzeit_k_40 <- sapply(df$Vollzeit, function(x) ceiling(x/40)) * 150000
df$Teilzeit_k_40 <- sapply(df$Teilzeit, function(x) ceiling(x/40)) * 150000

Kosten_32 <- mean(df$Vollzeit_k_32) + mean(df$Teilzeit_k_32)
Kosten_40 <- mean(df$Vollzeit_k_40) + mean(df$Teilzeit_k_40)

Kosten_32 - Kosten_40



