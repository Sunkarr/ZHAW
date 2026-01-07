# GStat Lernhpase Übungen

## SW02 Aufgabe 1: Zentraler Grenzwertsatz

# Parameter
mu <- 2/3
var_x <- 1/18
n <- 30

# Standardabweichung des Stichprobenmittels (Standardfehler)
sd_quer <- sqrt(var_x / n)

# Wahrscheinlichkeit berechnen P(X_quer < 0.75)
pnorm(0.75, mean = mu, sd = sd_quer)

# Simulation
n <- 30
N <- 100000
data <- matrix(NA, nrow = N)
for (i in 1:N) {
  sample_data <- rnorm(n, mu, sqrt(var_x))
  data[i] <- mean(sample_data)
}
hist(data)
sum(data < 0.75) / N


## SW02 Aufgabe 2: QQ-Plot

library(readr)
kunden <- read_csv("Documents/GitHub/ZHAW/Semester 5/GStat/Daten/kunden.csv")
kunden <- kunden$x
quant <- c(0.05, 0.25, 0.5, 0.75, 0.9, 0.975)
quantile(kunden, quant)

hist(kunden)
library("car")
par(mfrow = c(1,2))
qqPlot(kunden, distribution = "norm", main = "QQ-Plot Normalverteilung")
qqPlot(kunden, distribution = "exp", main = "QQ-Plot Exponentialverteilung")
par(mfrow = c(1,1))

par(mfrow = c(1,2))
qqPlot(kunden, distribution = "exp", rate = 0.65, main = "lambda = 0.65")
qqPlot(kunden, distribution = "exp", rate = 0.5, main = "lambda = 0.5")
par(mfrow = c(1,1))


## SW03 Aufgabe 1: Schätzung von λ bei der Exponentialverteilung

n <- 5
N <- 10000
data <- matrix(NA, nrow = N)
for (i in 1:N) {
  sample_data <- rexp(n, rate = 2)
  lambda_hat <- 1 / mean(sample_data)
  data[i] <- lambda_hat
}
hist(data, breaks = 30, main = "Verteilung der Schätzer λ̂", xlab = "λ̂")
mean(data)
bias <- mean(data) - 2
bias
MSE <- var(data) + bias^2
MSE


# SW03 Aufgabe 2: Varianzschätzung verzerrt (biased) und unverzerrt (unbiased)

s1 <- function(x) {
  n <- length(x)
  (1/n-1) * sum((x - mean(x))^2)
}
s2 <- function(x) {
  n <- length(x)
  (1/n) * sum((x - mean(x))^2)
}
n <- 1000
data_s1 <- matrix(NA, nrow = n)
data_s2 <- matrix(NA, nrow = n)
for (i in 1:n) {
  sample_data <- rnorm(3)
  data_s1[i] <- s1(sample_data)
  data_s2[i] <- s2(sample_data)
}
par(mfrow = c(1,2))
hist(data_s1, breaks = 30, main = "Varianzschätzung s1", xlab = "s1")
abline(v = mean(data_s1), col = "red", lwd = 2)
hist(data_s2, breaks = 30, main = "Varianzschätzung s2", xlab = "s2")
abline(v = mean(data_s2), col = "red", lwd = 2)
par(mfrow = c(1,1))
mean(data_s1)
mean(data_s2)


# SW03 Aufgabe 4: Effizienz: Mittelwert vs. Median

n <- 20
N <- 10000
data_mean <- matrix(NA, nrow = N)
data_median <- matrix(NA, nrow = N)
for (i in 1:N) {
  sample_data <- rnorm(n)
  data_mean[i] <- mean(sample_data)
  data_median[i] <- median(sample_data)
}
MSE_mean <- var(data_mean)
MSE_median <- var(data_median)
MSE_mean
MSE_median
effizienz <- MSE_median / MSE_mean
effizienz
# Der Mittelwert ist effizienter als der Median in Bezug auf die MSE.


# SW04 Aufgabe 1: ML-Schätzer für die Binomial- und Exponentialverteilung

