# Aufgabe 1

# a)

f <- c(68, 130, 84)
m <- c(137, 72, 26)

table <- matrix(c(f, m), nrow = 2, byrow = TRUE)
colnames(table) <- c("kaum", "etwas", "stark")
rownames(table) <- c("Frau", "Mann")

n <- sum(table)
(erwartet <- outer(rowSums(table), colSums(table)) / n)


# b)

sum((table-erwartet)^2 / erwartet)
freiheitsgrade <- (nrow(table)-1)*(ncol(table)-1)
qchisq(0.95, df = freiheitsgrade)


# c)

(table.test <- chisq.test(table))


# Aufgabe 2

## a)

haustier <- matrix(c(28, 50, 11, 3), nrow = 2, byrow = TRUE)
colnames(haustier) <- c("Nein", "Ja")
rownames(haustier) <- c("Frau", "Mann")

# berechnen der randsummen
n2 <- sum(haustier)
(erwartet <- outer(rowSums(haustier), colSums(haustier)) / n2)


## c)

haustier.test <- chisq.test(haustier)
haustier.test




