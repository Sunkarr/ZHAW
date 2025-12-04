# Aufgabe 1

factorial(9) / (factorial(5) * factorial(4))
choose(9,4)

HaeKonz <- c(9.1, 10.3, 11.0, 11.5, 11.9, 8.1, 8.4, 9.2, 9.4)
Gruppe <- c(rep(0, 5), rep(1, 4))
Hämo <- data.frame(HaeKonz, Gruppe)
Hämo$Gruppe <- factor(Hämo$Gruppe)

teststat <- function(data) {
  mean_b <- mean(data$HaeKonz[data$Gruppe == 0])
  mean_k <- mean(data$HaeKonz[data$Gruppe == 1])
  return (abs(mean_b - mean_k))
}

set.seed(0815)

initial_teststat <- teststat(Hämo)

mc_perm <- rep(NA, 100000)

for (i in 1:100000) {
  permuted_group <- sample(Hämo$Gruppe)
  permuted_data <- data.frame(HaeKonz = Hämo$HaeKonz, Gruppe = permuted_group)
  mc_perm[i] <- teststat(permuted_data)
}

hist(mc_perm)
abline(v = initial_teststat, col = "red", lwd = 2)

p_value <- sum(mc_perm >= initial_teststat) / 100000
p_value

library(coin)
independence_test(
  formula = HaeKonz ~ Gruppe,
  data = Hämo,
  distribution = "exact",
  alternative = c("two.sided"))
  



dat <- data.frame(
  HaeKonz = c(9.1, 10.3, 11, 11.5, 11.9, 8.1, 8.4, 9.2, 9.4),
  Gruppe = c(
    rep(x = "behandelte", times = 5),
    rep(x = "kontrolle", times = 4)))

fun <- function(x, g) {
  abs(mean(x[g == "behandelte"]) - mean(x[g == "kontrolle"]))
}

stat <- mean( x = dat$HaeKonz[dat$Gruppe == "behandelte"]) - mean(dat$HaeKonz[dat$Gruppe == "kontrolle"])

p <- combinat::permn(dat$Gruppe) # alle Permutation
p <- p[!duplicated(p)] # lösche Duplikate
permDistExactH0 <- unlist( lapply(p, function(x,dat){fun(x=dat$HaeKonz, g = x)}, dat = dat))
hist(permDistExactH0)
abline(v = stat, col = "red", lwd = 2)

sum(permDistExactH0 > stat) / length(permDistExactH0)





# Aufgabe 2

sand1 <- c(0.17, 0.63, 0.35, 0.49, 0.18, 0.43, 0.12, 0.20, 0.47, 1.36, 0.51, 0.45, 0.84, 0.32, 0.40)
sand2 <- c(1.13, 0.54, 0.96, 0.26, 0.39, 0.88, 0.92, 0.53, 1.01, 0.48, 0.89, 1.07, 1.11, 0.58)

wilcox.test(sand1, sand2, alternative = "two.sided", conf.level = 0.99)

sand <- data.frame(
  konz = c(sand1, sand2),
  gruppe = factor(c(rep("sand1", length(sand1)), rep("sand2", length(sand2))))
)
library(coin)
wilcox_test(konz ~ gruppe, data = sand, distribution = "exact", alternative = "two.sided")



# Aufgabe 3

library(readr)
reifen <- read_csv("Documents/GitHub/ZHAW/Semester 5/GStat/Daten/reifen.csv")
boxplot(reifen$`Profil A sA in m`, reifen$`Profil B sB in m`, names = c("Profil A", "Profil B"))

library(car)
qqPlot(x = reifen$`Profil A sA in m` - reifen$`Profil B sB in m`)

wilcoxsign_test(reifen$`Profil A sA in m` ~ reifen$`Profil B sB in m`, distribution = "exact", conf.level = 0.95)





