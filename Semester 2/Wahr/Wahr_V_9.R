# Aufgabe 1

lambda <- 1/1000
pexp(100, lambda)
pexp(1000, lambda)
pexp(1000, lambda, lower.tail = FALSE)
pexp(4000, lambda, lower.tail = F)
pexp(1200, lambda) - pexp(900, lambda)


# Aufgabe 2

pweibull(4, shape = 2.2, scale = 8.7, lower.tail = F)

x <- 1:100
plot(x, dweibull(x, shape = 2.2, scale = 8.7), type = "l", lwd = 2)

qweibull(0.05, 2.2, 8.7)

qweibull(0.632, 2.2, 8.7)

mean(rweibull(1000000, 2.2, 8.7))
8.7*gamma(1 + 1/2.2)


# Aufgabe 3
x <- 0:1000
plot(x, dgamma(x, shape = 2, rate = 1/100), type = "l", lwd = 2)

1 - pgamma(50, shape = 2, rate = 1/100)

qgamma(0.1, shape = 2, rate = 1/100)









