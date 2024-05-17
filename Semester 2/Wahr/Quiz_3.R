library(Deriv)

# Definition der Funktion
f <- function(x) 8.28 * exp(-8.28 * x)

# Berechnung des Integrals von f von 0 bis 1
integral_result <- integrate(f, lower = 0, upper = 0.06)
print(integral_result)


pnorm(205, 2.3*80, sqrt(80*2.8^2))


n <- 1000000
M <- matrix(NA, nrow = n, ncol = 1)

for (i in 1:n){
  M[i,] <- (7 + runif(1, 0, 1.5)) *2 + rnorm(1, 6, 1.5) + rexp(1, 1/1.5) + 2
}

median(M)


pexp(19.8, 1/9) - pexp(0.7, 1/9)
pexp(19.8, 9) - pexp(0.7, 9)


4/3.9



