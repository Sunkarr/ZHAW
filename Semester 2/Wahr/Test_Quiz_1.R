# Würfeln gezinkt

nsim <- 100000
w <- 0
counter <- 0
counterend <-0
probs_1 <- c(3.5,3.5,3.5,3.5,41,45)/100
for (i in 1:nsim) {
  for (x in 1:3) {
    Jen<- sum(sample(1:6, size = 4, replace = TRUE))
    Sil<-sum(sample(1:6, size = 4,prob = probs_1, replace = TRUE))
    if (Sil > Jen) {
      counter = counter + 1
    }
    
  }
  if (counter == 3) {
    counterend = counterend + 1
    
  }
  counter = 0
}
counterend / nsim


nsim <- 100000
props <- c(0.0325, 0.0325, 0.0325, 0.0325, 0.44, 0.43)
count <- 0
for (i in 1:nsim) {
  silvan_count <- 0
  for (j in 1:3) {
    silvan <- sample(1:6, size=5, replace = T, prob=props)
    jennefer <- sample(1:6, size=5, replace=T)
    if (sum(silvan) > sum(jennefer)) {
      silvan_count <- silvan_count + 1
    }
  }
  if (silvan_count == 3) {
    count <- count + 1
  }
}

count/nsim

# Würfeln gezinkt 2

n <- 10000
p <- c(74/5, 74/5, 74/5, 74/5, 74/5, 26)/100
W <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n) {
  W[i,] <- sample(1:6, size = 1, replace = T, prob = p)}

E <- sum(W)/n
44/E



# Würfeln gezinkt 3

nsim <- 100000
count = 0
punkte = 0
totpunkte <- 0
probs <- c(rep(((100-24)/5), 5), 24)/100
würfel <- c(seq(1:6))
E <- sum(probs*würfel)
for (i in 1:nsim) {
  while (punkte < 44) {
    punkte = punkte + sample(1:6, size = 1, replace = TRUE,prob = probs)
    count = count + 1
  }
  punkte = 0
  totpunkte = totpunkte+ count
  count = 0
}

totpunkte / nsim


# Turbinen
n_turbines <- 20
n_days <- 27
n_simulations <- 100000
prob <- c(92, 8)/100

M <- matrix(NA, nrow = n_simulations, ncol = n_days)

for (sim in 1:n_simulations){
  for (day in 1:n_days){
    x <- sum(sample(0:1, size = n_turbines, replace = TRUE, prob = prob))
    M[sim, day] <- x
  }
}

count_elements_greater_than_equal_to_2 <- function(row) {
  sum(row >= 2)
}

dat <- as.data.frame(M)

dat$count <- apply(dat, 1, count_elements_greater_than_equal_to_2)

mean(dat$count)



