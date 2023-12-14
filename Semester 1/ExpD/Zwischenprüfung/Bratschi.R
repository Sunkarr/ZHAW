load("C:\\Users\\jonas\\OneDrive\\Dokumente\\GitHub\\ZHAW\\Semester 1\\ExpD\\Zwischenprüfung\\Dateien_fuer_ZP_HS23\\data_zp_hs23.rda")
library(readr)
lenses2 <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Zwischenprüfung/Dateien_fuer_ZP_HS23/lenses2.txt", 
                      delim = "*", escape_double = FALSE, trim_ws = TRUE)

nrow(TR)
barplot(sort(table(TR$age)))
hist(TR$eval, breaks = 4.5)
ecdf(TR$age)
mean(TR$eval[TR$gender == "male"])
mean(TR$eval[TR$gender == "female"])
x <- c(TR$native == "yes")
length(x)
length(x)/nrow(TR)
quantile(TR$age, .65)

pairs(CS$Sales ~ CS$Ersatz)

hist(CS$price_diff,
     ylab = "Anzahl Differenzen",
     xlab = "Differenz Angebotener Preis - Angebotener Preis Konkurenz")
mosaicplot(CS$US ~ CS$Urban,col = c("green", "orange"))

CS$price_diff_fct <- factor(CS$price_diff, levels = c(seq(-60, 60, 20)))
plot(CS$price_diff_fct ~ CS$Sales)
quantile(CS$Advertising, .9)

