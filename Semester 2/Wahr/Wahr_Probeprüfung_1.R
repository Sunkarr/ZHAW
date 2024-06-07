# Aufgabe 3a

sum(dhyper(0:2, 16, 8, 4))


# Aufgabe 3b

qnorm(0.95, 6.28, 0.12)


# Aufgabe 4c

n <- 1000000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- rexp(1, 1/20) + runif(1,0,9) + rnorm(1, 15, 3)
}

quantile(m, 0.95)
mean(m)


# Aufgabe 7b

dpois(2, 2.02)^2

n <- 12
count <- 0
for (i in 1:n){
  count <- count + (dpois(i, 2.02)^2)
}
count


# Aufgabe 5a


library(Deriv)
# Definition der Funktion
f <- function(x) 2.5*(1/((x)^(7/2)))
# Berechnung des Integrals von f von 0 bis 1
integral_result <- integrate(f, lower = 1, upper = Inf)
print(integral_result)


install.packages("Ryacas0")
library(Ryacas0)

# Definieren Sie die Funktion als Ausdruck
fx <- expression(2.5 * (1/(x^(7/2))))

# Konvertieren Sie den Ausdruck in ein Yacas-Objekt
yacas_fx <- yacas(fx)

# Führen Sie die symbolische Integration durch
Fx <- Integrate(yacas_fx, "x")

# Anzeigen der Stammfunktion
cat(Fx)



# Aufgabe 6a

n <- 100000
x <- runif(n, -1, 1)
y <- runif(n, -1, 1)
r <- sqrt(x^2 + y^2)
scheibe <- sum(r < 1) ### Scheibe getroffen
scheibe / n # oder pi/4

be <- sum(r < 0.1)
be / scheibe







