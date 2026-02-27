# Aufgabe 1

uhren <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/AntikeUhren.dat", header = TRUE)

fit <- lm(Preis ~ Alter, data = uhren)
fit$coefficients
plot(uhren$Alter, uhren$Preis, xlab = "Alter (Jahre)", ylab = "Preis (CHF)", main = "Preis von antiken Uhren")
abline(fit, col = "red", lwd = 2)
legend("bottomright", legend = c(paste("alpha =", round(coef(fit)[1], 2)), paste("beta =", round(coef(fit)[2], 2))), col = "red", lty = 1, lwd = 2)

summary(fit)

confint(fit, level = 0.99)

confint(fit, level = 0.95)

x0 <- c(160)
predict(fit, newdata = data.frame(Alter = x0), interval = "confidence", level = 0.95)
predict(fit, newdata = data.frame(Alter = x0), interval = "prediction", level = 0.95)


# Aufgabe 2

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/conconi.rda")
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/conconi2.rda")

fit <- lm(puls ~ speed, data = conconi)
plot(conconi$speed, conconi$puls, xlab = "Geschwindigkeit (km/h)", ylab = "Puls (bpm)", main = "Conconi Test")
abline(fit, col = "red", lwd = 2)
legend("bottomright", legend = c(paste("alpha =", round(coef(fit)[1], 2)), paste("beta =", round(coef(fit)[2], 2))), col = "red", lty = 1, lwd = 2)


summary(fit)

predict(fit, newdata = data.frame(speed = 10), interval = "prediction", level = 0.95)

predict(fit, newdata = data.frame(speed = 0), interval = "confidence", level = 0.95)

confint(fit, level = 0.95)


par(mfrow = c(1, 2))
fit <- lm(puls ~ speed, data = conconi)
plot(conconi$speed, conconi$puls, xlab = "Geschwindigkeit (km/h)", ylab = "Puls (bpm)", main = "Conconi Test")
abline(fit, col = "red", lwd = 2)
legend("bottomright", legend = c(paste("alpha =", round(coef(fit)[1], 2)), paste("beta =", round(coef(fit)[2], 2))), col = "red", lty = 1, lwd = 2)

fit2 <- lm(puls ~ speed, data = conconi2)
plot <- plot(conconi2$speed, conconi2$puls, xlab = "Geschwindigkeit (km/h)", ylab = "Puls (bpm)", main = "Conconi Test 2")
abline(fit2, col = "red", lwd = 2)
legend("bottomright", legend = c(paste("alpha =", round(coef(fit2)[1], 2)), paste("beta =", round(coef(fit2)[2], 2))), col = "red", lty = 1, lwd = 2)


confint(fit, level = 0.95)
confint(fit2, level = 0.95)
