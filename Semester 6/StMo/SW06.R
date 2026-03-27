# Aufgabe 1

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/Cherry.rda")

# a)
plot(cherry)
par(mfrow = c(1,2))
boxplot(cherry$Height, ylab = "Höhe")
boxplot(cherry$Diameter, ylab = "Umfang")
par(mfrow = c(1,1))

# b) log log transformation
cherry$log_Height <- log(cherry$Height)
cherry$log_Diameter <- log(cherry$Diameter)
cherry$log_Volume <- log(cherry$Volume)
lmCherry <- lm(log_Volume ~ log_Diameter + log_Height, data = cherry)
summary(lmCherry)

lmCherry_ohneLog <- lm(Volume ~ Diameter + Height, data = cherry)
summary(lmCherry_ohneLog)

# c)
## Von Hand
1.1347 + c(-1,1) * 0.2051 * qt(0.975, 28)
## Mit confint
confint(lmCherry, level = 0.95)

# e)
confint(lmCherry, parm = c(2,3))

# f)
h <- predict(lmCherry, newdata = data.frame(log_Diameter = log(5.3), log_Height = log(27)),
             interval = "prediction", level = 0.95)
exp(h)


# Aufgabe 2

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/salary.rda")

# a)
plot(salary)
salary$education <- as.factor(salary$education)
par(mfrow = c(1,2))
boxplot(salary$income ~ salary$education)
boxplot(salary$experience ~ salary$education)
par(mfrow = c(1,1))

# b)
lmSalary <- lm(income ~ experience + education, data = salary)
summary(lmSalary)




        