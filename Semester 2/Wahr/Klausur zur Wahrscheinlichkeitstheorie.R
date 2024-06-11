# Aufgabe 1

20/25


# Aufgabe 2

wuerfel <- 1:6
kombinationen <- expand.grid(Wurf1 = wuerfel, Wurf2 = wuerfel)
print(kombinationen)


# Aufgabe 5

884/1500

qbinom(0.05, 1500, 0.6)

sum(wuerfel^2)
sum(wuerfel)

prob<- c(rep(1/6, 6))

n <- 1000000
m <- matrix(NA, ncol = 1, nrow = n)
for (i in 1:n){
  m[i,] <- (sample(wuerfel, size = 1, prob = prob))^2 * sample(wuerfel, size = 1, prob = prob)

}

mean(m)
sd(m)



# Aufgabe 8

pbinom(17, 365, 1/20, lower.tail = F)










