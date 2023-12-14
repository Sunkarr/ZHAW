# Aufgabe 1

library(readxl)
datDS23t <- read_excel("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/datDS23t.xlsx")
View(datDS23t)

plot(datDS23t$handspanne ~ datDS23t$koerpergroesse,
     main = "Körpergrösse / Handspanne",
     xlab = "Körpergrösse in cm",
     ylab = "Handspanne in cm",
     asp = 1)

geschlechtfarbe <- ifelse(datDS23t$geschlecht == "männlich", "red", "seagreen")

scatter.smooth(datDS23t$koerpergroesse, datDS23t$handspanne,
     main = "Körpergrösse / Handspanne",
     xlab = "Körpergrösse in cm",
     ylab = "Handspanne in cm",
     col = geschlechtfarbe,
     lpars = list(col = "blue", lwd = 2),
     asp = 1,
     pch = as.integer(factor(datDS23t$haarfarbe))
     )

legend("bottomleft", legend = c("männlich", "weiblich"), col = c("red", "seagreen"), lty = 1, lwd = 2)
legend("bottomright", legend = levels(factor(datDS23t$haarfarbe)), pch = as.integer(factor(datDS23t$haarfarbe)))

# Aufgabe 2

library(readr)
diamanten <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/diamanten.csv", 
                        delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(diamanten)

hist(diamanten$price)
abline(v = quantile(diamanten$price, probs = c(0.25)), lty = 1, col = "red", lwd = 2)
abline(v = quantile(diamanten$price, probs = c(0.5)), lty = 1, col = "blue", lwd = 2)
abline(v = quantile(diamanten$price, probs = c(0.75)), lty = 1, col = "green", lwd = 2)

cut_quality <- unique(diamanten$cut)
print(cut_quality)
diamanten$cut <- factor(diamanten$cut, levels = c("Fair", "Good", "Very Good", "Premium", "Ideal"))
barplot(sort(table(diamanten$cut), decreasing = TRUE))

pairs(diamanten[, c("price", "carat", "depth")], col = rgb(0,0,0, alpha= 0.2))

diamanten$clarity <- factor(diamanten$clarity, levels = c("I1", "SI1", "SI2", "VS1", "VS2", "VVS1", "VVS2", "IF"))
boxplot(diamanten$price ~ diamanten$clarity)

