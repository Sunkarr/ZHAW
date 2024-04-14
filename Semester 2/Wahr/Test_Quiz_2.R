# Anzahl intakter Teile

set.seed(1384)
median(rhyper(50, 30, 10, 4))


# Zugfahrten

sum(rbinom(39, 1, 0.04))


# Kleeblätter

rnbinom(1, 4, 0.08)


# Rote Ampel

qpois(0.93, 6, lower.tail = T)


# Spezialbrote beim Beck

n <- 100000
kunden_pro_tag <- rpois(n, 142.5)
count = 0
for (i in 1:n){
  kundspezbrot <- rbinom(1, kunden_pro_tag[i], 0.104)
  if (kundspezbrot <= 16){count = count + 1}
}
count/n


# Minigolf

mean(rgeom(100000, 0.2))


# Faule Äpfel

1 - sum(dbinom(0:2, 10, 0.23))

count = 0
n <- 10000
schlechte_aepfel <- rbinom(n, 10, 0.23)
for (i in 1:n){
  if (schlechte_aepfel[i] > 2){count = count + 1}
}
count/n


# Faule Eier

rhyper(10000, 13, 5, 5)


# Balkonblumen

dbinom(175, 350, 0.31)


# Party

sum(dgeom(0:3, 1/5))


# Unfälle

dpois(0, 1.2)


# Fischen

n <- 1000000
lambda_fische_pro_7h <- 330/24*7
fische_schwimmen_in_7h <- rpois(n, lambda_fische_pro_7h)
fische_gefangen_in_7h <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  fische_gefangen_in_7h[i,] <- rbinom(1, fische_schwimmen_in_7h[i], 0.08)
}
mean(fische_gefangen_in_7h)
