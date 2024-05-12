# Messdaten

hist(messdaten)

hist(log(messdaten))


# Mammutbäume

n <- 100000
stichprobe <- 42
E <- 2.69
sd <- 0.44
Einsatz <- 74
max <- 2.9
min <- 1.4

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

mean(M)


# Inversionsmethode

u <- runif(100000)
lambda <- 1.2
beta <- 3.7

g <- function(u){(1 / (3 * lambda)) * (-log(1 - u))^(beta / 3)}
x <- g(u)
mean(x)



