# Aufgabe 1

prob <- 288 / 8306

1 - sum(dbinom(x = 1:24, size = 24, prob = prob))

1 - sum(dbinom(x = 1:18, size = 18, prob = prob))

sum(dbinom(x = 5, size = 18, prob = prob))

sum(dbinom(x = 3:18, size = 18, prob = prob))

sum(dbinom(x = 0:2, size = 18, prob = prob))


# Aufgabe 2

sum(dbinom(0:(3720/2), size = 3720, prob = 1980/3720))
