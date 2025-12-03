# Aufgabe 1

sodium <- readRDS("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/sodium.rds")
hist(sodium, breaks = 30)

library(car)
qqPlot(sodium, main = "Q-Q Plot of Sodium Data")

t.test(sodium, mu = 1500, alternative = "two.sided", conf.level = 0.99)


# Aufgabe 2

n <- c(3:20)

sim <- function(n, alpha = 0.05, runs = 10000) {
  pvals <- replicate(
    runs,
    t.test(rnorm(n, mean = 1, sd = 1), mu = 0, alternative = "greater")$p.value)
  sum(pvals < alpha) / runs
}

res.simu <- sapply(n, sim)
plot(n, res.simu)

# Macht berechnen

res.r <- power.t.test(n = n, delta = 1, sig.level = 0.05, type = "one.sample",
                      alternative = "one.sided")
plot(n, res.simu)
lines(n, res.r$power)

power.t.test(delta = 1, sig.level = 0.05, power = 0.99, type = "one.sample",
             alternative = "one.sided", n = NULL)



# Aufgabe 3

# a)

getpVals <- function(mu = 0, n = 10, nsim = 10000) {
  replicate(
    nsim,
    t.test(rnorm(n, mean = mu, sd = 1), alternative="two.sided")$p.value)
}
p <- getpVals(0)
hist(p, freq = FALSE)
abline(h = 1)

sum(p < 0.05)

# b)

par(mfrow = c(1, 2))
p <- getpVals(0.1)
hist(p, freq = FALSE, main = paste0("Mu = 0.1 p < 0.05: ", sum(p < 0.05)))
abline(h = 1)
p <- getpVals(1)
hist(p, freq = FALSE, main = paste0("Mu = 1 p < 0.05: ", sum(p < 0.05)))
abline(h = 1)

# c)

par(mfrow = c(1, 2))
p <- getpVals(0.1, n = 100)
hist(p, freq = FALSE, main = paste0("Mu = 0.1 p < 0.05: ", sum(p < 0.05)))
abline(h = 1)
p <- getpVals(1, n = 100)
hist(p, freq = FALSE, main = paste0("Mu = 1 p < 0.05: ", sum(p < 0.05)))
abline(h = 1)

