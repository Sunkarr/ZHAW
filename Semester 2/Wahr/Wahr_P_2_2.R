pbinom(1, size = 5, prob = 0.5)

qgeom(0.5, 1/365)

n <- 100000
students <- 50
m <- matrix(NA, nrow = n, ncol = students)
for (i in 1:n){
  m[i,] <- sample(1:365, students, replace = T)
}

check_duplicates_in_row <- function(matrix) {
  apply(matrix, 1, function(row) {
    any(duplicated(row))
  })
}

(sum(check_duplicates_in_row(m)) / n)

#---------------------------------------------

# Aufgabe 5: Simulation “scaredy cat”

karten <- c(1, 2, 3, 4, 5, 6, 0, 1000)
prob <- c(8/50, 7/50, 7/50, 7/50, 6/50, 6/50, 3/50, 6/50)

count <- 0
katzen <- 0
n <- 10000
m <- matrix(NA, nrow = n, ncol = 2)

for (i in 1:n) {
  count <- 0
  katzen <- 0
  while (count <= 6000) {
    karte_gezogen <- sample(x = karten, size = 1, replace = TRUE, prob = prob)
    if (karte_gezogen == 0) {
      katzen <- katzen + 1
    } else {
      count <- count + karte_gezogen
    }
  }
  m[i, 1] <- count - 6000
  m[i, 2] <- katzen
}

m[,2]==0

#---------------------------------------------

n <- 10000
servicezeit <- c(1.3, 0.75, 1.2, 1.4, 0.9)
zuestaendig <- c(0.06, 0.08, 0.21, 0.28, 0.37)
m <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  masch <- rpois(1, 6)
  m[i,] <- sum(sample(servicezeit, masch, prob = zuestaendig, replace = T))
}
quantile(m, 0.75)

#---------------------------------------------



