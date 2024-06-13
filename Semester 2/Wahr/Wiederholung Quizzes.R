pnorm(205, mean = (80*2.3), sd = (sqrt(80*(2.8)^2)))

n <- 1000000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <-2*(7 + runif(1, 0, 1.5)) + rnorm(1, mean = 6, sd = 1.5) + rexp(1, 1/1.5) + 2
}
median(m)


pexp(19.8, 9) - pexp(0.7, 9)


dnbinom(8, 9, 0.3)

23*0.72

n <- 100000
m <- matrix(NA, ncol = 1, nrow = n)
for (i in 1:n){
  fische <- rpois(1, 273/24*4)
  m[i,] <- sum(rbinom(1, fische, 0.1))
}
mean(m)


1 - sum(dpois(0:4, 1.2))
ppois(4, 1.2, lower.tail = F)


pgeom(5, 0.4)
pnbinom(5, 1, 0.4)


n <- 100000
prob <- c(rep(0.156, 5), 0.22)
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  points = 0
  count = 0
  while (points < 48){
    points = points + sample(1:6, 1, prob = prob, replace = T)
    count = count + 1
  }
  m[i,] <- count
}

mean(m)



