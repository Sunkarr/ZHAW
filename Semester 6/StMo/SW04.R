# Aufgabe 1

highway <- read_csv("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/highway.csv")

# a)
lmHighway <- lm(runoff ~ rain, data = highway)
lmHighway$coefficients
plot(highway$rain, highway$runoff, xlab = "Regen (mm)", ylab = "Abfluss (m3/s)", main = "Abfluss vs. Regen")
abline(lmHighway, col = "red", lwd = 2)
legend("topleft", legend = c(paste("alpha =", round(coef(lmHighway)[1], 2)), paste("beta =", round(coef(lmHighway)[2], 2))), col = "red", lty = 1, lwd = 2)                                                                                                                   

# b)
summary(lmHighway)

# c)
summary(lmHighway)

# d)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
par(mfrow = c(2,3))
plot(lmHighway, which = 1:3) # ohne Simulationen
plot.lmSim(lmHighway)

# f)
# log log transformation
highway$log_runoff <- log(highway$runoff)
highway$log_rain <- log(highway$rain)
lmHighway2 <- lm(log_runoff ~ log_rain, data = highway)
summary(lmHighway2)
# plot with log log transformation
par(mfrow = c(1,1))
plot(highway$log_rain, highway$log_runoff, xlab = "log(Regen (mm))", ylab = "log(Abfluss (m3/s))",
     main = "log(Abfluss) vs. log(Regen)")
abline(lmHighway2, col = "red", lwd = 2)
legend("topleft", legend = c(paste("alpha =", round(coef(lmHighway2)[1], 2)), paste("beta =", round(coef(lmHighway2)[2], 2))), col = "red", lty = 1, lwd = 2)                                                         

# d)
x0 <- data.frame(log_rain = log(50))
pred.y <- predict(lmHighway2, newdata = x0, interval = "prediction")
exp(pred.y)
exp(pred.y + (summary(lmHighway2)$sigma^2)/2)

# e)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
par(mfrow = c(2,3))
plot(lmHighway2, which = 1:3) # ohne Simulationen
plot.lmSim(lmHighway2)


# Aufgabe 2
mpizh <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/MPIZH.dat", header = T)

# a) b)
fit_mpizh <- lm(MPI ~ KPI + HZ, data = mpizh)
summary(fit_mpizh)

# c)
install.packages("car")
install.packages("scatterplot3d")
library(car)
library(scatterplot3d)
scatterplot3d(mpizh$KPI, mpizh$HZ, mpizh$MPI, xlab = "KPI", ylab = "HZ", zlab = "MPI", main = "3D Scatterplot")
