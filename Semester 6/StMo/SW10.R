# Aufgabe 1

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/depression.rda")

# a)
depression.lm <- lm(y ~ age + TRT, data=depression)
# plot result
plot(depression$y ~ depression$age, main = "Depression vs. Age", pch = 3)
abline(depression.lm, col = "red", lwd = 2)
summary(depression.lm)
drop1(depression.lm, test = "F")

# b)
par(mfrow=c(2,3))
plot(depression.lm, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(depression.lm, seed=1324)

par(mfrow=c(1,1))
install.packages("sfsmisc")
library(sfsmisc)
p.res.2x(~age + TRT, data = depression.lm, scol = 2:1)

# c)
depression.lm2 <- lm(y ~ age + TRT + age:TRT, data=depression)
plot(depression$y ~ depression$age, main = "Depression vs. Age", pch = 3)
abline(depression.lm, col = "red", lwd = 2)
abline(depression.lm2, col = "blue", lwd = 2)
legend("bottom", legend = c("Model 1", "Model 2"), col = c("red", "blue"), lwd = 2)
summary(depression.lm2)
drop1(depression.lm2, test = "F")

# d)
par(mfrow=c(2,3))
plot(depression.lm2, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(depression.lm2, seed=1324)
par(mfrow=c(1,1))


# Aufgabe 2

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/income.rda")

# a)
# plot of log(income) vs. height and colored by sex
plot(income$height, log(income$earning),
     col = income$sex, main = "Einkommen vs. Körpergrösse",
     xlab = "Körpergrösse", ylab = "log. Einkommen",
     xlim = c(160,190), ylim = c(10,14))
legend("topleft", legend = c("Männlich", "Weiblich"), col = 1:2, pch = 1)

# b)
fit.income <- lm(log(earning) ~ height + sex + height:sex, data = income)
abline(a = coef(fit.income)[1], b = coef(fit.income)[2], col = "black")
abline(a = coef(fit.income)[1] + coef(fit.income)[3], b = coef(fit.income)[2] + coef(fit.income)[4], col = "red")

# c)
summary(fit.income)
summary(fit.income)$coefficients
drop1(fit.income, test = "F")


# Aufgabe 3

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/GASKETS.rda")

# a)
fit.gaskets <- lm(DEFECTS ~ SPEED, data = GASKETS)
plot(GASKETS$SPEED, GASKETS$DEFECTS, main = "Defekte vs. Geschwindigkeit", pch = 3)
abline(fit.gaskets, col = "red", lwd = 2)

# b)
par(mfrow=c(2,3))
plot(fit.gaskets, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.gaskets, seed=1324)
par(mfrow=c(1,1))

# c)
GASKETS$LogDefects <- log(GASKETS$DEFECTS)
GASKETS$LogSpeed <- log(GASKETS$SPEED)
fit.gaskets2 <- lm(LogDefects ~ LogSpeed, data = GASKETS)

par(mfrow=c(2,3))
plot(fit.gaskets2, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.gaskets2, seed=1324)
par(mfrow=c(1,1))

# d)
# weigthed regression
fit.gaskets3 <- lm(DEFECTS ~ SPEED, data = GASKETS, weights = 1/SPEED)

# e)
par(mfrow=c(2,3))
plot(fit.gaskets3, which=1:3)
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
plot.lmSim(fit.gaskets3, seed=1324)
par(mfrow=c(1,1))


