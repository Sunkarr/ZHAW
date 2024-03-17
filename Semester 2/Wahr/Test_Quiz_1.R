n <- 100000

J <- matrix(NA, nrow = n, ncol = 4)
for (i in 1:n) {
  J[i,] <- sample(1:6, size = 4, replace = T)}

p <- c(7/2, 7/2, 7/2, 7/2, 41, 45)/100
S <- matrix(NA, nrow = n, ncol = 4)
for (i in 1:n) {
  S[i,] <- sample(1:6, size = 4, replace = T, prob = p)}

S <- as.data.frame(S)
S$Sum <- S$V1 + S$V2 + S$V3 + S$V4

J <- as.data.frame(J)
J$Sum <- J$V1 + J$V2 + J$V3 + J$V4

win_S <- S$Sum > J$Sum
sum(win_S)





set.seed(42) # Setzen des Zufallszahlengenerators für die Reproduzierbarkeit

# Funktion zur Simulation des Ausfalls einer Windturbine an einem Tag
turbine_ausfall <- function(wahrscheinlichkeit) {
  if (runif(1) < wahrscheinlichkeit) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Funktion zur Simulation der Anzahl von Turbinenausfällen in 27 Tagen
simuliere_ausfälle <- function(n) {
  ausfälle <- replicate(n, {
    anzahl_ausfälle <- 0
    for (i in 1:27) {
      if (turbine_ausfall(0.08)) {
        anzahl_ausfälle <- anzahl_ausfälle + 1
      }
    }
    anzahl_ausfälle
  })
  return(ausfälle)
}

# Durchführung der Simulation mit n = 100000
sim_results <- simuliere_ausfälle(100000)

# Berechnung des Anteils von Tagen mit 2 oder mehr Turbinenausfällen
anteil <- mean(sim_results >= 2)

# Ausgabe des Ergebnisses auf zwei Nachkommastellen
print(round(anteil, 2))

