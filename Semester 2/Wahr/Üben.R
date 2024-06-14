pnorm(205, 80*2.3, sqrt(80*2.8^2))


n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- 2*(7 + runif(1, 0, 1.5)) + rnorm(1, 6, 1.5) + rexp(1, 1/1.5) + 2
}
median(m)


pexp(19.8, 9) - pexp(0.7, 9)


dnbinom(8, 9, 0.3)


ppois(4, 1.2, lower.tail = F)


choose(42, 5) * choose(8, 2)


0.0004*2000
pbinom(1, 2000, 0.0004, lower.tail = F)
qbinom(0.99, 2000, 0.0004)


pexp(1, 1/15)
pgamma(30, 4, 1/15)


350 - qnorm(0.95, 0, 0.15)


prob <- c(0.3, 0.2, 0.15, 0.15, 0.1, 0.1)
preis <- c(5, 5.5, 7.5, 8.5, 13, 19.5)

ew <- sum(prob * preis)
var <- sum(prob * (preis^2)) - ew^2

ew_1000 <- ew * 1000
sd_1000 <- sqrt(var*1000)


n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
pakete <- rpois(n, 2500)
for (i in 1:n){
  m[i,] <- ceiling(sum(rlnorm(pakete[i], 2, 1.2)) / 1200)
}
quantile(m, 0.95)
hist(m)


pnbinom(1, 2, 0.45, lower.tail = F)
pbinom(1, 3, 0.45)


library(combinat)
per <- permn(c(rep("A", 5), rep("B", 3)))
unique(per)


phyper(2, 8, 16, 4)

qnorm(0.95, 6.28, 0.12)

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- rexp(1, 1/20) + runif(1, 0, 9) + rnorm(1, 15, 3)
}
mean(m)


pnorm(11.5, 12.9, sqrt(4), lower.tail = F)
pnorm(14.5, 12.9, sqrt(4)) - pnorm(11, 12.9, sqrt(4))
pnorm(14, 12.9, sqrt(4))

dpois(0, 3.5)

pbinom(45, 50, 5/6, lower.tail = F)

qunif(0.6, 0, 12)

ppois(0, 160/365*3)

pgamma(5, 2, 1/2, lower.tail = F)



