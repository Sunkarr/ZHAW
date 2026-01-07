# Cheat Sheet Gstat

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
prop.table(data, margin = 2)



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

### SW04 Aufgabe 2: Maximum-Likelihood-Schätzung bei Normalverteilung

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
#### Manuell
n <- length(data)
mean_data <- mean(data)
sd_data <- sd(data)
alpha <- 0.05
mean_data + c(-1, 1)*qnorm(1 - alpha/2)*sd_data/sqrt(n)
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
boot.ci(boot.res, type = "perc", conf = 0.95)


## Statistischen Testen

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


## Güte/Macht von Tests
power.t.test(n = NULL, delta = 1, sd = 1, sig.level = 0.05, power = 0.99, alternative = "one.sided", type = "one.sample")


