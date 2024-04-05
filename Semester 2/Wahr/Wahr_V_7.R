# Aufgabe 1

# a) P(X = 4)
dnbinom(4, 12, 0.45)

# b) P(X < 8) = P(X <= 7)
sum(dnbinom(0:7, 12, 0.45))

# c)
12*0.55/0.45 + 12
12*0.55/0.45 # mittlere Anzahl missglückter Würfe


# Aufgabe 2

# c)
dhyper(0, 4, 10, 5)

# d)
sum(dhyper(0:2, 4, 10, 5))
phyper(2, 4, 10, 5)


# Aufgabe 3¨

# d)

dpois(0:10, 3.8)

