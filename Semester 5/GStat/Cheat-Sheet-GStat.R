# Cheat Sheet Gstat

## Libraries

library("boot")
library("car")
library("MASS")
library("moonboot")
library("Sleuth3")
Daten_Sleuth3 <- case0101

## Nützliches

### Vektoren zu Dataframe
sand_1 <- c(0.17, 0.63, 0.35, 0.49, 0.18, 0.43, 0.12, 0.20, 0.47, 1.36, 0.51, 0.45, 0.84, 0.32, 0.40)
sand_2 <- c(1.13, 0.54, 0.96, 0.26, 0.39, 0.88, 0.92, 0.53, 1.01, 0.48, 0.89, 1.07, 1.11, 0.58)
sand <- data.frame(
  menge = c(sand_1, sand_2),
  gruppe = factor(rep(c("1", "2"), times = c(length(sand_1), length(sand_2))))
)

frau <- c(68, 130, 84)
mann <- c(137, 72, 26)
data <- matrix(c(frau, mann), nrow = 2, byrow = TRUE)
colnames(data) <- c("kaum", "etwas", "stark")
rownames(data) <- c("Frau", "Mann")
data
prop.table(data, margin = 2)


## Punktschätzer
erwartungswert_geschätzt <- mean(data)
varianz_geschätzt <- var(data)
sd_geschätzt <- sd(data)

varianz_manuell <- function(daten, mittelwert) {
  n <- length(daten)
  quadrat_summe <- sum((daten - mittelwert)^2)
  ergebnis <- quadrat_summe / (n - 1)
  return(ergebnis)
}


## QQ-Plot
library("car")
x <- rnorm(n = 100, mean = 1, sd = 2)
par(mfrow = c(1,2))
hist(x, breaks = 10, main = "Histogramm von x", xlab = "x-Werte", ylab = "Häufigkeit")
qqPlot(x, distribution = "norm", mean = 0, sd = 1, main = "QQ-Plot von x")
par(mfrow = c(1,1))

### log Transformierte Daten
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/qqplot.RData")
qqPlot(lohn)
qqPlot(log(lohn))


## Daten unabhängig?
sample_data_unabhängig <- rnorm(500)
sample_data_abhängig <- numeric(n)
rho <- 0.8 # Stärke der Korrelation
for(i in 2:n) {
  sample_data_abhängig[i] <- rho * sample_data_abhängig[i-1] + rnorm(1, sd = 0.6)
}
par(mfrow = c(2,2))
plot(sample_data_unabhängig[1:50], type = "b", pch = 19, main = "Unabhängig", 
     xlab = "", ylab = "Stichprobe 1")
plot(sample_data_abhängig[1:50], type = "b", pch = 19, main = "Abhängig", 
     xlab = "", ylab = "Stichprobe 2")  
plot(sample_data_unabhängig[-1], sample_data_unabhängig[-length(sample_data_unabhängig)], xlab = "x_n", ylab = "x_(n-1)", 
     pch = 21)
plot(sample_data_abhängig[-1], sample_data_abhängig[-length(sample_data_abhängig)], xlab = "x_n", ylab = "x_(n-1)", 
     pch = 21)
par(mfrow = c(1,1))


## Schätzer

MSE_Estimator <- function(lambda_hat, lambda_true) {
  var(lambda_hat) + (mean(lambda_hat) - lambda_true)^2
}

MSE <- function(var, bias){
  return(var + bias^2)
}
MSE(1/5, 4)
MSE(1+exp(-3*10), 3)
MSE(1/10, 0)

## Maximum Likelihood

### Beispiel für Binomialverteilung
#### x = Anzahl Rote Würfe, n = Anzahl Würfe, p = Wahrscheinlichkeit Rot
p <- seq(0, 6)/6
x_erfolg <- 34
n <- 100
wahr <- dbinom(x = x_erfolg, size = n, prob = p, log = T)
plot(würfel, wahr, 
     type = "b", 
     pch = 19, 
     col = "blue",
     xlab = "Parameter p (Wahrscheinlichkeit Rot)", 
     ylab = "Log-Likelihood", 
     main = "Log-Likelihood Funktion (Binomial)")
# Markierung des Maximums (MLE)
mle_p <- x_erfolg / n
abline(v = mle_p, col = "red", lty = 2)


## Log-Likelihood

