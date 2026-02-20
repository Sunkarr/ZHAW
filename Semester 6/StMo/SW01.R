# Aufgabe 1

## b)
y_hat <- function(alpha, beta, x){
  alpha + beta * x
}

alpha <- -1197682.1
beta <- 138.8

y_hat(alpha, beta, 20100)
y_hat(alpha, beta, 24000)

## c)
load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/flughafen.rda")

fit <- lm(Pax ~ ATM, data = zrh)
coef(fit)

## d)
y_hat(alpha, beta, 0)


## Aufgabe 2

uhren <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/AntikeUhren.dat", header = TRUE)

# a)
plot(uhren$Alter, uhren$Preis, xlab = "Alter (Jahre)", ylab = "Preis (CHF)", main = "Preis von antiken Uhren")

# b)
fit_uhren <- lm(Preis ~ Alter, data = uhren)
coef(fit_uhren)
abline(fit_uhren, col = "red")
# legend on botten with coefficients alpha and beta
legend("bottomright", legend = c(paste("alpha =", round(coef(fit_uhren)[1], 2)), paste("beta =", round(coef(fit_uhren)[2], 2))), col = "red", lty = 1)
                                             