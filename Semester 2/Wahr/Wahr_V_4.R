# AB 4

# Aufgabe 2

choose(5,2)

kugeln <- c("B1", "B2", "B3", "R1", "R2")
sample(kugeln, 2, replace = F)

combn(kugeln, m = 2)

sample(c(4, -1, -6), 1, prob = c(3/10, 6/10, 1/10))

# Aufgabe 4

plot(c(-6, -1, 4), cumsum(c(3/10, 6/10, 1/10)), type = "s")

n <- 10000
w <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n) {
  w[i,] <- sample(c(4, -1, -6), 1, prob = c(3/10, 6/10, 1/10))}

mean(w)


