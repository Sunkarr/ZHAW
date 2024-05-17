library(mvtnorm)

mu <- c(0, 0)
sigma <- matrix(c(1, 0.5, 0.5, 1), nrow = 2)
sigma1 <- matrix(c(1, 0, 0, 1), nrow = 2)
dmvnorm(c(0,0), mean = mu, sigma = sigma)


x1 <- seq(-4,4,0.1)
x2 <- seq(-4,4,0.1)

z <- expand.grid(x1=x1,x2=x2)
z

f <- dmvnorm(z, mean = mu, sigma = sigma)
f
head(cbind(z,f))

fz <- matrix(f, nrow = length(x1), ncol = length(x2))

# Möglichkeit 1: Contour-Plot
image(x1,x2,fz, las=1)
contour(x1,x2,fz, add=TRUE)

# Möglichkeit 2: 3D
persp(x1,x2,fz, theta = -90, phi = 30)

pmvnorm(lower = c(-Inf, -Inf), upper = c(0,0), mean = mu, sigma = sigma)
qmvnorm(p = 0.9, mean = mu, sigma = sigma, tail = "both")$quantile
rmvnorm(100, mean = mu, sigma = sigma)


# Aufgabe 1

mu <- c(7, 15)
sigma <- matrix(c(25^2, -0.4*25*45, -0.4*25*45, 45^2), nrow = 2)
x1 <- seq(-100,100,1)
x2 <- seq(-100,100,1)
z <- expand.grid(x1=x1,x2=x2)
f <- dmvnorm(z, mean = mu, sigma = sigma)
head(cbind(z,f))
fz <- matrix(f, nrow = length(x1), ncol = length(x2))
image(x1,x2,fz, las=1)
contour(x1,x2,fz, add=TRUE)


pmvnorm(lower = c(-Inf, -Inf), upper = c(0, 0), mean = mu, sigma = sigma)


pmvnorm(lower = c(-Inf, -Inf), upper = c(0, 0), mean = mu, sigma = sigma) / pmvnorm(lower = c(-Inf,-Inf), upper = c(0, Inf), mean = mu, sigma = sigma)