### Beispiel für Gammaverteilung
#### Parameter shape = 3, rate = 1/9 sollen geschätzt werden
set.seed(801)
x.gamma <- rgamma(n = 20, shape = 3, rate = 1/9)
x.gamma
##### LOG-Likelihood!!!!
negative_log_likelihood <- function(params, data) {
  shape <- params[1]
  rate <- params[2]
  -sum(dgamma(x = data, shape = shape, rate = rate, log = TRUE))
}
start <- c(mean(x.gamma)^2 / var(x.gamma), mean(x.gamma) / var(x.gamma))
start
optim(par = start, fn = negative_log_likelihood, method = "BFGS", data = x.gamma)

library(fitdistrplus)
x.gamma.mle <- fitdist(data = x.gamma, distr = "gamma", method = "mle")
x.gamma.mle$estimate

#### MLE Likelihood

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/stichprobe_dichte.rda")

negative_log_likelihood <- function(theta, data){
  log_lik <- sum(log(theta * data^(theta - 1)))
  return(-log_lik)
}

start <- mean(stichprobe_dichte)
optim(par = start, fn= negative_log_likelihood, method = "BFGS", data = stichprobe_dichte)

#### SW04 Aufgabe 2: Maximum-Likelihood-Schätzung bei Normalverteilung

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


## Konfidenzintervall

### Varianz bekannt
data <- rnorm(n = 100, mean = 50, sd = 10)
#### Manuell 1
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qnorm(1 - alpha/2)*sd_data/sqrt(n)
#### Manuell 2
x_hat <- 38.5
sd_hat <- 1.6
n <- 46
alpha <- 0.05
x_hat + c(-1, 1) * qnorm(1-alpha/2) * sd_hat / sqrt(n)
#### via z.test
library(BSDA)
z.test(x = data, mu = mean_data, sigma.x = sd_data, conf.level = 1-alpha)$conf.int

### Varianz unbekannt (mit Student-t-Verteilung)
data <- rnorm(n = 100, mean = 50, sd = 10)

#### Manuell
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qt(1 - alpha/2, df = n-1)*sd_data/sqrt(n)

#### via t.test
library(BSDA)
t.test(x = data, conf.level = 1-alpha)$conf.int

### Asymptitisches Konfidenzintervall
data <- rnorm(n = 100, mean = 50, sd = 10)
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qnorm(1 - alpha/2)*sd_data/sqrt(n)

### Clopper-Pearson Intervall für Binomialverteilung
#### Weil binomiale Verteilungen sehr schlecht approximiert werden mit Asymptotischen KI's
#### verwendet man in diesem Fall besser Clopper-Pearson Intervalle
data <- rbinom(n = 1, size = 100, prob = 0.3) # 100 Versuche, 30 Erfolge
library(BSDA)  
binom.test(x = data, n = 100, conf.level = 0.95)$conf.int
#### Auch für Poissonverteilung
data <- rpois(n = 1, lambda = 5) # 5 Ereignisse
poisson.test(x = data, conf.level = 0.95)$conf.int # KI für Ereignis pro Zeit
  
### Bootstrap Konfidenzintervall
#### Manuell
xn <- rnorm(5)
B <- 500
Ti <- matrix(NA, nrow = B)
for (i in 1:B) {
  boot_sample <- sample(xn, size = length(xn), replace = TRUE)
  Ti[i] <- mean(boot_sample)
}
alpha <- 0.05
quantile(Ti, probs = c(alpha/2, 1 - alpha/2))

#### via boot Paket
library(boot)
xn <- rnorm(5)
estimator <- function(data, indices) {
  return(mean(data[indices]))
}
boot.res <- boot(data = xn, statistic = estimator, R = 500)
boot.res
boot.ci(boot.res, type = "perc", conf = 0.95)


## Statistischen Testen

### Bonferroni Korrektur

p_vals <- c(0.00602, 0.04016, 0.0047, 0.03418, 0.04975, 0.03096, 0.0432, 0.00162, 0.04998, 0.4313)
p_vals_corr <- p.adjust(p_vals, method = "bonferroni")
length(p_vals_corr[p_vals_corr < 0.05])

### Binomialtest

binom.test(x = 47, n = 120, conf.level = 0.95, alternative = "greater", p = 0.3)

### Poissontest

## Annahmebereich
qpois(0.95, lambda = 8.4)
1 - sum(dpois(x = 0:13, lambda = 8.4))
### Der Annahmebereich ist [0, 13]
### Der Verwerfungsbereich ist [14, ∞)
## p-Wert
1 - ppois(10, lambda = 8.4)
poisson.test(x = 11, r = 8.4, alternative = "greater")$p.value

poisson.test(x = 9 + 8 + 12, T = 9, r = 3, alternative = "greater")

