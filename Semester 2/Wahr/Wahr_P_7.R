# Aufgabe 1

qnbinom(0.95 , 10, 0.09) + 10


# Aufgabe 2

# a)
dhyper(0, 3, 32, 4)

# b)
dhyper(1, 3, 32, 4)

# c)

dhyper(1, 3, 32, 4) / 3


# Aufgabe 3

anzahl <- c(0,1,2,3,4)
dens <- c(109,65,22,3,1)

lambda <- sum(anzahl * dens) / 200

1 - sum(dpois(0:4, lambda))