library(fitdistrplus)
data <- c(1, 2, 3)
lambda.mle <- fitdist(data = data, distr = "exp", method = "mle")
lambda.mle$estimate


# SW04 Aufgabe 2: Maximum-Likelihood-Schätzung bei Normalverteilung

xs <- c(-0.033, -0.76, 2.02, 1.13, 0.65, 0.49, 0.76, 0.40, 0.10, 0.61)
loglik <- function(mu, sigma, dat) {
  sum(dnorm(x = dat, mean = mu, sd = sigma, log = TRUE))
}
loglik(mu = 0, sigma = 1, dat = xs)

gitter <- expand.grid(mu = seq(0.5, 0.6, 0.001), sigma = seq(0.6, 0.75, 0.001))
m <- dim(gitter)[1]
lik <- rep(-Inf, m)
for (i in 1:m) {
  lik[i] <- loglik(mu = gitter[i, 1], sigma = gitter[i, 2], dat = xs)
}
gitter[which.max(lik), ]

lik <- function(param) {
  -loglik(mu = param[1], sigma = param[2], dat = xs)
}
optim(c(0.5,0.5), lik)

norm.mle <- fitdist(data = xs, distr = "norm", method = "mle")
norm.mle$estimate


# SW04 Aufgabe 3: Maximum-Likelihood-Schätzung

f <- function(theta, x) {
  theta * x^(theta - 1)
}
theta_values <- c(1/3, 1/2, 1, 2, 3)
theta_values_rounded <- round(theta_values, digits = 3)
x_values <- seq(0, 1, by = 0.001)
plot(NULL, xlim = c(0, 1), ylim = c(0, 3), xlab = "x", ylab = "f(x; θ)", main = "Dichtefunktionen für verschiedene θ")
colors <- rainbow(length(theta_values))
for (i in 1:length(theta_values)) {
  theta <- theta_values[i]
  f_values <- f(theta, x_values)
  lines(x_values, f_values, col = colors[i], pch = 19)
}
legend("topleft", legend = paste("θ =", theta_values_rounded), col = colors, pch = 19)


# SW04 Aufgabe 5: Capture-Recapture (Karpfen / Fische)

mögliche_fische <- seq(0, 200, 1)
wahr <- dhyper(x = 3, m = 20, n = mögliche_fische, k = 15)
plot(mögliche_fische, wahr, 
     type = "line", 
     pch = 19, 
     col = "blue",
     xlab = "Anzahl Fische im See", 
     ylab = "Likelihood", 
     main = "Likelihood Funktion (Capture-Recapture)")
# Max MLE
max <- which.max(wahr)
abline(v = max, col = "red", lty = 2)
dhyper(x = 3, m = 20, n = 78:81, k = 15)
# Wir erhalten also als Schätzung 79 bzw. 80 (für beide Werte ist die Likelihood gleich gross!)
# unmarkierte Fische, was zusammen mit den markierten 99 bzw. 100 Fische im See ergibt.


# SW06 Aufgabe 1: Simulation des Konfidenzintervalls

library(BSDA)
mu <- 5
sigma <- 2
n <- 30
m <- 10000

matrix <- matrix(NA, nrow = m)
for (i in 1:m) {
  sample_data <- rnorm(n, mean = mu, sd = sigma)
  ci <- z.test(sample_data, sigma.x = sigma, conf.level = 0.95)$conf.int
  matrix[i] <- (ci[1] <= mu) & (ci[2] >= mu)
}
length(which(matrix == TRUE)) / m


# SW06 Aufgabe 2: Konfidenzintervalle: Waschmittel

mu <- 6.09
sd <- 0.02
n <- 1219
x_strich <- 6.048
alpha <- 0.1
x_strich + c(-1, 1) * qnorm(1 - alpha/2) * (sd / sqrt(n))

pnorm(6, mean = 6.048, sd = sd)

(2*(sd/0.001)*qnorm(1 - alpha/2))^2


