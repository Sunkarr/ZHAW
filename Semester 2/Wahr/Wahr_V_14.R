# Aufgabe 1

n <- 100000
m <- matrix(NA, nrow = n, ncol = 2)
for (i in 1:n){
sim <- sample(0:1, 100, c(0.5, 0.5), replace = T)
auswertung <- rle(sim)
m[i,1] <- max(auswertung$lengths)
m[i,2] <- length(auswertung$lengths) -1
}

plot(jitter(m))
cor(m)


sum(m[,1] <= 10 & m[,2] <= 40) / n


hist(m[,1])
hist(m[,2])
mean(m[,1])
mean(m[,2])
