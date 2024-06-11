# Aufgabe 1

20/25


# Aufgabe 2

wuerfel <- 1:6
kombinationen <- expand.grid(Wurf1 = wuerfel, Wurf2 = wuerfel)
print(kombinationen)


# Aufgabe 5

884/1500

qbinom(0.05, 1500, 0.6)

sum(wuerfel^2)
sum(wuerfel)

prob<- c(rep(1/6, 6))

n <- 1000000
m <- matrix(NA, ncol = 1, nrow = n)
for (i in 1:n){
  m[i,] <- (sample(wuerfel, size = 1, prob = prob))^2 * sample(wuerfel, size = 1, prob = prob)

}

mean(m)
sd(m)



# Aufgabe 8

pbinom(17, 365, 1/20, lower.tail = F)



# Aufgabe 3: Rechnen mit Verteilungen (6 Punkte)

phyper(2, 8, 16, 4)

qnorm(0.95, 6.28, 0.12)

n <- 100000
m <- matrix(NA, ncol = 1, nrow = n)
for (i in 1:n){
  m[i,] <- rexp(1, 1/20) + runif(1, 0, 9) + rnorm(1, 15, 3)
}

mean(m)
quantile(m, 0.95)


dpois(0:12, 2.02)

tore <- c(0, 2, 4, 6, 8, 10, 12)
dpois(tore/2, tore, 0.5)


# Aufgabe 1

2000*0.0004

pbinom(1, 2000, 0.0004, lower.tail = F)

qbinom(0.99, 2000, 0.0004)



# Aufgabe 2

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
prob <- c(0.3, 0.2, 0.15, 0.15, 0.1, 0.1)
pakete <- c(5, 5.5, 7.5, 8.5, 13, 19.5)

Ex <- sum(prob*pakete) *1000
varx <- sum((pakete^2 * prob) - (prob*pakete)^2)
sdx <- (varx * 1000)^0.5



Ex2 <- sum(prob * preis^2)
varx <- Ex2 - Ex^2
sdx <- sqrt(varx)

Ex_1000 <- 1000 * Ex
sdx_1000 <- sqrt(1000 * varx)


n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  pakete <- rpois(1, 2500)
  vol <- sum(rlnorm(pakete, meanlog = 2, sd = 1.2))
  m[i,] <- ceiling(vol/1200)
}

mean(m)
quantile(m, 0.95)
hist(m, breaks = 20)



x <- function(x, lambda){((log(1-x))/-lambda)^0.5}
f_x <- function(x, lambda){lambda*2*x*exp(-lambda*x^2)}
xgrid <- seq(0, 4, 0.01)
X <- x(runif(10000), 4)
hist(X, freq = F)
lines(xgrid, f_x(xgrid, 4), col = "red", lwd = 4)


library(combinat)
letters <- c(rep("A", 5), rep("B", 3))
per <- unique(permn(letters))
length(per)



