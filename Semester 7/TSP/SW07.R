# Exercise 5 Seasonal Processes

library(forecast)


## 1)
set.seed(87)
len<-100
y<-rep(NA,12*len)
a1<-0.8
sigma<-1
for (i in 1:12)
{
  x<-arima.sim(list(ar=a1),n=len,sd=sigma)
  y[i+(0:(len-1)*12)]<-x
}

ts.plot(x)
ts.plot(y)
acf(y,lag.max=48)

y_obj<-arima(y, seasonal = list(order = c(1, 0, 0), period = 12))
y_obj
tsdiag(y_obj,gof.lag=48)


## 2)
load(file=paste("/Users/jonas/Library/CloudStorage/OneDrive-ZHAW/SEM 7/TSP/Part 5/","/Data/exercise5",sep=""))

x<-mat[,1]
ts.plot(x)
acf(x)

x_fit <- arima(x, order = c(0, 0, 0), seasonal = list(order = c(1, 0, 0), period = 12))
tsdiag(x_fit, gof.lag = 48)

x_fc <- forecast(x_fit, h = 240)
plot(x_fc, col = "black", fcol = "red")

myts <- ts(x, frequency = 12)
x_auto_fit <- auto.arima(myts, seasonal = TRUE)
summary(x_auto_fit)


## 3)
load(file=paste("/Users/jonas/Library/CloudStorage/OneDrive-ZHAW/SEM 7/TSP/Part 5/","/Data/electricity_load",sep=""))
dat<-data.frame(x)

ts.plot(dat)
acf(dat)

len<-length(x)
s<-24

fit <- arima(x, order = c(0, 0, 0), seasonal = list(order = c(1, 0, 0), period = s))
tsdiag(fit, gof.lag = 48)

fit <- arima(x, order = c(1, 1, 1), seasonal = list(order = c(1, 1, 1), period = s))
tsdiag(fit, gof.lag = 48)

myts <- ts(x, frequency = s)
auto_fit <- auto.arima(myts, seasonal = TRUE)
auto_fit



