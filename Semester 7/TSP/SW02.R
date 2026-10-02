# Exercise 2.1

## 1)

set.seed(100)
sim_100_a <- arima.sim(list(ma = -0.7), n = 100, sd = 1)
sim_100_b <- arima.sim(list(ma = c(rep(0, 4), 0.5)), n= 100, sd=1)

plot(sim_100_a)
plot(sim_100_b)

## 2)

library(readr)
ma50 <- read_table("Library/CloudStorage/OneDrive-ZHAW/SEM 7/TSP/Part 2/Data/ma50.txt", 
                   col_names = FALSE)

acf(ma50[,1])
ts.plot(ma50[,1])
acf(ma50[,2])
acf(ma50[,3])

x_obj <- arima(ma50[,1], order = c(0,0,1))
x_obj

tsdiag(x_obj)


# Exercise 2.2

## 1)

set.seed(100)

b_1 <- 0.9
sigma <- 2
mean <- 0
R0 <- sigma^2 * (1 + b_1^2)
ARMAacf( ma = b_1, lag.max = 10, pacf = FALSE)

## 2)

set.seed(10)

b_1 = -0.7
len = 100
sigma = 1
x <- arima.sim(list(ma = b_1), n = len, sd = sigma)

acf(x)
x_obj <- arima(x, c(0,0,1))
x_obj

tsdiag(x_obj)

p <- predict(x_obj, 10)
p$pred

## 3)

b_1 = -1.7
b_2 = 0.8
sigma = 2

fi <- function(dataset,
               modelorder_p,
               modelorder_q,
               modelorder_a,
               forecast_horizon) {
  est <- arima(dataset, order = c(modelorder_p, modelorder_a, modelorder_q))
  predict(est, n.ahead = forecast_horizon)
  ci <- 1.96 * sqrt(predict(est, n.ahead = forecast_horizon)$se)
  return(list(pred = predict(est, n.ahead = forecast_horizon)$pred,
              lower = predict(est, n.ahead = forecast_horizon)$pred - ci,
              upper = predict(est, n.ahead = forecast_horizon)$pred + ci))
}

n <- 1000
len <- 50

m <- matrix(NA, nrow = n, ncol = 3)
for (i in 1:n) {
  m[i,1] <- fi(arima.sim(list(ma = c(b_1, b_2)), n = len, sd = sigma), 0, 2, 0, 1)$lower
  m[i,2] <- fi(arima.sim(list(ma = c(b_1, b_2)), n = len, sd = sigma), 0, 2, 0, 1)$pred
  m[i,3] <- fi(arima.sim(list(ma = c(b_1, b_2)), n = len, sd = sigma), 0, 2, 0, 1)$upper
}


# Exercise 2.3

## 1)

c_i<-6
a_vec<-c(1.6,-1.4,0.5)
# Process is stationary: all roots smaller one in absolute value
abs(polyroot(c(-a_vec[length(a_vec):1],1)))

#   Second (simpler) formula
mu<-c_i/(1-sum(a_vec))
# Acf decays to zero beyond lag 40: 'long' memory
# The cycle in the acf is indicative of cycles in the data with similar mean-length
ts.plot(ARMAacf( ar = a_vec, lag.max = 100, pacf = FALSE))

len<-300
x<-arima.sim(list(ar=a_vec),n=len)
ts.plot(x)

acf(x)
pacf(x)
tsdiag(arima(x, order = c(3,0,0)), gof.lag = 20)

## 2)

mat <- read_table("Documents/GitHub/ZHAW/Semester 7/TSP/Data/exercise23.txt")

par(mfrow=c(4,1))
acf(mat[,1])
acf(mat[,2])
acf(mat[,3])
acf(mat[,4])

par(mfrow=c(4,1))
pacf(mat[,1])
pacf(mat[,2])
pacf(mat[,3])
pacf(mat[,4])

x<-mat[,4]
y_ma<-arima(x,order=c(4,0,0))
tsdiag(y_ma,gof.lag=20)
tsdiag(y_ma,gof.lag=200)

## 3)

set.seed(10)
len <- 100
# x = 0.95x_{t-1} + e_t
x <- arima.sim(list(ar=0.95), n=len)
par(mfrow=c(2,1))
acf(x)
pacf(x)
xar_obj<-arima(x,order=c(1,0,0))
tsdiag(xar_obj)

xma_obj<-arima(x,order=c(0,0,5))
tsdiag(xma_obj)
xma_obj<-arima(x,order=c(0,0,6))
tsdiag(xma_obj)

# MA(1)
xma_obj<-arima(x,order=c(0,0,1))
tsdiag(xma_obj)
# AR(1)
xma_obj<-arima(x,order=c(1,0,0))
tsdiag(xma_obj)


