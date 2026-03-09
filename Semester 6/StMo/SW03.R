source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")


# Aufgabe 1

# a)
windmühlen <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/Windmuehle.dat", header = T)
plot(windmühlen)
lmWind <- lm(Strom ~ Windgeschwindigkeit, data = windmühlen)
abline(lmWind, col = "red", lwd = 2 )
# legend with parameter alpha and beta
legend("bottomright", legend = c(paste("alpha =", round(coef(lmWind)[1], 2)), paste("beta =", round(coef(lmWind)[2], 2))), bty = "n")

par(mfrow = c(2,3))
plot(lmWind, which = 1:3) # ohne Simulationen
source("plotlmSim.R") # mit Simulationen
plot.lmSim(lmWind)

# b)
par(mfrow = c(1,1))
windmühlen$trans_x <- 1/windmühlen$Windgeschwindigkeit
lmWind2 <- lm(Strom ~ trans_x, data = windmühlen)
plot(windmühlen$Windgeschwindigkeit, windmühlen$Strom)
xx <- seq(0,25,1)
lines(xx, coef(lmWind2)[1] + coef(lmWind2)[2]*1/xx, col = "red", lwd = 2)

# d)
par(mfrow = c(2,3))
plot(lmWind2, which = 1:3) # ohne Simulationen
source("plotlmSim.R") # mit Simulationen
plot.lmSim(lmWind2)

# e)
summary(lmWind2)

# f)
confint(lmWind2)

# g)
predict(lmWind2, newdata = data.frame(Windgeschwindigkeit = 15), interval = "confidence", level = 0.95)

      