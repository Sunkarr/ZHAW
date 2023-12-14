load("C:\\Users\\jonas\\OneDrive\\Dokumente\\GitHub\\ZHAW\\Semester 1\\ExpD\\Grundlagen\\bestellungen.rda")
library(readr)
PLZO_CSV_LV03 <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/PLZO_CSV_LV03.csv", 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

agg <- merge(x = bestellungen, 
             y = PLZO_CSV_LV03,
             by = c("PLZ", "Zusatzziffer"),
             all.x = TRUE)

kantone <- sort(unique(PLZO_CSV_LV03$Kantonskuerzel))
dat$length <- aggregate(agg$Kantonskuerzel,
                      by = list(agg$Kantonskuerzel),
                      FUN = length)
dat$mean <- aggregate(agg$preis,
                 by = list(agg$Kantonskuerzel),
                 FUN = mean)
dat$max <- datmean <- aggregate(agg$preis,
                               by = list(agg$Kantonskuerzel),
                               FUN = max)
dat$date <- datmean <- aggregate(agg$timestamp,
                               by = list(agg$Kantonskuerzel),
                               FUN = max)

# Aufgabe 3
?airquality
airquality$windstatusboolean <- airquality$Wind >= 12
airquality$windstatus <- gsub(FALSE, "nicht-windig", airquality$windstatus)
airquality$windstatus <- gsub(TRUE, "windig", airquality$windstatus)

aggwind <- aggregate(x = airquality$windstatusboolean,
                     by = list(airquality$Month),
                     FUN = sum,
                     )
colnames(aggwind) <- c("Monat", "Anzahl_Windtage")
aggwind

aggsolwind <- aggregate(cbind(Solar.R, Wind) ~ Month,
                        data = airquality,
                        FUN = mean,
                        na.action = na.omit)

aggsolwind

aggairquality <- aggregate(cbind(Ozone, Solar.R, Wind, Temp) ~ Month,
                           data = airquality,
                           FUN = mean,
                           na.action = na.omit)
aggairquality
