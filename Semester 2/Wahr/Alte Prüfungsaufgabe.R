# Aufgabe 3: Studiengangleiter (Alte Prüfungsaufgabe)

n <- 100000
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  m[i,] <- sample(0:1, 1, prob = c(0.2, 0.8), replace = T) + sample(0:1, 1, prob = c(0.18, 0.82), replace = T) + sample(0:1, 1, prob = c(0.34, 0.66), replace = T)
}
(sum(m>=2) / n)



klasse <- 32
for (i in 1:n){
  m[i,] <- ceiling(rpois(1, 100)/klasse)
}
mean(m)



klasse <- 40
for (i in 1:n){
  m[i,] <- ceiling(rpois(1, 100)/klasse)
}
mean(m)


for (i in 1:n){
  m[i,] <- ceiling(rpois(1, 100)/32) - ceiling(rpois(1, 100)/40)
}
mean(m) * 150000



# Aufgabe 4: Eishockey-Playoffs (Alte Prüfungsaufgabe)

dbinom(3, 5, c(0.5))

sample(0:1, 3, prob = c(0.2, 0.8))
