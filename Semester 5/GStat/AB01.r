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


# Aufgabe 2: Erwartungswert

# Wie lange müssen Sie im Mittel auf einen Anruf warten (gleiche Bedingungen
# wie in der Aufgabe 1)? Ermitteln Sie den Erwartungswert durch:

# a) Simulation (10000 Realisationen)
data <- rexp(10000, rate = 2/5)
mean(data)

# b) numerische Integration. Hinweis: ∞ kann in integrate() als Inf geschrieben werden.
funktion <- function(x) x * dexp(x = x, rate = 2/5)
integrate(funktion, lower = 0, upper = Inf)


# Aufgabe 3: Transformationen

# Aufgabe a)
pnorm(25, mean = 20, sd = 3, lower.tail = F)

# b) Ein Team amerikanischer Kollegen möchte die Ergebnisse reproduzieren,
# aber sie ziehen es vor, die Berechnungen in Grad Fahrenheit durchzuführen.
# Wie ist die Verteilung der Temperatur in Grad Fahrenheit?

# Umrechnung von Celsius in Fahrenheit: F = C * 9/5 + 32
f_mean <- 20 * 9/5 + 32
f_sd <- 3 * 9/5

# c) Wiederholen Sie die Berechnung in a) in Grad Fahrenheit.
pnorm(25 * 9/5 + 32, mean = f_mean, sd = f_sd, lower.tail = F)


# Aufgabe 4: Meinungsumfrage

# Aufgabe a)
pbinom(100, 200, 0.45, lower.tail = F)

# Aufgabe b)
pbinom(108, 200, 0.45, lower.tail = F)