# SW06 Aufgabe 5: Kaffeemaschine

x <- c(104, 103, 107, 105, 102, 109, 105, 104, 106)
t.test(x, alternative = "two.sided", conf.level = 0.95)$conf.int


# SW07 Aufgabe 1: Konfidenzintervalle für Anteile

binom.test(x=35, n=487)$conf.int

binom.test(x=2, n=44, conf.level = 0.9)$conf.int


# SW07 Aufgabe 2: Konfidenzintervalle für Poisson-Intensitätsparameter

poisson.test(62, T = 1)$conf.int

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/asbestos.RData")
asbestos
poisson.test(x = sum(asbestos), T = length(asbestos), conf.level = 0.99)$conf.int


# SW07 Aufgabe 3: Bootstrap-Konfidenzintervalle für Median und Quartilsdispersionskoeffizient
library(boot)
# load galaxies from package MASS
library(MASS)
data(galaxies)
estimator_median <- function(data, indices) {
  median(data[indices])
}
boot_median <- boot(data = galaxies, statistic = estimator_median, R = 5000)
boot.ci(boot_median, type = "perc", conf = 0.95)

QDK <- function(data, indices) {
  sample_data <- data[indices]
  Q1 <- quantile(sample_data, 0.25)
  Q3 <- quantile(sample_data, 0.75)
  median <- median(sample_data)
  QDK_value <- (Q3 - Q1) / median
  return(QDK_value)
}
boot_QDK <- boot(data = galaxies, statistic = QDK, R = 5000)
boot.ci(boot_QDK, type = "perc", conf = 0.99)


# SW07 Aufgabe 4: Bootstrap-Konfidenzintervall für Korrelationskoeffizient

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/spatial.Rdata")
plot(spatial)
cor(spatial)

library(boot)
schaetzer <- function(dat, ind) cor(dat[ind, "A"], dat[ind, "B"])
boot.erg <- boot(data = spatial, statistic = schaetzer, R = 1000)
hist(boot.erg$t)
boot.ci(boot.erg, conf = 0.90, type = "bca")


# SW08 Aufgabe 2: Biomilch

qbinom(0.95, size = 20, prob = 0.5)
sum(dbinom(x = 14:20, size = 20, prob = 0.5))
sum(dbinom(x = 15:20, size = 20, prob = 0.5))

sum(dbinom(x = 15:20, size = 20, prob = 0.5))

binom.test(x = 15, n = 20, conf.level = 0.95, alternative = "greater")


# SW08 Aufgabe 3: Bauteil

binom.test(x = 47, n = 120, conf.level = 0.95, alternative = "greater", p = 0.3)


# SW08 Aufgabe 4: Appenzell-AR ein Bubenkanton?

binom.test(x = 24, n = 43, p = 0.52, conf.level = 0.95, alternative = "greater")


# SW08 Aufgabe 5: Verkehrsunfälle

## Annahmebereich
qpois(0.95, lambda = 8.4)
1 - sum(dpois(x = 0:13, lambda = 8.4))
### Der Annahmebereich ist [0, 13]
### Der Verwerfungsbereich ist [14, ∞)

## p-Wert
1 - ppois(10, lambda = 8.4)

poisson.test(x = 11, r = 8.4, alternative = "greater")$p.value


# SW09 Aufgabe 1: Webfehler

poisson.test(x = 9 + 8 + 12, T = 9, r = 3, alternative = "greater")


# SW09 Aufgabe 2: Luftfahrtunfälle

poisson.test(x = c(107, 126), alternative = "less")


# SW09 Aufgabe 3: Unterlegscheiben

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/unterlegscheiben.RData")


# SW09 Aufgabe 4: Kugelschreiber

pt(-2.3, df = 17)


# SW09 Aufgabe 5: Müllverbrennungsanlage

t <- sqrt(50) * (148 - 150) / 3
pt(t, df = 49)


# SW10 Aufgabe 2: Blutdruck

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/blutdruck.Rdata")
t.test(blutdruck$x, blutdruck$y, alternative = "greater", paired = F)


