# Aufgabe 1

library(mvtnorm)

mu <- c(75, 62)
(sigma <- matrix(c(10^2, 0.76*10*20, 0.76*10*20, 20^2), nrow = 2))

(n <- rpois(1, 60))
(n <- n - sum(sample(0:1, size = n, prob = c(0.95, 0.05), replace = T)))
M <- matrix(NA, nrow = n, ncol = 2)
for ( i in 1:n){
    M[i,] <- rmvnorm(1, mean = mu, sigma = sigma)
}

plot(M)


#---

x1 <- seq(0,100,1)
x2 <- seq(0,100,1)

z <- expand.grid(x1=x1,x2=x2)

f <- dmvnorm(z, mean = mu, sigma = sigma)

head(cbind(z,f))

fz <- matrix(f, nrow = length(x1), ncol = length(x2))

image(x1,x2,fz, las=1)
contour(x1,x2,fz, add=TRUE)

#--------------------------------

n <- 10000
v <- rep(NA, n)

mu <- c(75, 62)
(sigma <- matrix(c(10^2, 0.76*10*20, 0.76*10*20, 20^2), nrow = 2))

for (i in 1:n){
  v[i] <- rowSums(rmvnorm(1, mean = mu, sigma = sigma))
}

quantile(v, 0.75)

#--------------------------------

n <- 10000
M <- matrix(NA, nrow = n, ncol = 2)


mu <- c(75, 62)
(sigma <- matrix(c(10^2, 0.76*10*20, 0.76*10*20, 20^2), nrow = 2))

for (i in 1:n){
  M[i,] <- rmvnorm(1, mean = mu, sigma = sigma)
}

count_threshold <- function(m) {
  count <- 0
  for (i in 1:nrow(m)) {
    if (m[i, 1] >= 85 & m[i, 2] >= 70) {
      count <- count + 1
    }
  }
  return(count)
}

count_threshold(M) / n

#--------------------------------

n <- 10000
M <- matrix(NA, nrow = n, ncol = 2)


mu <- c(75, 62)
(sigma <- matrix(c(10^2, 0.76*10*20, 0.76*10*20, 20^2), nrow = 2))

for (i in 1:n){
  M[i,] <- rmvnorm(1, mean = mu, sigma = sigma)
}

count_threshold <- function(m) {
  count1 <- 0
  count2 <- 0
  for (i in 1:nrow(m)) {
    if (m[i, 1] < 70) {
      count1 <- count1 + 1
    }
    if (m[i, 1] < 70 & m[i, 2] >= 70) {
      count2 <- count2 + 1
    }
  }
  if (count2 == 0) {
    return(NA)  # Return NA if division by zero would occur
  } else {
    return(count2 / count1)
  }
}

count_threshold(M)



