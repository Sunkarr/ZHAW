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

lambda <- sum(anzahl * dens) / sum(dens)

1 - sum(dpois(0:4, lambda))


# Aufgabe 4


Mitarbeiter <- c(1, 2, 3, 4, 5)
Servicezeit <- c(1.3, 0.75, 1.2, 1.4, 0.9)
Zuestaendig <- c(0.06, 0.08, 0.21, 0.28, 0.37)
n <- 10000

A <- matrix(NA, nrow = n, ncol = length(Mitarbeiter))

for (i in 1:length(Mitarbeiter)) {
  A[, i] <- rpois(n, 6 * Zuestaendig[i]) * Servicezeit[i]
}

dat <- as.data.frame(A)
dat$Arbeitsstunden_pro_Tag <- apply(dat, MARGIN = 1, FUN = sum)

avg_Arbeitsstunden_pro_Tag <- mean(dat$Arbeitsstunden_pro_Tag)
avg_Arbeitsstunden_pro_Tag
q_75 <- quantile(dat$Arbeitsstunden_pro_Tag, 0.75)
q_75



