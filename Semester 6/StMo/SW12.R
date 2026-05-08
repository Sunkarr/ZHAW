# Aufgabe 1

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/savings.rda")

# a)
fit.savings <- lm(sr ~  pop15 + pop75 + dpi + ddpi, data = savings)
summary(fit.savings)

source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
par(mfrow=c(2,4))
plot(fit.savings)
p <- length(coef(fit.savings))
n <- nrow(savings)
abline(v = 2*(p/n), col = "blue", lty = 2)
plot.lmSim(fit.savings, seed=413)

# b)
s <- which(hatvalues(fit.savings) > 2*(p/n))
max_leverage_name <- names(which.max(hatvalues(fit.savings)[s]))

# c)
# remove datapoint "Libya"
savings.new <- savings[!(rownames(savings) %in% max_leverage_name), ]
fit.savings2 <- lm(sr ~  pop15 + pop75 + dpi + ddpi, data = savings.new)

source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
par(mfrow=c(2,4))
plot(fit.savings2)
p <- length(coef(fit.savings2))
n <- nrow(savings)
abline(v = 2*(p/n), col = "blue", lty = 2)
plot.lmSim(fit.savings2, seed=413)


# Aufgabe 2

stack2 <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/stack2.dat", header = TRUE)

# a)
fit.stack <- lm(loss ~ air.flow + water.temp + acid.conc, data = stack2)

source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R")
par(mfrow=c(2,4))
plot(fit.stack)
p <- length(coef(fit.stack))
n <- nrow(stack2)
abline(v = 2*(p/n), col = "blue", lty = 2)
plot.lmSim(fit.stack, seed=413)

# b)
# install.packages("robustbase")
library(robustbase)
fit.stack.rob <- lmrob(loss ~ air.flow + water.temp + acid.conc, data=stack2)

par(mfrow=c(2,3))
plot(fit.stack.rob)
plot(resid(fit.stack.rob), type="h")

# c)
summary(fit.stack)$r.squared
summary(fit.stack.rob)$r.squared

# d)
predict(fit.stack, newdata = data.frame(air.flow = 60,
                                        water.temp = 72,
                                        acid.conc = 0.87),
        interval = "prediction", level = 0.99)
predict(fit.stack.rob, newdata = data.frame(air.flow = 60,
                                        water.temp = 72,
                                        acid.conc = 0.87),
        interval = "prediction", level = 0.99)


