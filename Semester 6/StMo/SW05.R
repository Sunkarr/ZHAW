# Aufgabe 1

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 6/StMo/data/Advertisement.rda")

# a)
fit_adv <- lm(sales ~ ., data = adv)
coef(fit_adv)

# b)
summary(fit_adv)

# c)
confint(fit_adv, level = 0.99)

# d)
x0 <- data.frame(TV = 150, radio = 40, newspaper = 100)
predict(fit_adv, newdata = x0, interval = "prediction", level = 0.95)

# f)
# remove column newspaper from df
adv2 <- adv[, -3]
fit_adv2 <- lm(sales ~ ., data = adv2)
summary(fit_adv2)

# create 3D plot with TV and radio as x and y axis and sales as z axis
library(plotly)
plot_ly(adv, x = ~TV, y = ~radio, z = ~sales, type = "scatter3d", mode = "markers") %>%
  layout(scene = list(xaxis = list(title = "TV"), yaxis = list(title = "Radio"), zaxis = list(title = "Sales")))
# include the regression plane in the 3D plot
# create a grid of TV and radio values
tv_seq <- seq(min(adv$TV), max(adv$TV), length.out =20)
radio_seq <- seq(min(adv$radio), max(adv$radio), length.out =20)
grid <- expand.grid(TV = tv_seq, radio = radio_seq)
# predict sales for the grid
grid$sales <- predict(fit_adv2, newdata = grid)
# add the regression plane to the 3D plot
plot_ly(adv, x = ~TV, y = ~radio, z = ~sales, type = "scatter3d", mode = "markers") %>%
  add_surface(x = tv_seq, y = radio_seq, z = matrix(grid$sales, nrow = length(tv_seq), ncol = length(radio_seq)), opacity = 0.5) %>%
  layout(scene = list(xaxis = list(title = "TV"), yaxis = list(title = "Radio"), zaxis = list(title = "Sales")))


# Aufgabe 2


cat <- read.csv("~/Documents/GitHub/ZHAW/Semester 6/StMo/data/catheter.dat")

# a)
boxplot(cat$Groesse, cat$Gewicht, names = c("Grösse (cm)", "Gewicht (kg)"), main = "Boxplot von Grösse und Gewicht")

par(mfrow = c(1,2))
plot(y ~ Groesse, data = cat)
plot(y ~ Gewicht, data = cat)
par(mfrow = c(1,1))

# b)
fit_groesse <- lm(y ~ Groesse, data = cat)
fit_gewicht <- lm(y ~ Gewicht, data = cat)
coefficients(fit_groesse)
coefficients(fit_gewicht)
summary(fit_groesse)$sigma
summary(fit_gewicht)$sigma

# c)
summary(fit_groesse)
summary(fit_gewicht)

# d)
fit_cat <- lm(y ~ Groesse + Gewicht, data = cat)
summary(fit_cat)