### Z-Test
library(BSDA)
unterlegescheiben <- load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/unterlegscheiben.rda")
z.test(x = x, sigma.x = 0.003, mu = 0.3)

### T-Test


### Ungepaarter Test
# SW10 Aufgabe 2: Blutdruck
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/blutdruck.Rdata")
t.test(blutdruck$x, blutdruck$y, alternative = "greater", paired = F)


### Gepaarter Test
# SW10 Aufgabe 3: Hals- und Schulterprobleme
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/hals.Rdata")
hals$diff <- hals$Before - hals$After
t.test(hals$diff, alternative = "two.sided", mu = 0)
t.test(x = hals$Before, y = hals$After, alternative = "two.sided", paired = TRUE)


### Mulitiples Testen
data("chickwts")
boxplot(weight ~ feed, data = chickwts, main = "Kükengewicht nach Futterart", xlab = "Futterart", ylab = "Gewicht (g)")
#### ohne Korrektur
pairwise.t.test(chickwts$weight, chickwts$feed, p.adjust.method = "none", pool.sd = F)
#### mit Bonferroni Korrektur
pairwise.t.test(chickwts$weight, chickwts$feed, p.adjust.method = "bonferroni", pool.sd = F)


### Permutationstest (Monte-Carlo Test)

#### Manuell
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

#### mit Combinat Paket
fun <- function(x, g) {
  abs(mean(x[g == "behandelte"]) - mean(x[g == "kontrolle"]))
}
p <- combinat::permn(dat$Gruppe) # alle Permutation
p <- p[!duplicated(p)] # lösche Duplikate
permDistExactH0 <- unlist( lapply(p, function(x,dat){fun(x=dat$HaeKonz, g = x)}, dat = dat))
hist(permDistExactH0)
abline(v = stat, col = "red")
sum(permDistExactH0 > stat) / length(permDistExactH0)

#### Automatisiert mit coin Paket
library(coin)
independence_test(formula = HaeKonz ~ Gruppe,
                  data = dat,
                  alternative = "two.sided",
                  distribution = "exact")

### Wilcoxon Test
#### Ungepaarter Test
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

#### Gepaarter Test
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

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/testscores2.rda")
testscores
wilcoxsign_test(formula = vorher ~ nachher,
                data = testscores,
                distribution = "exact",
                alternative = "less")


### Chi-Quadrat Test
#### Manuell

frau <- c(68, 130, 84)
mann <- c(137, 72, 26)
data <- matrix(c(frau, mann), nrow = 2, byrow = TRUE)
colnames(data) <- c("kaum", "etwas", "stark")
rownames(data) <- c("Frau", "Mann")

(erwartet <- outer(rowSums(data), colSums(data)) / sum(data))

Tstat <- sum((data - erwartet)^2 / erwartet)
freiheitsgrade <- (nrow(data) - 1) * (ncol(data) - 1)
qchisq(0.95, df = freiheitsgrade)
##### p-Wert
1 - pchisq(Tstat, df = freiheitsgrade)

#### via chisq.test
chisq.test(data)

# Ohne default Korrektur (weniger Konservativ)
chisq.test(data, correct = F)


## Güte/Macht von Tests
power.t.test(n = NULL, delta = 1, sd = 1, sig.level = 0.05, power = 0.99, alternative = "one.sided", type = "one.sample")



#-------------------------------------------------------------------------------


# package moonboot, library(moonboot)

library(moonboot)

## MLE Schätzer & Verteilungen


# 1. Daten generieren (Beispiel: Power-Verteilung)
set.seed(123)
data <- rpow(100, alpha = 2) # Nutzt die Power-Distribution aus moonboot

# 2. MLE Schätzer definieren (Beispiel für Alpha bei Power Law)
mle_power <- function(x) {
  n <- length(x)
  alpha_hat <- n / sum(log(x)) + 1
  return(alpha_hat)
}

# 3. Punkt-Schätzung
point_est <- mle_power(data)
print(paste("MLE Schätzer:", point_est))


## Konfidenzintervalle (m-aus-n Bootstrap)

# Beispiel: Schätzer für das Maximum einer Gleichverteilung [0, theta]
max_est <- function(x) { max(x) }

# moonboot anwenden
# x: Daten, theta: die Funktion, m: Subsample-Größe (m < n)
mb <- mboot(data, max_est, m = 20) 

# Konfidenzintervall berechnen
# Das Paket nutzt oft die adaptive Wahl von m
ci <- mboot.ci(mb, conf.level = 0.95)
print(ci)


