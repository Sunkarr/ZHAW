n <- 100000

J <- matrix(NA, nrow = n, ncol = 5)
for (i in 1:n) {
  J[i,] <- sample(1:6, size = 5, replace = T)}

p <- c(87/4, 87/4, 87/4, 87/4, 44, 43)/100
S <- matrix(NA, nrow = n, ncol = 5)
for (i in 1:n) {
  S[i,] <- sample(1:6, size = 5, replace = T, prob = p)}

S <- as.data.frame(S)
S$Sum <- S$V1 + S$V2 + S$V3 + S$V4 +S$V5

J <- as.data.frame(J)
J$Sum <- J$V1 + J$V2 + J$V3 + J$V4 +J$V5

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



n <- 10000
p <- c(74/5, 74/5, 74/5, 74/5, 74/5, 26)/100
W <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n) {
  W[i,] <- sample(1:6, size = 1, replace = T, prob = p)}

E <- sum(W)/n
44/E



nsim <- 100000
count <- 0
punkte <-0
totpunkte <- 0
probs <- c(0.148,0.148,0.148,0.148,0.148,0.26)
for (i in 1:nsim) {
  while (punkte <44) {
    punkte = punkte + sample(1:6, size = 1, replace = TRUE,prob = probs)
    count = count + 1
  }
  punkte = 0
  totpunkte = totpunkte+ count
  count = 0
}

totpunkte / nsim



# Simulationsparameter
n_turbines <- 24
n_days <- 26
p_failure <- 0.08
n_simulations <- 100000

# Funktion zur Simulation eines Tages
simulate_day <- function() {
  failures <- sum(runif(n_turbines) < p_failure)
  return(failures)
}

# Simulationsschleife
count_multiple_failures <- 0
for (i in 1:n_simulations) {
  failures_per_day <- sapply(1:n_days, simulate_day)
  if (sum(failures_per_day >= 2) > 0) {
    count_multiple_failures <- count_multiple_failures + 1
  }
}

# Berechnung der Wahrscheinlichkeit und Ausgabe des Ergebnisses
probability <- count_multiple_failures / n_simulations
probability <- round(probability, 2)
print(paste("Wahrscheinlichkeit, dass 2 oder mehr Turbinen gleichzeitig ausfallen:", probability))



# Simulationsparameter
n_turbines <- 24
n_days <- 26
n_simulations <- 10000
prob <- c(92, 8)/100

M <- matrix(NA, nrow = n_simulations, ncol = n_days)

for (sim in 1:n_simulations){
  for (day in 1:n_days){
    x <- sum(sample(0:1, size = n_turbines, replace = TRUE, prob = prob))
    M[sim, day] <- x
  }
}

             