# SW10 Aufgabe 3: Hals- und Schulterprobleme
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/hals.Rdata")
hals$diff <- hals$Before - hals$After
t.test(hals$diff, alternative = "two.sided", mu = 0)
t.test(x = hals$Before, y = hals$After, alternative = "two.sided", paired = TRUE)


# SW10 Aufgabe 4: Wärmepumpen

binom.test(x = 15, n = 50, p = 0.5, alternative = "less")

n_sim <- 10000
ergebnisse <- numeric(n_sim) # Vektor zum Speichern der p-Werte
for (i in 1:n_sim) {
  # 1. Simuliere 10 Filialen, die jeweils 50 Versuche haben (p=0.5)
  filialen <- rbinom(10, size = 50, prob = 0.5)
  
  # 2. Finde die "schlechteste" Filiale (Minimum der Abonnements)
  schlechteste <- min(filialen)
  
  # 3. Führe für DIESE eine Filiale den Binomialtest durch
  # H0: p = 0.5, H1: p < 0.5 (einseitig "weniger erfolgreich")
  test <- binom.test(x = schlechteste, n = 50, p = 0.5, alternative = "less")
  
  # 4. Speichere den p-Wert
  ergebnisse[i] <- test$p.value
}

# 5. Berechnung: Wie oft ist der p-Wert <= 0.05?
falsch_beschuldigt <- mean(ergebnisse <= 0.05)

print(paste("Wahrscheinlichkeit für falsche Beschuldigung:", falsch_beschuldigt))


# SW10 Aufgabe 5: Multiples Testen: Kükengewicht


data("chickwts")
boxplot(weight ~ feed, data = chickwts, main = "Kükengewicht nach Futterart", xlab = "Futterart", ylab = "Gewicht (g)")

pairwise.t.test(chickwts$weight, chickwts$feed, p.adjust.method = "none", pool.sd = F)

pairwise.t.test(chickwts$weight, chickwts$feed, p.adjust.method = "bonferroni", pool.sd = F)


# SW10 Aufgabe 6: Multiples Testen: Lieferantenwechsel

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/isolier.Rdata")
hist(isolier$Fehler)



# SW11 Aufgabe 1: Natriumaufnahme

sodium <- readRDS("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/sodium.rds")
t.test(sodium, mu = 1500, alternative = "two.sided", conf.level = 0.99)


# SW11 Aufgabe 2: Güte des t-Tests

n <- c(3:20)
sim <- function(n, alpha = 0.05, runs = 10000) {
  pvals <- replicate(
    runs,
    t.test(rnorm(n, mean = 1, sd = 1), mu = 0, alternative = "greater")$p.value)
  sum(pvals < alpha) / runs
}

res.simu <- sapply(n, sim)
plot(n, res.simu, type = "line")

power.t.test(n = NULL, delta = 1, sd = 1, sig.level = 0.05, power = 0.99, alternative = "one.sided", type = "one.sample")


# SW11 Aufgabe 3: Simulation von p-Werten beim t-Test

n <- 10000
m <- 10
p_values <- numeric(n)
for (i in 1:n) {
  sample_data <- rnorm(m, mean = 0, sd = 1)
  test_result <- t.test(sample_data, mu = 0, alternative = "two.sided")
  p_values[i] <- test_result$p.value
}
hist(p_values, breaks = 20, main = "Verteilung der p-Werte", xlab = "p-Wert", ylab = "Häufigkeit")
length(p_values[p_values < 0.05]) / n

for (i in 1:n) {
  sample_data <- rnorm(m, mean = 1, sd = 1)
  test_result <- t.test(sample_data, mu = 0, alternative = "two.sided")
  p_values[i] <- test_result$p.value
}
hist(p_values, breaks = 20, main = "Verteilung der p-Werte", xlab = "p-Wert", ylab = "Häufigkeit")
length(p_values[p_values < 0.05]) / n


