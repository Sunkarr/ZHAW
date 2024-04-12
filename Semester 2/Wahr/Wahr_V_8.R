# Aufgabe 1

dichte <- function(x){
  ifelse(x >= 0 & x <= 1, 6*x*(1-x), 0)
}

x <- seq(-1, 2, 0.001)
plot(x, dichte(x), type = "l")


# Aufgabe 2

punif(0.245, 0.24, 0.26)

1 - punif(0.253, 0.24, 0.26)

mean(runif(10000, 0.24, 0.26))
