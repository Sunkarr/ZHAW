# Aufgabe 1

prob <- 288 / 8306

1 - sum(dbinom(x = 1:24, size = 24, prob = prob))

1 - sum(dbinom(x = 1:18, size = 18, prob = prob))

sum(dbinom(x = 5, size = 18, prob = prob))

sum(dbinom(x = 3:18, size = 18, prob = prob))

sum(dbinom(x = 0:2, size = 18, prob = prob))


# Aufgabe 2

sum(dbinom(x = 1800:3720, size = 3720, prob = 0.5))


# Aufgabe 3

sum(dbinom(2:4, 200, 0.015))

sum(dbinom(2:4, 300, (1/90)))

n <- 10000
Filiale_A <- rbinom(n, 200, 0.015)
Filiale_B <- rbinom(n, 300, (1/90))
M <- as.data.frame(cbind(Filiale_A, Filiale_B))
M$result[M$Filiale_A > M$Filiale_B] <- 0
M$result[M$Filiale_A < M$Filiale_B] <- 1
M$result[M$Filiale_A == M$Filiale_B] <- 0
sum(M$result) / n


# Aufgabe 4

1 - pgeom(9, 1/7)
plot(pgeom(0:9, 1/7))

n <- 1000
Leo <- rgeom(n, 10/70)
smaller_than_20 <- function(vec) {
  count <- 0
  for (element in vec) {
    if (element <= 20) {
      count <- count + 1
    }
  }
  return(count)
}
count <- smaller_than_20(Leo)
prob_ei_mit_figur <- count / n
prob_ei_mit_superheld <- prob_ei_mit_figur * (3/10)
print(prob_ei_mit_superheld)


