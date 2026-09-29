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


