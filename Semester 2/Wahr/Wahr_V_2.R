set.seed(1)
sample(1:6, size = 5, replace = T)

nwurf <- 1000
p <- c(1,2,2,2,2,3)/12
w <- sample(1:6, size = nwurf, replace=T, prob = p)
sum(w == 6)

nsim <- 50000
w <- matrix(NA, nrow = nsim, ncol = 2)
for (i in 1:nsim) {
  w[i,] <- sample(1:6, size = 2, replace = T)}

as.data.frame(w)
w$sum <- w$V1 + w$V2

#AB1
nwurf <- 50000
w_fair <- sample(1:6, size = nwurf, replace=T)
barplot(table(w_fair))

p <- c(4,4,4,4,4,80)/100
w_gezinkt <- sample(1:6, size = nwurf, replace=T, prob = p)
barplot(table(w_gezinkt))

sum(w_fair == 6)/nwurf
sum(w_gezinkt == 6)/nwurf

#Würfeln ohne Schlaufe
nsim <- 10000
x <- sample(1:6, size = nsim*10, replace = T)
w <- matrix(x, ncol = 10, nrow = nsim)
n6 <- rowSums(w == 6)
sum(n6>= 7)/nsim

zuege <- expand.grid(chauffeur=1:6,
                     zugfahrzeug=1:4,
                     anhaenger=1:8)
zuege


install.packages("combinat")
library(combinat)
birne <- permn(c("B","I","R","N","E"))
erbse <- permn(c("E","R","B","S","E"))
unique(erbse)

mississippi

factorial(11)/(factorial(4)*factorial(4)*factorial(2))

# Aufgabe 2
4*3*5*10

factorial(26)/factorial(22)

2/factorial(5)

3^13

factorial(18)/factorial(15)

mississippi
factorial(11)/(factorial(4)*factorial(4)*factorial(2))

