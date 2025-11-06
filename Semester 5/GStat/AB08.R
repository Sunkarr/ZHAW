# Aufgabe 1


qbinom(0.95, 20, 0.5)
sum(dbinom(x = 14:20, size = 20, prob = 0.5))
sum(dbinom(x = 15:20, size = 20, prob = 0.5))

binom.test(15, 20, p = 0.5, alternative = "greater")


# Aufgabe 2

binom.test(47, 120, p = 0.3, alternative = "greater")


# Aufgabe 3

binom.test(24, (24+19), p = 0.52, alternative = "greater")


# Aufgabe 5

qpois(0.95, 8.4)
ppois(11:15, 8.4)

ppois(10, 8.4, lower.tail = FALSE)

poisson.test(11, 8.4, alternative = "greater")
