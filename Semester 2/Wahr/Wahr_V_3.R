farben <- c("Kreuz", "Herz", "Pik", "Karo")
nummern <- c(2:10, "Bube", " Dame", "Koenig", "Ass")
deck <- expand.grid(Farbe=farben, Nummer=nummern)
deck <- paste(deck$Farbe, deck$Nummer)
asse <- paste(farben, "Ass")

set.seed(123)
n <- 100000
haende <- matrix(NA, nrow = n, ncol = 2)
for (i in 1:n){
  haende[i,] <- sample(deck, size = 2, replace = F)}

# P(Ass 1 und Ass 2)
nAA <- sum(haende[,1] %in% asse & haende[,2] %in% asse)

# Haeuffigkeit für Ass 1
nA1 <- sum(haende[,1] %in% asse)

# Bedingte Wahr
nAA / nA1


# Aufgabe 4

# a)

wahr <- function(Praevalenz, Sensitivitaet, Spezifizitaet){
  x <- (Sensitivitaet * Praevalenz) / ((Sensitivitaet * Praevalenz) + ((100-Spezifizitaet)*(100-Praevalenz)))
  return(x)
}

wahr(0.5, 99.7, 98.5)

# b)

wahr(0.5, 99.7, 98.5)**2

# c)

prae <- seq(0.001, 0.3, 0.001)
wahr(0.5, 99.7, 98.5)

hivpositiv <- c()

for (i in 1:length(prae)){
  hivpositiv[i] <- wahr(i, 99.7, 98.5)
}

dhivpositiv <- data.frame(prae, hivpositiv)
plot(dhivpositiv)




