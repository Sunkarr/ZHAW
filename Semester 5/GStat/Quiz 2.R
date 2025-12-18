# Aufgabe 1

p_vals <- c(0.04113, 0.05153, 0.42784, 0.62657, 0.4057, 0.00432, 0.05685, 0.00234, 0.54151, 0.05567)
p_vals_adjust <- p.adjust(p_vals, method = "BH")
# bigger than 0.05
sum(p_vals_adjust < 0.05)


# Aufgabe 2

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/marktforschungtabelle.rda")
mf <- matrix(c(38, 33, 87, 41), nrow=2, byrow=T)
rownames(mf) <- c("ländlich", "städtisch")
colnames(mf) <- c("Margarine", "Butter")

mf_test <- chisq.test(mf, correct=F)
mf_test


# Aufgabe 7

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/pilze.rda")
behandelt <- c(28, 28.6, 26, 31.5, 25.3, 31.3, 26.6, 27.4, 25.8, 28.8, 28.4, 27, 25.9)
unbehandelt <- c(22.1, 19.1, 20.9, 18.5, 11.6, 19.8, 21.1, 19, 20.9, 17.4, 18.6, 17.8, 14.2, 20.2, 20.2, 14.5, 17.7)
length(behandelt)
length(unbehandelt)
mean(behandelt)
mean(unbehandelt)

t_test <- t.test(behandelt, unbehandelt, alternative="greater", paired = F)
t_test


# Aufgabe 8

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/kaffeepulver.rda")
mean(kaffeepulver$Abfuellanlage_A)
mean(kaffeepulver$Abfuellanlage_B)
sd(kaffeepulver$Abfuellanlage_A)
sd(kaffeepulver$Abfuellanlage_B)

kaffee_test <- t.test(kaffeepulver$Abfuellanlage_A, kaffeepulver$Abfuellanlage_B,
                      alternative="two.sided", var.equal = T, conf.level = 0.01)
kaffee_test


# Aufgabe 9

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/testscores.rda")
testscores

# check if normal distribution
# QQplot
par(mfrow=c(1,2))
qqnorm(testscores$Vorher, main="QQ-Plot Vorher")
qqline(testscores$Vorher)
qqnorm(testscores$Nachher, main="QQ-Plot Nachher")
qqline(testscores$Nachher)
par(mfrow=c(1,1))

# both p-values > 0.05 -> normal distribution
mean(testscores$Vorher)
mean(testscores$Nachher)
sd(testscores$Vorher)
sd(testscores$Nachher)

t_testscores_test <- t.test(testscores$Vorher, testscores$Nachher,
                          alternative="less", paired = T)
t_testscores_test

wil_test <- wilcox.test(testscores$Vorher, testscores$Nachher,
                        alternative="less", paired = T)
wil_test

# transform testscores to longformat
library(tidyr)
library(coin)

# Transformation ins Long-Format
testscores_long <- pivot_longer(testscores, 
                                cols = c(Vorher, Nachher), 
                                names_to = "Zeitpunkt", 
                                values_to = "Score")

# WICHTIG für coin: Gruppierungsvariablen müssen Faktoren sein
testscores_long$Zeitpunkt <- as.factor(testscores_long$Zeitpunkt)
testscores_long$Student <- as.factor(testscores_long$Student)
testscores_long

# Durchführung des Tests
wil_test_coin <- wilcox_test(Score ~ Zeitpunkt | Student, 
                             data = testscores_long, 
                             alternative = "greater",
                             distribution = "exact")

print(wil_test_coin)



