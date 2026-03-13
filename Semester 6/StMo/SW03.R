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
source("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/plotlmSim.R") # mit Simulationen
plot.lmSim(lmWind)

# b)
par(mfrow = c(1,1))
windmühlen$trans_x <- 1/windmühlen$Windgeschwindigkeit
lmWind2 <- lm(Strom ~ trans_x, data = windmühlen)
plot(windmühlen$Windgeschwindigkeit, windmühlen$Strom)
xx <- seq(0,25,1)
lines(xx, coef(lmWind2)[1] + coef(lmWind2)[2]*1/xx, col = "red", lwd = 2)
legend("bottomright", legend = c(paste("alpha =", round(coef(lmWind2)[1], 2)), paste("beta =", round(coef(lmWind2)[2], 2))), col = "red", lty = 1, lwd = 2)

# d)
par(mfrow = c(2,3))
plot(lmWind2, which = 1:3) # ohne Simulationen
plot.lmSim(lmWind2, nsim = 100)

# e)
summary(lmWind2)

# f)
confint(lmWind2)

# g)
predict_data <- data.frame(trans_x = 1/15)
predict(lmWind2, newdata = predict_data, interval = "prediction", level = 0.95)


# Aufgabe 2
library(tidyverse)


# a)
anscombe <- read.table("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/Anscombe.dat", header = T)

# Transformation des geladenen 'anscombe' Datensatzes
anscombe_nested <- anscombe %>%
  # 1. Spaltennamen aufteilen (X/Y landet in '.value', die Ziffer in 'Modell')
  pivot_longer(everything(), 
               names_to = c(".value", "Modell"), 
               names_pattern = "(.)(.)") %>%
  # 2. Gruppieren nach der Modell-Nummer
  group_by(Modell) %>%
  # 3. Die X- und Y-Spalten in Listen (Vektoren) zusammenfassen
  summarize(
    x_werte = list(X),
    y_werte = list(Y)
  )

# function to calc fit, sigma_hat and R^2 for each model
calc_model_stats <- function(x, y) {
  fit <- lm(y ~ x)
  alpha <- as.numeric(coef(fit)[1])
  beta <- as.numeric(coef(fit)[2])
  sigma_hat <- summary(fit)$sigma
  r_squared <- summary(fit)$r.squared
  return(list(alpha = alpha, beta = beta, sigma_hat = sigma_hat, r_squared = r_squared))
}

model_stats <- anscombe_nested %>%
  rowwise() %>%
  mutate(stats = list(calc_model_stats(x_werte, y_werte))) %>%
  unnest_wider(stats)

# b)
# Plotten der vier Modelle in einem 2x2 Layout inkl. der Regressionsgeraden und der Legende mit den berechneten Parametern
par(mfrow = c(2, 2))
for (i in 1:nrow(model_stats)) {
  x <- unlist(model_stats$x_werte[i])
  y <- unlist(model_stats$y_werte[i])
  plot(x, y, main = paste("Modell", model_stats$Modell[i]), xlab = "X", ylab = "Y")
  abline(model_stats$alpha[i], model_stats$beta[i], col = "red", lwd = 2)
  legend("bottomright", legend = c(paste("alpha =", round(model_stats$alpha[i], 2)), paste("beta =", round(model_stats$beta[i], 2))), col = "red", lty = 1, lwd = 2)
}


# d)
# Tukey-Ascombe-Plot for each model
par(mfrow = c(2, 2))
for (i in 1:nrow(model_stats)) {
  x <- unlist(model_stats$x_werte[i])
  y <- unlist(model_stats$y_werte[i])
  fit <- lm(y ~ x)
  plot(fit, which = 1, main = paste("Tukey-Ascombe-Plot Modell", model_stats$Modell[i]))
}
                                                       
                                                       
                                                       
                                                       
      