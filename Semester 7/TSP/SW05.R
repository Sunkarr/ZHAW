# Exercise 3

## 1)
sigma<-1
a_vec<-c(1.6,-0.9)
b_vec<-c(1,-0.8,0.4)

6/(1-sum(a_vec))

ts.plot(ARMAtoMA(ar = a_vec, ma = b_vec[2:3], lag.max=100))

len <- 300
x<-arima.sim(list(ar=a_vec,ma=b_vec),n=len,sd=sigma)
ts.plot(x)
acf(x)

## 2)
library(readr)
dat <- read_table("Library/CloudStorage/OneDrive-ZHAW/SEM 7/TSP/Part 3/Data/exercise3.txt")
dat <- dat[,2:3]

acf(dat[,1])
pacf(dat[,1])

x <- dat[[1]]
xar_obj<-arima(x,order=c(1,0,1))
tsdiag(xar_obj)

## 3)
max_p <- 5
max_q <- 5
ts.plot(x)
len <- length(x)

sigma_mat <- matrix(0, nrow = max_p + 1, ncol = max_p + 1)
bic_mat <- matrix(0, nrow = max_p + 1, ncol = max_p + 1)

for (p in 0:max_p){
  for (q in 0:max_q){
    fit_try <- try(arima(x, order = c(p, 0, q), method = "ML"), silent = T)
    if (inherits(fit_try, "try-error")) {
      sigma_mat[p+1, q+1] <- 1e99
    } else {
      sigma_mat[p+1, q+1] <- fit_try$sigma2
    }
    bic_mat[p+1, q+1] <- log(sigma_mat[p+1, q+1]) + log(len) * (p + q) / len
  }
}

best_idx <- which(bic_mat == min(bic_mat), arr.ind = TRUE) - 1
p_opt <- best_idx[1]; q_opt <- best_idx[2]
cat("Optimale Ordnungen: AR(p) =", p_opt, "MA(q) =", q_opt, "\n")

final_fit <- arima(x, order = c(p_opt, 0, q_opt))
tsdiag(final_fit)


library(forecast)

# Automatische Modellwahl für stationäre ARMA-Modelle (d=0) bis maximal Ordnung 5
fit_auto <- auto.arima(
  x,
  max.p = 5,
  max.q = 5,
  d = 0,               # Stationär halten (kein Differenzieren)
  ic = "bic",          # Kriterium: "bic", "aic" oder "aicc"
  stepwise = FALSE,    # FALSE = prüft alle Kombinationen (Grid Search wie deine Schleife)
  approximation = FALSE
)

summary(fit_auto)

## 4)
recession_data <- read_table("Library/CloudStorage/OneDrive-ZHAW/SEM 7/TSP/Part 3/Data/recession_data.txt")
y <- recession_data[[2]]

ts.plot(y)

fit_auto <- auto.arima(
  y,
  max.p = 5,
  max.q = 5,
  d = 0,               # Stationär halten (kein Differenzieren)
  ic = "bic",          # Kriterium: "bic", "aic" oder "aicc"
  stepwise = FALSE,    # FALSE = prüft alle Kombinationen (Grid Search wie deine Schleife)
  approximation = FALSE
)

summary(fit_auto)
y_hat<- predict(fit_auto, n.ahead=36)$pred
ts.plot(c(y, y_hat))

fc <- forecast(fit_auto, h = 36, level = c(95))
plot(fc, col = "black", fcol = "red", main = "Forecast Plot mit Konfidenzbändern")
