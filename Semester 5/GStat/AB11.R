# Aufgabe 1

sodium <- readRDS("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/sodium.rds")
hist(sodium, breaks = 30)

library(car)
qqPlot(sodium, main = "Q-Q Plot of Sodium Data")

t.test(sodium, mu = 1500, alternative = "two.sided", conf.level = 0.99)


# Aufgabe 2

stichprobengrösse <- c(1:20)
nsim <- 10000
for (i in nsim){
  
}
