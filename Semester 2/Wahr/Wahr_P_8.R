# Aufgabe 1

dichte <- function(x){
  ifelse(x >= 2 & x <= 4, (1/6) * x, 0)
}

x <- seq(1, 5, 0.001)
plot(x, dichte(x), type = "l")
polygon(x=c(2.5,2.5,3,3),
        y=c(0, dichte(2.5), dichte(3),0), col="lightblue")


# Aufgabe 2


dichte <- function(x){
  ifelse(x >= 0, 2*x*(exp(-x)^2), 0)
}

x <- seq(0, 5, 0.001)
plot(x, dichte(x), type = "l")


# Aufgabe 3

1 - punif(10, 0, 40)

punif(20, 0, 40) - punif(10, 0, 40)

qunif(0.6, 0, 40)


# Aufgabe 3d)

set.seed(234)
n <- 100000
pers <- rpois(n, 3)
sim <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
    if (pers[i] <= 6) {
    sim[i] <- runif(1, 0, 40)
  } else if (pers[i] >= 7) {
    sim[i] <- runif(1, 0, 40) + runif(1, 30, 70)
  } else if (pers[i] <= 13) {
    sim[i] <- 0
  }
}
mean(sim)