## Monte Carlo & Simulationen

# Schätzung der optimalen Parameter m und tau (Konvergenzrate)
# Dies ist oft Teil von Monte-Carlo-Prüfungsaufgaben
est_params <- estimate.m(data, max_est)

# Visualisierung der Stabilität (Monte-Carlo-Check)
plot(est_params)



################################################################################
#------------------------------------------------------------------------------#
#------------------------------Gelöste Aufgaben--------------------------------#
#------------------------------------------------------------------------------#
################################################################################



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


#-------------------------------------------------------------------------------

# Quiz 1


## Aufgabe 3

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/simDat2.rda")
const <- 1.34898
(sigma_hat <- IQR(simDat) / const)

## Bootstrap
library(boot)
estimator <- function(data, indices) {
  return(IQR(data[indices]) / const)
}
boot.res <- boot(data = simDat, statistic = estimator, R = 10000)
boot.ci(boot.res, type = "perc", conf = 0.77)


## Aufgabe 5

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/schraubenlaengen.rda")
hist(schraubenlaengen)
t.test(schraubenlaengen, conf.level = 0.6)$conf

erwartungswert_geschätzt <- mean(schraubenlaengen)
varianz_geschätzt <- var(schraubenlaengen)
sd_geschätzt <- sd(schraubenlaengen)


## Aufgabe 6


x_hat <- 38.5
sd_hat <- 1.6
n <- 46
alpha <- 0.25

x_hat + c(-1, 1) * qnorm(1-alpha/2) * sd_hat / sqrt(n)


# Aufgabe 9


load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/stichprobe_dichte.rda")

negative_log_likelihood <- function(theta, data){
  log_lik <- sum(log(theta * data^(theta - 1)))
  return(-log_lik)
}

start <- mean(stichprobe_dichte)
optim(par = start, fn= negative_log_likelihood, method = "BFGS", data = stichprobe_dichte)


# Aufgabe 10

n <- 100000
meanlog <- 3
sdlog <- 0.5

s1_data <- numeric(length = n)
s2_data <- numeric(length = n)

for(i in 1:n) {
  stichprobe <- rlnorm(5, meanlog = meanlog, sdlog = sdlog)
  s1_data[i] <- mean(log(stichprobe))
  s2_data[i] <- log(mean(stichprobe))
}

mean(s1_data)
mean(s2_data)

var(s1_data)
var(s2_data)  


#-------------------------------------------------------------------------------

# Quiz 2


## Aufgabe 1

p_vals <- c(0.00602, 0.04016, 0.0047, 0.03418, 0.04975, 0.03096, 0.0432, 0.00162, 0.04998, 0.4313)
p_vals_corr <- p.adjust(p_vals, method = "bonferroni")
length(p_vals_corr[p_vals_corr < 0.05])


## Aufgabe 2

n <- 199
ländlich <- c(38, 33)
städtisch <- c(87, 41)
data <- matrix(c(ländlich, städtisch), nrow = 2, byrow = TRUE)
colnames(data) <- c("Margarine", "Butter")
rownames(data) <- c("ländlich", "städtisch")
data
prop.table(data, margin = 2)

marktforschung_erwartet <- outer(rowSums(data), colSums(data) / n)
sum((data - marktforschung_erwartet)^2 / marktforschung_erwartet)
df <- (2-1) * (2-1)
qchisq(0.95, df = df)

# Ohne default Korrektur (weniger Konservativ)
chisq.test(data, correct = F)


# Aufgabe 7

behandelt <- c(25.4, 28.1, 26.2, 24.3, 21.6, 20.6, 21.5, 25, 22.6, 26.5, 24.8, 27.9, 23.6, 22.9, 23.9)
unbehandelt <- c(23.9, 27.1, 26.3, 21.7, 24.3, 29.5, 23.8)
pilze <- data.frame(
  menge = c(behandelt, unbehandelt),
  gruppe = factor(rep(c("behandelt", "unbehandelt"), times = c(length(behandelt), length(unbehandelt))))
)
t.test(formula = menge ~ gruppe,
       data = pilze,
       alternative = "greater")


# Aufgabe 8

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/kaffeepulver2.rda")
t.test(x = kaffeepulver$Abfuellanlage_A, y = kaffeepulver$Abfuellanlage_B,
       paired = F,
       conf.level = 0.99)


# Aufgabe 9

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/testscores2.rda")
testscores
wilcoxsign_test(formula = vorher ~ nachher,
                data = testscores,
                distribution = "exact",
                alternative = "less")







