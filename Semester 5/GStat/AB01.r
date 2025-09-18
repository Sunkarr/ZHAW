# Aufgabe 1

# Berechnen Sie die Wahrscheinlichkeit, dass die Zufallsvariable X einen Wert zwischen 2 und 10 annimmt mit folgenden Verfahren:

funktion <- function(x) {
  return((2/5) * exp(-(2/5) * x))
}

# a) Durch Simulation mittles der R-Funktion rexp() (10000 Realisationen). Zeichnen Sie ferner das Histogramm.



# histogramm der Realisationen
data <- rexp(10000, rate = 2/5)
hist(data, breaks = 50
     , main = "Histogramm der Realisationen"
     , xlab = "Werte"
     , ylab = "Häufigkeit"
     , col = "lightblue"
     , border = "black")

# c) Unter Verwendung der R-Funktion pexp()
pexp(10, rate = 2/5) - pexp(2, rate = 2/5)

# d) Durch das numerische Integral mithilfe der R-Funktion integrate() und der
# Dichte dexp(). Für die Funktion integrate() brauchen Sie eine Funktion,
# diese können Sie mittels fun <- function(x) dexp(x = x, rate = 2/5) definieren.

funktion <- function(x) dexp(x = x, rate = 2/5)
integrate(funktion, lower = 2, upper = 10)
