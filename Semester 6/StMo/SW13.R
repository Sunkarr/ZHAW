# Aufgabe 1

sniffer <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/sniffer.dat", head = T)

library(car)

# a)
pairs(sniffer)

# b)
# transform °F to °C (sniffer$Temp.Tank and sniffer$Temp.Gas)
fun_far2cel <- function(x) (x - 32) * 5/9
sniffer$Temp.Tank <- fun_far2cel(sniffer$Temp.Tank)
sniffer$Temp.Gas  <- fun_far2cel(sniffer$Temp.Gas)
# transform psi to bar (sniffer$Pressure.Tank and sniffer$Pressure.Gas)
fun_ppm2bar <- function(x) (x * 0.0689476)
sniffer$Vapor.Dispensed <- fun_ppm2bar(sniffer$Vapor.Dispensed)
sniffer$Vapor.Tank <- fun_ppm2bar(sniffer$Vapor.Tank)

# c)
fit.sniffer <- lm(Hydrocarbons ~ ., data = sniffer)
summary(fit.sniffer)
vif(fit.sniffer)

# d)
backAIC.sniffer <- step(fit.sniffer, direction = "backward")
vif(backAIC.sniffer)

# e)
sniffer$MeanVapor <- 0.5*(sniffer$Vapor.Tank + sniffer$Vapor.Dispensed)
sniffer$DeltaVapor <- sniffer$Vapor.Tank - sniffer$Vapor.Dispensed

fit.sniffer2 <- lm(Hydrocarbons ~ Temp.Gas + Temp.Tank + MeanVapor + DeltaVapor, data = sniffer)
summary(fit.sniffer2)
vif(fit.sniffer2)

backAIC.sniffer2 <- step(fit.sniffer2, direction = "backward")
vif(backAIC.sniffer2)

# f)
par(mfrow=c(2,4))
plot(fit.sniffer2)
abline(v = 2*length(coef(fit.sniffer2))/nrow(sniffer), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.sniffer2)


# Aufgabe 2

asphalt <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/asphalt.dat", head = T)

# a)
fit.asphalt <- lm(RUT ~ ., data = asphalt)
summary(fit.asphalt)

# b)
par(mfrow=c(2,4))
plot(fit.asphalt)
abline(v = 2*length(coef(fit.asphalt))/nrow(asphalt), col = "blue", lty = 2)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.asphalt)

# c)
par(mfrow=c(1,2))
plot(asphalt$RUT)
plot(asphalt$VISC)
par(mfrow=c(1,1))

# d)
asphalt$logRUT <- log(asphalt$RUT)
asphalt$logVISC <- log(asphalt$VISC)

fit.asphalt2 <- lm(logRUT ~ logVISC + ASPH + VOIDS + RUN + FINES + BASE, data = asphalt)
summary(fit.asphalt2)

# e)
fit.full <- lm(logRUT ~ logVISC + ASPH + VOIDS + RUN + FINES + BASE, data = asphalt)
fit.empty <- lm(logRUT ~ 1, data = asphalt)

mb <- step(fit.full, direction = "backward", k = log(nrow(asphalt)))
mf <- step(fit.empty, direction = "forward", k = log(nrow(asphalt)), scope = list(upper = fit.full))
vif(mb) == vif(mf)
vif(mb)

