# Aufgabe 1

u <- runif(1000000)
x <- u^2
hist(x, freq = F)
fx <- function(x){1/(2*sqrt(x))}
lines(seq(0,1,0.001), fx(seq(0,1,0.001)), col = "red", lwd = 2)


# Aufgabe 2

n <- 100000
a <- rnorm(n, 15, 2)
b <- runif(n, 0, 12)
c <- rexp(n, 1/2) + 10
res <- a + b + c
hist(res)
quantile(res, 0.95)


# Beispiel Kartoffeln

n <- 1000
m <- matrix(runif(146*n, 9.75, 10.75), nrow = n, ncol = 146)
s146 <- apply(m, 1, sum)
hist(s146, freq = F)
