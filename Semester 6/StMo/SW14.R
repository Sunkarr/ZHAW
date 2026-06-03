# install.packages("gam")
library(gam)
library(car)
library(leaps)
# install.packages("psych")
library("psych")


# Aufgabe 1

castle <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/CastleEDHEC.dat", header = TRUE)

# b)
fit.castle <- lm(FoHF ~ ., data = castle)
summary(fit.castle)
vif(fit.castle)

par(mfrow=c(2,4))
plot(fit.castle)
abline(v = 2 * length(coef(fit.castle))/nrow(castle), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.castle)
par(mfrow=c(1,1))

# c)
mfm.lm1 <- lm(FoHF ~ . , data = castle)
mfm.lm0 <- lm(FoHF~ 1, data = castle)
mfm.lm2.AIC <- step(mfm.lm1, scope = list(lower = mfm.lm0, upper = mfm.lm1))

drop1(mfm.lm2.AIC, test = "F")
vif(mfm.lm2.AIC)

# d)
Castle.Cp <- regsubsets(FoHF ~ ., nbest=3, nvmax=12, data=castle)
cp_values <- summary(Castle.Cp)$cp # Cp-values der Sub-Modelle
summary(Castle.Cp)$which[which.min(cp_values),] # Modell mit kleinstem Cp
h <- subsets(Castle.Cp, statistic="cp", legend=FALSE,
             min.size = 5, max.size = 10, main="Mallow Cp",
             cex.subsets=0.5, las=1)

mfm.lm2.Cp <- lm(FoHF~ RV + CA + FIA + ED + GM + CTA, data = castle)
drop1(mfm.lm2.Cp, test = "F")
vif(mfm.lm2.Cp)
summary(mfm.lm2.Cp)


# Aufgab 2

# Daten laden
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/spital.rda")
spital <- spital[,-1]
any(is.na(spital))

# Kategorielle Variabeln in Faktoren umwandeln
spital$school <- factor(spital$school, labels=c("ja", "nein"))
table(spital$school)
spital$region <- as.factor(spital$region)
table(spital$region)

spital$serv <- spital$serv / 100 * 35

# Korrelationsanalyse und Verteilung der Daten
pairs.panels(spital[,!colnames(spital) %in% c("id","school","region")],
             method = "pearson", density = TRUE, ellipses = FALSE)

# Transformation
## length, cult, beds, pat, nurs: log-Transformation

# Modell erstellen
spital.lm1 <- lm(log(length)~ age + inf + log(cult) + xray + log(beds) +
                   school + region + log(pat) + log(nurs) + serv,
                 data = spital)
summary(spital.lm1)

# Residuenanalyse
par(mfrow=c(2,4))
plot(spital.lm1)
abline(v = 2 * length(coef(spital.lm1))/nrow(spital), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(spital.lm1)
par(mfrow=c(1,1))

# Prüfen der Multikollinearität
vif(spital.lm1)

# Modellauswahl / Amputation / Generieren neuer Variablen
spital$bed2 <- spital$beds / spital$pat
spital$nurs2 <- spital$nurs / spital$pat
spital$serv2 <- spital$serv / spital$pat

spital.lm2 <- lm(log(length)~ age + inf + log(cult) + xray + log(bed2) +
                   school + region + log(pat) + log(nurs2) + serv2,
                 data = spital)
par(mfrow=c(2,4))
plot(spital.lm2)
abline(v = 2 * length(coef(spital.lm2))/nrow(spital), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(spital.lm2)
par(mfrow=c(1,1))
vif(spital.lm2)

spital.full <- lm(log(length)~ age + inf + log(cult) + xray + log(bed2) +
                    school + region + log(pat) + log(nurs2) + serv2,
                  data = spital)
spital.empty <- lm(log(length)~ 1, data = spital)
lm3.AIC <- step(spital.full, trace = FALSE,
                scope = list(lower = spital.empty, upper = spital.full))
lm3.AIC$anova
par(mfrow=c(2,4))
plot(lm3.AIC)
abline(v = 2 * length(coef(lm3.AIC))/nrow(spital), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(lm3.AIC)
par(mfrow=c(1,1))
vif(lm3.AIC)
summary(lm3.AIC)$adj.r.squared
coef(lm3.AIC)
drop1(lm3.AIC, test = "F")


# Aufgabe 3

diamant <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/diamant.dat", header = TRUE)
diamant$Colour <- as.factor(diamant$Colour)
diamant$Clarity <- as.factor(diamant$Clarity)
diamant$CBody <- as.factor(diamant$CBody)

# a)
diamant$lPrice <- log(diamant$Price)
dia.gam1 <- gam(lPrice ~ lo(Carat), data = diamant)
summary(dia.gam1)
plot(dia.gam1, resid=TRUE, se=TRUE)

# b)
diamant$lCarat <- log(diamant$Carat)
dia.gam2 <- gam(lPrice ~ lo(lCarat), data = diamant)
summary(dia.gam2)
plot(dia.gam2, resid=TRUE, se=TRUE)

# c)
par(mfrow=c(1,3))
dia.gam3 <- gam(lPrice~ lo(lCarat, span=0.9), data=diamant)
plot(dia.gam3, resid=TRUE, se=TRUE) ## zu glatt
dia.gam3b <- gam(lPrice~ lo(lCarat, span=0.1), data=diamant)
plot(dia.gam3b, resid=TRUE, se=TRUE) ## sehr zerknittert
dia.gam3c <- gam(lPrice~ lo(lCarat, span=0.3), data=diamant)
plot(dia.gam3c, resid=TRUE, se=TRUE) ## ok

# d)
dia.gam4 <- gam(lPrice~ lo(lCarat, span = 0.3) + Colour + Clarity + CBody,
                data=diamant)
summary(dia.gam4)
par(mfrow = c(1,4))
plot(dia.gam4, se = TRUE)

# e)
par(mfrow=c(2,2))
stats:::plot.lm(dia.gam4)

# f)
x0 <- data.frame(lCarat = log(c(0.4,0.4)),
                 Colour = c("D","E"),
                 Clarity = c("IF","IF"),
                 CBody = c("GIA","GIA"))
h <- predict(dia.gam4, newdata = x0, interval = "prediction")
exp(h)
