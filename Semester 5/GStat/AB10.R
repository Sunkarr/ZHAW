# Aufgabe 2

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/blutdruck.Rdata")

# test variance
var(blutdruck$x) / var(blutdruck$y)

# t.test with var.equal = TRUE
t.test(x = blutdruck$x,
       y = blutdruck$y,
       var.equal = TRUE,
       paired = FALSE,
       alternative = "greater")

# Aufgabe 3

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/hals.Rdata")

t.test(x = hals$Before,
       y = hals$After,
       paired = TRUE,
       conf.level = 0.99,
       alternative = "two.sided")


# Aufgabe 4

binom.test(15, 50, p = 0.5, alternative = "less")

# Simulation
# Zehn Filialen 50 verkaufte Einheiten, 50% chance auf zusätzlichen Service
# Zähle in wie vielen Filialen der Service gewählt wurde

n_sim <- 10000
results <- vector(mode = "numeric", length = n_sim)
for (i in 1:n_sim) {
  results[i] <- min(rbinom(10, size = 50, prob = 0.5))
}
# calculate the probabilties of error type I
sum(results < 19) / n_sim


# Aufgabe 5

data(chickwts)
boxplot(weight ~ feed, data = chickwts)

pairwise.t.test(chickwts$weight,
                chickwts$feed,
                p.adjust.method = "none")

pairwise.t.test(chickwts$weight,
                chickwts$feed,
                p.adjust.method = "bonferroni")


# Aufgabe 6

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/isolier.Rdata")

# Addieren nach Hersteller
counts <- tapply(isolier$Fehler, isolier$Hersteller, sum)

# Fünf Poissontests durchführen
poistst <- function(x) poisson.test(x, T = 10, r = 7, alternative = "less")$p.value
pWerte <- sapply(counts, poistst)
pWerte <= 0.05
pWerte.adjusted <- p.adjust(pWerte, method = "bonferroni")
pWerte.adjusted <= 0.05
