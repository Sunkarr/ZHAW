# Aufgabe 1

library(MASS)
cats <- cats
?cats

View(cats)

# Zwei Boxplot von einer Variable nach Geschlechter
boxplot(Bwt~Sex, data=cats)

mcatshwt <- cats$Sex == "M"
mcatshwtdat <- cats[mcatshwt, ]

wcatshwt <- cats$Sex == "F"
wcatshwtdat <- cats[wcatshwt, ]
 
mean(mcatshwtdat$Bwt) # Lagemass
median(mcatshwtdat$Bwt) # Lagemass
sd(mcatshwtdat$Bwt) # Streuung
mad(mcatshwtdat$Bwt) # Streuung

quantile(wcatshwtdat$Bwt, 0.75)


# Gar nicht leichter, das Maximum liegt bei 3.9kg.
# Zwei Katzen haben das selbe maximalgewicht, dadurch würde sich der Median ändern sobald das Gewicht auch nur minimal änder würde.

# Aufgabe 2

GAG <- GAGurine
plot(GAG)

cor(GAG)
cor(GAG, method = "spearman") # Spearman ist sinnvoll, da Zusammenhang nicht linear

plot(GAG, log = "y")


# Aufgabe 3

aids <- Aids2
View(aids)
plot(aids$sex)

mosaicplot(T.categ ~ sex, data = aids)

table(aids$sex, aids$T.categ)

pairs(aids)


# Aufgabe 4

5000 + 0.0025*5500000
7750 + 0.002*5500000

5000 + 0.0025*3500000
7750 + 0.002*3500000

# Rechtsschief da Mittelwert über Median liegt

# Aufgabe 5

plot(wine)
apply(wine, 2,sd)
summary(prcomp(wine, scale. = TRUE))
screeplot(prcomp(wine, scale. = TRUE))

biplot(prcomp(wine,
              scale. = TRUE,
              main = NULL,
              sub = NULL))

# Aufgabe 6

dat <- data.frame(custMat)

artnr <- gsub("artnr.", "", dat$artnr)
dat <- data.frame(dat$knr, artnr)

dat$artnr <- as.integer(dat$artnr)
sapply(dat, typeof)

datmerged <- merge(dat, prodNames, by = "artnr")

f_rename_merge <- function(d1, d2, col) {
  artnr <- gsub("artnr.", "", table1$artnr)
  table1 <- data.frame(table1$knr, artnr)
  
  table1$artnr <- as.integer(table1$artnr)

  datmerged <- merge(table1, table2)
  
  maxprod <- max(dat$artnr)
  
  return(maxprod)
  
}

sort(table(dat$artnr), decreasing = TRUE)[1]


# Aufgabe 7

mosaicplot(impfstoff$wirksamkeit ~ impfstoff$alter)
# Unter 65 wirksamkeit grösser


mosaicplot(impfstoff$wirksamkeit ~ impfstoff$impfstoff)
# Impfstoff B hat die grössere Wirksamkeit

wirka <- c(impfstoff$wirksamkeit == "ja"
           & impfstoff$impfstoff == "A")
impfa <- c(impfstoff$impfstoff == "A")
100/sum(impfa)*sum(wirka)

wirkb <- c(impfstoff$wirksamkeit == "ja"
           & impfstoff$impfstoff == "B")
impfb <- c(impfstoff$impfstoff == "B")
100/sum(impfb)*sum(wirkb)

# Keinen Impfstoff

prop.table(table(impfstoff$alter, impfstoff$wirksamkeit), margin = 1)


