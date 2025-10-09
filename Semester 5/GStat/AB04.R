# Aufgabe 2

xs <- c(-0.033, -0.76, 2.02, 1.13, 0.65, 0.49, 0.76, 0.40, 0.10, 0.61)

# a)

loglik <- function(mu, sigma, dat) {
  result <- sum(dnorm(x = dat, mean = mu, sd = sigma, log = TRUE))
  return(as.numeric(result))  # Explizit als Skalar zurückgeben
}

loglik(mu = 0, sigma = 1, dat = xs)

# b)
###
### Funktion loglik(mu, sigma, dat) muss definiert sein !!!
###
library(manipulate)

manipulate (
  {
    lik = loglik(mu = muEst, sigma = sigmaEst, dat = xs)
    # W'keitdichte einzeichnen für Werte von -5 bis 5
    xvals = seq(-5,5,0.05) 
    plot(xvals, dnorm(xvals, mean=muEst, sd=sigmaEst),
         type="l",xlab="Daten", ylab="", pch= '|',
         main=paste0("loglikelihood = ", round(lik,digits=3)), xlim=c(0.95*min(xs),1.05*max(xs)))
    # Stichprobenwerte auf der x-Achse einzeichnen
    rug(x = xs, lwd = 3, col = "blue")
    # Legende
    legend(x="topright",
           legend = c("Datenpunkte", "W'keitdichte"), lwd =c(2,1), col = c("blue", "black"), bty = "n")
  },
  # Slider für den Parameter mu
  muEst = slider (-5 ,5, initial=0.1, step=0.01),
  # Slider für en Parameter sigma
  sigmaEst = slider (0,5, initial=0.1, step=0.01)
)

# c)
# Guess the maximum by trying different values for mu and sigma with a grid
muVals <- seq(-1, 3, by = 0.1)
sigmaVals <- seq(0.1, 3, by = 0.1)
loglikMat <- matrix(NA, nrow = length(muVals), ncol = length(sigmaVals))
for (i in 1:length(muVals)) {
  for (j in 1:length(sigmaVals)) {
    loglikMat[i, j] <- loglik(mu = muVals[i], sigma = sigmaVals[j], dat = xs)
  }
}
maxLoglik <- max(loglikMat)
whichMax <- which(loglikMat == maxLoglik, arr.ind = TRUE)
(muHat <- muVals[whichMax[1]])
(sigmaHat <- sigmaVals[whichMax[2]])

# d)
# optimize funktion with optim()

lik <- function(param) {
  -loglik(mu = param[1], sigma = param[2], dat = xs)  # Negative Log-Likelihood zurückgeben
}

result <- optim(par = c(0, 1), fn = lik, method = "L-BFGS-B", lower = c(-5, 0.001))
result$par  # Geschätzte Parameterwerte



# Aufgabe 3
dichte <- function(theta, x) {
  return(theta * x^(theta - 1))
}
# a)
x <- seq(0, 1, by = 0.01)
theta <- c(1/3, 1/2, 1, 2, 3)

# Plot with one curve for each theta
plot(x, dichte(theta[1], x), type = "l", col = "1", ylim = c(0, 3), ylab = "Dichte", xlab = "x", main = "Dichtefunktion für verschiedene Theta-Werte")
for (i in 2:length(theta)) {
  lines(x, dichte(theta[i], x), col = i + 1)
}
legend(x = "top", legend = c("theta=1/3", "theta=1/2", "theta=1", "theta=2", "theta=3"),
       fill = 1:5, cex = 0.5)
