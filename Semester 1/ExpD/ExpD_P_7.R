# Aufgabe 1

library(readr)
oil_animals <- read_csv("~/GitHub/ZHAW/Semester 1/ExpD/Grundlagen/oil-animals.csv")
View(oil_animals)

plot(x = oil_animals$Longitude,
     y = oil_animals$Latitude,
     xlab = "Breitengrad",
     ylab = "Längengrad"
     )

pdf(file = "myplot.pdf")

par(mfrow = c(1, 2))
custom_colours <- c("orange", "red")
palette(custom_colours)


oil_animals$Alive <- factor(oil_animals$Alive, labels = c("Yes", "No"))
plot(x = oil_animals$Longitude,
     y = oil_animals$Latitude,
     main = "Animals alive",
     xlab = "Breitengrad",
     ylab = "Längengrad",
     col = oil_animals$Alive
     )
legend("bottomleft", c("Yes", "No", "Deepwater Horizon"), pch = c(1, 1, 4), col = c(1, 2, "blue"))
points(x = -87.68528,
       y = 28.75389,
       pch = 4,
       col = "blue",
       cex = 2,
       lwd = 2
       )

unique(oil_animals$Type)
oil_animals$Type <- factor(oil_animals$Type, labels = c("turtles", "birds"))
plot(x = oil_animals$Longitude,
     y = oil_animals$Latitude,
     main = "Animal type",
     xlab = "Breitengrad",
     ylab = "Längengrad",
     col = oil_animals$Type
     )
legend("bottomleft", c("birds", "turtles", "Deepwater Horizon"), pch = c(1, 1, 4), col = c(1, 2, "blue"))
points(x = -87.68528,
      y = 28.75389,
      pch = 4,
      col = "blue",
      cex = 2,
      lwd = 2
      )

dev.off()
