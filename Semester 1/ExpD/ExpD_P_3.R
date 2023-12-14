#Aufgabe 2

#a) und b)
nrow(kiebitz)
ncol(kiebitz)
dim(kiebitz)
str(kiebitz)

#c)
sapply(kiebitz, typeof)

#d)
ID1411<-kiebitz[1, ]

#e)
AnzID1411<-kiebitz[1, 2]

#Aufgabe 3
datDS23t<-readRDS("C:\\Users\\jonas\\OneDrive - ZHAW\\Sem 1\\ExpD\\datDS23t_raw.rds")
datDS23t[12, "Q00_Koerpergroesse"]
datDS23t[16, "Q00_Statistische_Vorkenntnisse"]
datDS23t[15, "Q00_Ausbildung"]
datDS23t[24, c("Q00_Schlafzimmer", "Q00_Postleitzahl")]
#...

#Aufgabe 4
dim(sleep)

differenz<-c(sleep$Schlafmittel-sleep$Placebo)         
sleep$Differenz<-differenz

mean(differenz)
median(differenz)

stripchart(differenz)
breakshist<-c(seq(0, 5, by = 0.5))
hist(differenz, breaks = breakshist)

plot(ecdf(differenz))