# SW12 Aufgabe 1: Behandlung gegen Blutarmut

n <- 10000

HaeKonz <- c(9.1, 10.3, 11.0, 11.5, 11.9, 8.1, 8.4, 9.2, 9.4)
Gruppe <- c(rep("b", 5), rep("k", 4))
dat <- data.frame(HaeKonz, Gruppe)
dat$Gruppe <- as.factor(dat$Gruppe)

p <- combinat::permn(Gruppe) # erzeugt alle Permutationen
p <- p[!duplicated(p)] # lösche Duplikate

(m <- tapply(dat$HaeKonz, dat$Gruppe, mean))
(stat <- as.numeric(m[1] - m[2]))

stati <- rep(NA, length(n))
for (i in 1:n) {
  dat$Gruppe <- sample(x = dat$Gruppe, replace = FALSE)
  m <- tapply(dat$HaeKonz, dat$Gruppe, mean)
  stati[i] <- abs(m[1] - m[2])
}
hist(stati)
mean(stati > stat)

library(coin)
independence_test(formula = HaeKonz ~ Gruppe,
                  data = dat,
                  alternative = "two.sided",
                  distribution = "exact")


# SW12 Aufgabe 2: Sand

sand_1 <- c(0.17, 0.63, 0.35, 0.49, 0.18, 0.43, 0.12, 0.20, 0.47, 1.36, 0.51, 0.45, 0.84, 0.32, 0.40)
sand_2 <- c(1.13, 0.54, 0.96, 0.26, 0.39, 0.88, 0.92, 0.53, 1.01, 0.48, 0.89, 1.07, 1.11, 0.58)
sand <- data.frame(
  menge = c(sand_1, sand_2),
  gruppe = factor(rep(c("1", "2"), times = c(length(sand_1), length(sand_2))))
)

library(coin)
wilcox_test(menge ~ gruppe,
            data = sand,
            alternative = "two.sided",
            conf.level = 0.99,
            distribution = "exact")


# SW12 Aufgabe 3: Bremswege

library(readr)
reifen <- read_csv("Documents/GitHub/ZHAW/Semester 5/GStat/Daten/reifen.csv")
boxplot(reifen$`Profil A sA in m`, reifen$`Profil B sB in m`,
        names = c("Profil A", "Profil B"),
        main = "Bremswege für verschiedene Reifenprofile",
        ylab = "Bremsweg (m)")
hist(reifen$`Profil A sA in m`, main = "Histogramm Bremswege Profil A", xlab = "Bremsweg (m)")
hist(reifen$`Profil B sB in m`, main = "Histogramm Bremswege Profil B", xlab = "Bremsweg (m)")

wilcox.test(x = reifen$`Profil A sA in m`,
            y = reifen$`Profil B sB in m`,
            alternative = "two.sided",
            paired = T,
            exact = T)


# SW13 Aufgabe 1: Umfragedaten einer Tourismusgesellschaft

frau <- c(68, 130, 84)
mann <- c(137, 72, 26)
data <- matrix(c(frau, mann), nrow = 2, byrow = TRUE)
colnames(data) <- c("kaum", "etwas", "stark")
rownames(data) <- c("Frau", "Mann")

(erwartet <- outer(rowSums(data), colSums(data)) / sum(data))

Tstat <- sum((data - erwartet)^2 / erwartet)
freiheitsgrade <- (nrow(data) - 1) * (ncol(data) - 1)
qchisq(0.95, df = freiheitsgrade)
1 - pchisq(Tstat, df = freiheitsgrade)

chisq.test(data)


# SW13 Aufgabe 2: Überlebenschancen von Haustieren

haustierbesitzer <- c("Nein", "Ja")
geschlecht <- c("Frau", "Mann")
data <- matrix(c(28, 50, 11, 3), nrow = 2, byrow = TRUE)
colnames(data) <- haustierbesitzer
rownames(data) <- geschlecht


# SW13 Aufgabe 3: Nervenzusammenbruch

