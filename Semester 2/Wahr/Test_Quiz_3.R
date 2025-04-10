# Messdaten

hist(messdaten, breaks = 100)

hist(log(messdaten))


# Mammutbäume

n <- 100000
stichprobe <- 24
E <- 4.0
sd <- 0.41
Einsatz <- 9.0
max <- 4.8
min <- 1.6

umfänge <- matrix(rnorm(n * stichprobe, E, sd) * pi, nrow = n)
gewinne <- rowSums(ifelse(umfänge > max, Einsatz, ifelse(umfänge < min, -Einsatz, 0)))
mean(gewinne)


# Montageband

n <- 100000
M <- matrix(NA, nrow = n, ncol = 1)

for (i in 1:n){
  find_sound <- rgeom(1, 0.62) + 1
  M[i,] <- rnorm(1, 26, 1) + 20 + sum(runif(find_sound, 8, 16)) + rexp(1, 1/39.6)
}

quantile(M, 0.8)


# Inversionsmethode

u <- runif(100000)
lambda <- 1.2
beta <- 3.7

g <- function(u){(1 / (3 * lambda)) * (-log(1 - u))^(beta / 3)}
x <- g(u)
mean(x)


# Wartezeiten Fluggäste

pexp(5, 1/5, lower.tail = F)


# Soda-Stream

pgamma(12, 3, 1/6, lower.tail = F)


# Anzahl gelaufener Kilometer einer Person

plnorm(11, 2.04, (0.12)^0.5)


# Durchmesser einer Gewindeschraube

pnorm(6.8, 6.3, 0.3) - pnorm(5.8, 6.3, 0.3)


# Wartezeit für Gondel auf den Rigi

punif(25, 0, 30) - punif(15, 0, 30)


# Windgeschwindigkeiten 

pweibull(3, 0.328, 3.1, lower.tail = F)


# Bedienungszeit pro Kunde

190/7

722/7


# Erwartungswert

library(Deriv)
# Definition der Funktion
f <- function(x) x*(0.25/(x+1))
# Berechnung des Integrals von f von 0 bis 1
integral_result <- integrate(f, lower = 0, upper = exp(4)-1)
print(integral_result)



