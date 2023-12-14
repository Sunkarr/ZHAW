#Aufgabe 1
#a)
kiebitz<-read.table("C:\\Users\\jonas\\OneDrive - ZHAW\\Sem 1\\ExpD\\Grundlagen\\kiebitz.txt",
                    sep = ",",
                    header = TRUE)
#b)
kibi1411 <- kiebitz$Feld.Nr==1411
kibisel <- kiebitz[kibi1411, ]
print(kibisel)

#c)
kibise1411fr <- kibisel$Taetigkeit=="fr"
kibise1411frdat <- kibisel[kibise1411fr, ]
print(kibise1411frdat)
anzkibiselfr <- c(kibise1411frdat$Anzahl)
sum(anzkibiselfr)

#d)
print(kiebitz)
kibiru <- kiebitz$Taetigkeit=="ru"
kibirudat <- kiebitz[kibiru, ]
print(kibirudat)
kibirufeld <- c(kibirudat$Feld.Nr)
#bereinigt Vektor kibirufeld
kibirufeld <- sort(kibirufeld)
kibirufeld <- unique(kibirufeld)

kibirumax <- which.max(kibirudat$Anzahl)
print(kibirumax)
kibirudat$Anzahl[kibirumax]

rm(list = ls())
#Aufgabe 2
#a)
library(readxl)
datDS23t <- read_excel("C:/Users/jonas/OneDrive - ZHAW/Sem 1/ExpD/datDS23t.xlsx")
View(datDS23t)

datDS23t$Antworten = NULL
colnames(datDS23t) <- gsub(pattern = "Q00_", replacement = "", x = colnames(datDS23t))
colnames(datDS23t) <- tolower(colnames(datDS23t))
colnames(datDS23t) <- gsub(pattern = " ", replacement = "_", x = colnames(datDS23t))

#b)
datDS23t$koerpergroesse <- as.numeric(datDS23t$koerpergroesse)
data.class(datDS23t$koerpergroesse)
datDS23t$sport <- as.numeric(datDS23t$sport)
data.class(datDS23t$sport)
datDS23t$alter <- as.numeric(datDS23t$alter)
data.class(datDS23t$alter)

#c)
boplogroe <- boxplot(datDS23t$koerpergroesse)
print(boplogroe)

#d)
over190 <- c(datDS23t$koerpergroesse >190)
print(over190)
sum(over190, na.rm = TRUE) / length(over190)

#e)
mad(datDS23t$koerpergroesse, na.rm = TRUE)
#Standardabweichung:
sd(datDS23t$koerpergroesse, na.rm = TRUE)
#entspricht auch der Quadratwurzel der Varianz
sqrt(var(datDS23t$koerpergroesse, na.rm = TRUE))

#f)
medianbraun <- median(datDS23t$sport,
                      na.rm = TRUE,
                      datDS23t$haarfarbe == "braun")
medianelse <- median(datDS23t$sport,
                     na.rm = TRUE,
                     datDS23t$haarfarbe != "braun")
#Median ist genau gleich

#g)
vecg <- c(datDS23t$alter < 22
          & datDS23t$schlafzimmer == "1. Stock"
          & (datDS23t$haarfarbe == "blond"
             | datDS23t$anreisezeit_an_die_zhaw >= 50
             | datDS23t$handspanne > 20))
#(Klammer setzen LG stefan roth du huso)
sum(vecg, na.rm = TRUE)
posvecg <- which(vecg)
print(datDS23t[posvecg, ])

#h)
datDS23t$alter <- as.numeric(datDS23t$alter)
data.class(datDS23t$alter)
spann <- sd(datDS23t$alter, na.rm = TRUE)
stichiqr <- IQR(datDS23t$alter, na.rm = TRUE)
stichmad <- mad(datDS23t$alter, na.rm = TRUE)

altermax <- max(datDS23t$alter, na.rm = TRUE)
altermin <- min(datDS23t$alter, na.rm = TRUE)
datDS23tnew <- datDS23t$alter
datDS23tnew <- sub(pattern = altermax, replacement = NA, x = datDS23tnew)
datDS23tnew <- sub(pattern = altermin, replacement = NA, x = datDS23tnew)

datDS23tnew <- as.numeric(datDS23tnew)

spann2 <- sd(datDS23tnew, na.rm = TRUE)
stichiqr2 <- IQR(datDS23tnew, na.rm = TRUE)
stichmad2 <- mad(datDS23tnew, na.rm = TRUE)

#mad ist unverändert, Spannweite und iqr veränder sich

altermax2 <- max(datDS23tnew, na.rm = TRUE)
altermin2 <- min(datDS23tnew, na.rm = TRUE)
datDS23tnew <- sub(pattern = altermax2, replacement = NA, x = datDS23tnew)
datDS23tnew <- sub(pattern = altermin2, replacement = NA, x = datDS23tnew)
datDS23tnew <- as.numeric(datDS23tnew)
stichmad4 <- mad(datDS23tnew, na.rm = TRUE)

#i)
rm(list = ls())

library(readxl)
datDS23t <- read_excel("C:/Users/jonas/OneDrive - ZHAW/Sem 1/ExpD/datDS23t.xlsx")

datDS23t$Antworten = NULL
colnames(datDS23t) <- gsub(pattern = "Q00_", replacement = "", x = colnames(datDS23t))
colnames(datDS23t) <- tolower(colnames(datDS23t))
colnames(datDS23t) <- gsub(pattern = " ", replacement = "_", x = colnames(datDS23t))

datDS23t$koerpergroesse <- as.numeric(datDS23t$koerpergroesse)
data.class(datDS23t$koerpergroesse)
datDS23t$sport <- as.numeric(datDS23t$sport)
data.class(datDS23t$sport)
datDS23t$alter <- as.numeric(datDS23t$alter)
data.class(datDS23t$alter)
datDS23t$handspanne <- as.numeric(datDS23t$handspanne)
data.class(datDS23t$handspanne)


datDS23t$ratHKgr <- ifelse(datDS23t$handspanne / datDS23t$koerpergroesse <= 0.11, "klein",
                           ifelse(datDS23t$handspanne / datDS23t$koerpergroesse > 0.11 &
                                    datDS23t$handspanne / datDS23t$koerpergroesse <= 0.12, "mittel", "gross"))
hk <- datDS23t$ratHKgr
hkklein <- sum(datDS23t$ratHKgr == "klein", na.rm = TRUE) / length(hk)
hkmittel <- sum(datDS23t$ratHKgr == "mittel", na.rm = TRUE) / length(hk)
hkgross <- sum(datDS23t$ratHKgr == "gross", na.rm = TRUE) / length(hk)
hkna <- 1 - (hkklein + hkmittel + hkgross)

#j) (han e besseri Idee)
datDS23t$ID <- seq(from = 1, to = 25, by = 1)

#k)
filepath <- "C:\\Users\\jonas\\OneDrive - ZHAW\\Sem 1\\ExpD\\datDS23t_bratsjon_W4.csv"
write.csv(datDS23t, filepath, row.names = FALSE)
