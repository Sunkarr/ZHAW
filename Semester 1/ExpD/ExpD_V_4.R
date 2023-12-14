simmental <- c(53.9, 54.3, 54.6, 54.6, 54.9, 55.1, 55.2, 55.5, 55.5, 55.5, 55.5, 55.6, 55.8, 55.9, 56.1, 56.1, 56.2, 56.7, 56.9, 56.9, 56.9, 57.4, 57.5, 58.7, 59.6)
angus <- c(51.2, 51.4, 51.9, 51.9, 52.1, 52.6, 52.9, 52.9, 52.9, 53, 53.1, 53.1, 53.3, 53.3, 53.4, 54, 54, 54.1, 54.2, 54.6, 54.6, 54.6, 54.7, 54.8, 54.8)
medsimm <- median(simmental)
quantsimm <- quantile(simmental, c(0.25, 0.75))

histsimm <- hist(simmental,
                 main = "Schulterhöhe der Rasse Simmental",
                 xlab = "Schulterhöhe")
abline(v = medsimm, col = "red", lty = 1, lwd = 2)
abline(v = quantsimm, col = "blue", lty = 1, lwd = 2)

legend("topright", legend = paste("Median =", medsimm), col = "red", lty = 1, lwd = 2,)
legend("topright", legend = paste("Q1 & Q3"), col = "blue", lty = 1, lwd = 2)

boplosimm <- boxplot(simmental, angus,
                     main = "Schulterhöhen zweijähriger Munis in cm",
                     names = c("Simmetal", "Angus"))

max(simmental)

