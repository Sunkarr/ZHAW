dnbinom(8, 9, 0.3)


# Fischen

n <- 10000000
lambda_fische_pro_4h <- 273/24*4
fische_schwimmen_in_4h <- rpois(n, lambda_fische_pro_4h)
fische_gefangen_in_4h <- matrix(NA, nrow = n, ncol = 1)
for (i in 1:n){
  fische_gefangen_in_4h[i,] <- rbinom(1, fische_schwimmen_in_4h[i], 0.1)
}
mean(fische_gefangen_in_4h)


1 - sum(dpois(0:4, 1.2))
sum(dpois(0:4, 1.2))

rgeom(10, 0.4)
