# Aufgabe 1

x <- 0:20
plot(x, pexp(x, 0.34), type = "l", lwd = 2)

pexp(1, 0.34)

pexp(5, 0.34) - pexp(4, 0.34)

n <- 100000
hist(rexp(n, 0.34) + rexp(n, 0.34) + rexp(n, 0.34), freq=F)
lines(0:40, dgamma(0:40, shape = 3, rate = 0.34), col = "blue", lwd = 2)




