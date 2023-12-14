#Aufgabe 3
Westeuropa<-c(25, 24, 21, 29, 21, 21, 22, 22, 20, 25, 22, 27, 21, 25, 23)
Osteuropa<-c(20, 26, 21, 23, 21, 22, 22, 20, 20, 20, 20, 21, 24)

meanWesteuropa<-mean(Westeuropa)
meanOsteuropa<-round(mean(Osteuropa), digits = 1)

medianWesteuropa<-median(Westeuropa)
medianOsteuropa<-median(Osteuropa)

#Aufgabe 4
plot(ecdf(Westeuropa))
plot(ecdf(Osteuropa))

Löhne<-c(rep(10000, 7), rep(12000, 1), rep(15000, 3), rep(24000, 2), 60000, 125000)
Löhne

meanLöhne<-mean(Löhne)
medianLöhne<-median(Löhne)

#Aufgabe 5

dat<-readRDS("C:\\Users\\jonas\\OneDrive - ZHAW\\Sem 1\\ExpD\\datDS23t_raw.rds")

Anreise<- c(dat$Q00_Anreisezeit_an_die_ZHAW)
meanAnreise<-mean(Anreise, na.rm = TRUE)
medianAnreise<-median(Anreise, na.rm = TRUE)

Anreisehist<-hist(Anreise, xlim = )
abline(v=medianAnreise, col="red", lwd=3)
abline(v=meanAnreise, col="blue", lwd=3)
legend("topright", legend=c(paste("Median = ", round(medianAnreise, 2)),
                            paste("Mean = ", round(meanAnreise, 2))),
       col=c("red", "blue"), lwd=3)

