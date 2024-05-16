# Installiere und lade das Paket
# install.packages("Deriv")  # Paket installieren, dies muss nur einmal gemacht werden
library(Deriv)             # Paket laden

# Definition der Funktion
f <- function(x) x*(x^2 + 3*x + 2)

# Ableitung der Funktion f nach x
df <- Deriv(f, "x")
print(df)

# Berechnung des Integrals von f von 0 bis 1
integral_result <- integrate(f, lower = 0, upper = exp(1))
print(integral_result)


f <- function(x) x^2 + 3*x + 2
Deriv(f, "x")                  # Ableitung der Funktion f nach x

# Laden des Pakets
install.packages(pracma)
library(pracma)
# Definieren der Funktion, z.B. f(x) = x^2
f <- function(x) x^2
# Berechnen des unbestimmten Integrals (Stammfunktion)
F <- integrate(f, x)
# Ausgabe der Stammfunktion
print(F)
