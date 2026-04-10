# Aufgabe 1

diamonds <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/diamant.dat", header = TRUE)

# a)
lm1 <- lm(Price ~ Carat + I(Carat^2), data = diamonds)
diamonds$log_Carat <- log(diamonds$Carat)
diamonds$log_Price <- log(diamonds$Price)
lm2 <- lm(log_Price ~ log_Carat + I(log_Carat^2), data = diamonds)
summary(lm1)$r.squared
summary(lm2)$r.squared

# b)
predict(lm1, newdata = data.frame(Carat = c(0.22, 1.07)), interval = "prediction", level = 0.95)
diamonds$Price[diamonds$Carat == (0.22)]
diamonds$Price[diamonds$Carat == (1.07)]

# c)
x11 <- data.frame(log_Carat = log(0.22), lCaratH2 = log(0.22)^2)
pred.y11 <- predict(lm2, newdata = x11, interval = "prediction")
exp(pred.y11 + (summary(lm2)$sigma^2)/2) # Rücktransformation!
diamonds$Price[diamonds$Carat == (0.22)]

x12 <- data.frame(log_Carat = log(1.07), lCaratH2 = log(1.07)^ 2)
pred.y12 <- predict(lm2, newdata = x12, interval = "prediction")
exp(pred.y12 + (summary(lm2)$sigma^2)/2) # Rücktransformation!
diamonds$Price[diamonds$Carat == (1.07)]

# d)
par(mfrow=c(2,3))
plot(lm1, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(lm1, seed=1324)

par(mfrow=c(2,3))
plot(lm2, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(lm2, seed=1324)

par(mfrow=c(1,1))

# e)
summary(lm2)
summary(lm2)$sigma

# f)
summary(lm2)

# g)
par(mfrow=c(1,1))
plot(log_Price ~ log_Carat, data = diamonds, main = "Preis von Diamanten", pch = 3)
x <- seq(min(diamonds$log_Carat), max(diamonds$log_Carat), length=50)
dat <- data.frame(log_Carat=x, log_Carat_h2=x^2)
lines(x, predict(lm2, newdata = dat), col=2, lwd = 2)
FourCm.lmE <- lm(log_Price ~ log_Carat, data=diamonds)
abline(FourCm.lmE , col="orange", lwd = 2)

# i)
x <- data.frame(log_Carat = log(0.4), lCaratH2 = log(0.4)^2)
pred.y <- predict(lm2, newdata = x, interval = "prediction")
conf.y <- predict(lm2, newdata = x, interval = "confidence")
exp(pred.y + (summary(lm2)$sigma^2)/2)
exp(conf.y + (summary(lm2)$sigma^2)/2)


# Aufgabe 2

mpi <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/MPIZH.dat", header = TRUE)

# a)
fit.mpi <- lm(MPI ~ KPI + HZ, data = mpi)
summary(fit.mpi)

# b)
plot(mpi$MPI ~ mpi$HZ + mpi$KPI)
par(mfrow=c(1,2))
termplot(fit.mpi, partial.resid=TRUE, smooth = panel.smooth, col.term="blue", col.smth = "red", col.res="black")

par(mfrow=c(2,3))
plot(fit.mpi, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.mpi, seed=1324)
