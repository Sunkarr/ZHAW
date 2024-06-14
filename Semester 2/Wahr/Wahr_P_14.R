# Aufgabe 1
library(UsingR) # Enthält Datensatz
data(father.son)
dat <- father.son * 2.54


plot(dat)



mu_f <- mean(dat$fheight)
mu_s <- mean(dat$sheight)
sigma <- cov(dat)

library(mvtnorm)

### Grid erstellen
x <- seq(range(dat)[1], range(dat)[2], length = 200)
y <- x
grid.xy <- expand.grid(x,y)
### Dichte f(x,y) berechnen (bivariate Normalverteilung)
out <- dmvnorm(grid.xy,mean=c(mu_f, mu_s),sigma=sigma)
image(x=x, y=y, matrix(out,ncol=length(x)), asp =1, las=1)
contour(x=x, y=y, matrix(out,ncol=length(x)), add=TRUE)



pmvnorm(lower = c(190, 190), upper = c(Inf, Inf), mean = c(mu_f, mu_s), sigma = sigma)

pmvnorm(lower = c(180, 160), upper = c(190, 170), mean = c(mu_f, mu_s), sigma = sigma)


