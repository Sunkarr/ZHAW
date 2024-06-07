# Aufgabe 1a

ppois(1, 4/5, lower.tail = F)

qpois(0.99, 4/5)


# Aufgabe 1b

1 - punif(1, 0, 15, lower.tail = F)

pgamma(30, 4, 1/15)


# Aufgabe 1d

350 - qnorm(0.95, 0, 0.15)


# Aufgabe 2a

n <- 100000
v <- 1000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- sum(rpois(v, 0.3)*5) + sum(rpois(v, 0.2)*5.5) + sum(rpois(v, 0.15)*7.5) + sum(rpois(v, 0.15)*8.5) + sum(rpois(v, 0.1)*13) + sum(rpois(v, 0.1)*19.5)
}

mean(m)
sd(m)

prob <- c(0.3, 0.2, 0.15, 0.15, 0.1, 0.1)
preis <- c(5, 5.5, 7.5, 8.5, 13, 19.5)

ew <- sum(prob*preis)
var <- sum(prob * (preis^2)) - ew^2

ew_1000 <- ew * 1000
sd_1000 <- sqrt(var*1000)


# Aufgabe 2c

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  pakete <- rpois(1, 2500)
  m[i,] <- ceiling(sum(rlnorm(pakete, 2, 1.2)) / 1200)
}

hist(m)
quantile(m, 0.95)


# Aufgabe 3b

u <- runif(10000)
g <- function(x){(log(1-x)/(-2))^0.5}
x <- g(u)

hist(x, freq = F, breaks = 30)

dichte <- function(x) { 2 * exp(-2 * x^2) }
lines(dichte, add = TRUE, col = "red", lwd = 2)





# Aufgabe 4

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- sum(sample(0:1, 2, prob = c(0.6, 0.4), replace = T))
}
plot(table(m))


library(combinat)
per <- permn(c("A", "A", "A", "A", "A", "B", "B", "B"))
length(unique(per))
per


pnbinom(1, 2, 0.45, lower.tail = F)


f_X <- function(x, delta) 2 * delta * x * exp(- delta * x^2) * (x>0)
xgrid <- seq(0, 4, 0.01)
Finv_X <- function(u, delta) sqrt(-log(1-u)/delta)
X <- Finv_X(runif(10000), delta = 2)
hist(X, freq = FALSE)
lines(xgrid, f_X(xgrid, delta = 2), col = "red")



