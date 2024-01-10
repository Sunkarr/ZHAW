# Aufgabe 1

# a) 11331


# b)
# Tag = ordinal
# US.Staat = ordinal
# Flugdauer = stetig
# Verspaetung = stetig

# c)

airline$Grund <- factor(airline$Grund, levels = c("No Delay", "Carrier", "Late Aircraft", "National Air System", "Security", "Weather"))


# d)

unique(airline$US.Staat[airline$Flugdauer > 360])


# e)

nyfl <- c(airline$US.Staat == "FL")
mean(airline$Flugdistanz[nyfl])
sd(airline$Flugdistanz[nyfl])


# f)

table(airline$Verspaetung)
prop.table(table(airline$Verspaetung))


# g)

weathcal <- c(airline$US.Staat == "CA"
              & airline$Grund == "Weather")
sum(weathcal)
totcal <- c(airline$US.Staat == "CA")
sum(totcal)

100/sum(totcal)*sum(weathcal)


# Aufgabe 2

# a)

barplot(sort(table(airline$US.Staat), decreasing = TRUE))
max(table(airline$US.Staat))


# b)

boxplot(airline$Flugdistanz ~ airline$Verspaetung,
        col = c("red", "blue"),
        main = "Verspaetung",
        ylab = "Flugdistanz [mile]",
        xlab = "Verspaetung")

# c)

staaten <- airline$US.Staat %in% c("AZ", "LA", "MT", "OR", "PR")
sum(staaten)

mosaicplot(airline$US.Staat[staaten] ~ airline$Verspaetung[staaten])


# d)

plot(airline$Flugdauer ~ airline$Flugdistanz)





           