nervenzusammenbruch <- c("Ja", "Nein")
verheiratet <- c("Verheiratet", "Nicht verheiratet")
Frauen <- matrix(c(143, 5, 431, 57), nrow = 2, byrow = TRUE)
Männer <- matrix(c(40, 9, 503, 90), nrow = 2, byrow = TRUE)
colnames(Frauen) <- verheiratet
rownames(Frauen) <- nervenzusammenbruch
colnames(Männer) <- verheiratet
rownames(Männer) <- nervenzusammenbruch

(nerv.test.frau <- chisq.test(Frauen))
(nerv.test.mann <- chisq.test(Männer))

nerv.test.frau$expected
nerv.test.mann$expected

Kombiniert <- Frauen + Männer
prop.table(Kombiniert, margin = 2)
(nerv.test.kombiniert <- chisq.test(Kombiniert))
# create a mosaic plot of residuals
mosaicplot(Kombiniert, main = "Mosaikplot Nervenzusammenbruch vs. Verheiratet", shade = TRUE)

#-------------------------------------------------------------------------------

# Probeprüfung GStat HS2022

# Aufgabe 1: Maximum Likelihood Estimation
## a)

llh_sol <- function(theta, x){sum(log( 2*theta^2*x*exp(-(theta*x)^2)))}

llh <- function(theta, x){
  sum(log(2) + 2*log(theta) + log(x) - theta^2 * x^2)
}

d <- c(5, 4, 3, 2, 5, 4, 2, 6, 2, 1, 1)
llh(theta = 0.2, x = d)

## b)
negll <- function(theta, x){
  -sum(log(2) + 2*log(theta) + log(x) - theta^2 * x^2)
  }

start <- c(max(d), min(d))
optim(par = start, fn = negll, x = d)


# Aufgabe 2: Multiple Choic

power.t.test(n=100, delta = 1, sd = 1, sig.level = 0.05)



# Aufgabe 3: Testen

ohne_Besch <- c(120, 130, 150, 90, 100, 140)
mit_Besch <- c(180, 130, 120, 190, 220, 120)

brillen <- data.frame(endorphine = c(ohne_Besch, mit_Besch),
                      beschichtung = factor(x = c(rep("nein", length(ohne_Besch)), rep("ja", length((mit_Besch))))))

boxplot(endorphine ~ beschichtung, data = brillen)

library(coin)
wilcox_test(formula = endorphine ~ beschichtung,
            data = brillen,
            alternative = "greater",
            distribution = "exact")


# Aufgabe 4: Tests und Konfidenzintervall

# a)
Zürich <- c(95, 300, 160, 250, 320)
Lausanne <- c(75, 200, 100, 230, 270)
data <- matrix(c(Zürich, Lausanne), nrow = 2, byrow = TRUE)
colnames(data) <- c("Mathe", "Ing", "Chemie", "Wirtschaft", "sonstige")
rownames(data) <- c("Zürich", "Lausanne")

studienf.test <- chisq.test(data)
studienf.test$p.value

# b)
erdbeben <- c(55, 72, 64, 73, 57)
poisson.test(sum(erdbeben), T = length(erdbeben), conf.level = 0.9)

# c)
12.73 + c(-1,1) * 2.06/sqrt(40) * qt(0.995, df=39)


# Aufgabe 5: Bootstrap

set.seed(20200123)
x <- rlnorm(20, meanlog = 1, sdlog = sqrt(log(2)))

## a)
schaetzer_t <- function(data){
  n <- length(data)
  x_hut <- mean(data)
  summe <- 0
  for (i in 1:n){
    summe <- summe + sum((data[i] - x_hut)^2)
  }
  res <- (sqrt((1/n) * summe)) / x_hut
  return(res)
}
schaetzer_t(x)


## b)

library(boot)
estimator <- function(data, indices) {
  return(schaetzer_t(data[indices]))
}
boot.res <- boot(data = x, statistic = estimator, R = 4999)
boot.ci(boot.res, type = "perc", conf = 0.90)
boot.res


