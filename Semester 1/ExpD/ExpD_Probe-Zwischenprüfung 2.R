versplevels <- c("No Delay", "Carrier", "Late Aircraft", "National Air System", "Security", "Weather")
airline$verspaetung_factor2 <- factor(airline$Verspaetung, levels = versplevels)

flug6 <- airline$Flugdauer > 360
flug6dest <- unique(airline$US.Staat[flug6])

flugdistNYFL <- airline$Flugdistanz[airline$US.Staat == "FL"]
mean(flugdistNYFL)
sd(flugdistNYFL)

sum(airline$Verspaetung)

table(airline$Verspaetung)
prop.table(table(airline$Verspaetung))

verspcawea <- airline$Grund == "Weather" & airline$US.Staat == "CA"
table(verspcawea)
flugca <- airline$US.Staat == "CA"
sum(verspcawea) / sum(flugca)

barplot(sort(table(airline$US.Staat)), decreasing = TRUE)
sort(table(airline$US.Staat))

boxplot(airline$Flugdistanz ~ airline$Verspaetung,
        col = c("red", "blue"),
        xlab = "Verspaetung",
        ylab = "Flugdistanz [mile]",
        main = "Verspaetung")

staaten <- airline[airline$US.Staat %in% c("AZ", "LA", "MT", "OR", "PR"),]
mosaicplot(staaten$US.Staat ~ staaten$Verspaetung)

plot(airline$Flugdauer ~ airline$Flugdistanz)
