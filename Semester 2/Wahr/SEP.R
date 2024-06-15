n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
     sportklub <- sum(sample(0:1, size = 100, prob = c(0.75, 0.25), replace = T))
     rest <- 100 - sportklub
     m[i,] <- sum(sample(0:1, sportklub, c(0.2, 0.8), replace = T)) + sum(sample(0:1, rest, c(0.7, 0.3), replace = T))
}

hist(m)
quantile(m, 50)
x <- ecdf(m)
1 - x(50)


dpois(6, 4)
ppois(50, 40, lower.tail = F)


pnorm(501, 500, 10) - pnorm(499, 500, 10)


u <- runif(100000)
g <- function(x){(-2*log(1-x))^0.5}
a <- g(u)
quantile(a, 0.2)


n <- 100000
m <- matrix(NA, ncol = 1, nrow = n)
for (i in 1:n){
  ballade <- sum(sample(0:1, 30, c(1 - 1/95*35, 1/95*35), replace = T))
  rock <- 30 - ballade
  m[i,] <- sum(rnorm(ballade, 4.2, 1.3)) + sum(rnorm(rock, 3.5, 0.8))
}
mean(m)
quantile(m, 0.95)

library(mvtnorm)
mu <- c(30, 50)
sigma <- matrix(c(100, 120, 120, 400), nrow = 2)
pmvnorm(lower = c(40, 60), upper = Inf, mean = mu, sigma = sigma)



