sum(dbinom(x = 20:22, size = 22, prob = 28/34))

## Wahrscheinlichkeitsverteilung
dbinom(0:32, size = 32, prob = 0.695)
plot(dbinom(0:32, size = 32, prob = 0.695), type = "h")


# AB2

dbinom(x = 8, size = 16, prob = 1/4)
sum(dbinom(x = 9:16, size = 16, prob = 1/4))

qbinom(0.95, 16, 1/4)

mean(rbinom(10000, 16, 1/4))

dgeom(10, 0.001)


# AB3

dgeom(10, 0.001)

1 - sum(dgeom(0:1199, 0.001))

1 - sum(dgeom(0:1199, 0.001))

qgeom(0.95, 0.001)

E <- (1-0.001)/0.001
Var <- (1-0.001)/0.001**2
