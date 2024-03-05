# Aufgabe 1: Simulation Urne

nsim <- 1000
w <- matrix(NA, nrow = nsim, ncol = 2)
for (i in 1:nsim) {
  w[i,] <- sample(1:9, size = 2, replace = T)}
ohneblau <- apply(w, 1, function(row) !any(row %in% c(7, 8, 9)))
sum(ohneblau)/nsim


# Aufgabe 2: Glücksrad

values2 <- c(7, 2, 4, 1)
prob2 <- c(0.5, 0.25, 0.125, 0.125)
nsim2 <- 1000
result2 <- data.frame(matrix(NA, nrow = nsim2, ncol = 5))
for (i in 1:nsim2) {
  result2[i,] <- sample(values2, size = 5, prob = prob2, replace = T)}

result2$X1 <- result2$X1 * 10000
result2$X2 <- result2$X2 * 1000
result2$X3 <- result2$X3 * 100
result2$X4 <- result2$X4 * 10
result2$X5 <- result2$X5 * 1

result2$numb <- rowSums(result2)

end2 <- sum(result2$numb < 41721)/nsim2


# Aufgabe 3: Kombinatorik

# a) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

mögliche3a <- 5*4*3
günstige3a <- 5*4
result3a <- günstige3a/mögliche3a

# b)

mögliche3b <- factorial(8-1)
günstige3b <- 2*2*factorial(6-1)
result3b <- günstige3b/mögliche3b

# c)

result3c <- factorial(11)/factorial(11-5)
result3c

# d)

result3d <- factorial(7+5)/(factorial(5)*factorial(12-5))

# e) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

result3e <- choose(3, 3) * 0.9**3

# f)


# Aufgabe 4: Eishockey-Playoffs (Alte Prüfungsaufgabe)

# a)

choose(7, 4)






