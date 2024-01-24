library(MASS)
katzen <- cats

boxplot(katzen$Bwt ~ katzen$Sex)

katzem <- katzen$Sex == "M"
sum(katzem)
mean(katzen$Bwt[katzem])
median(katzen$Bwt[katzem])
sd(katzen$Bwt[katzem])
mad(katzen$Bwt[katzem])

katzew <- katzen$Sex == "F"
sum(katzew)
quantile(katzen$Bwt[katzew], 0.75)


GAGurine <- GAGurine

plot(GAGurine$Age ~ GAGurine$GAG)

cor(GAGurine$GAG, GAGurine$Age)
cor(GAGurine$GAG, GAGurine$Age, method = "spearman")

plot(GAGurine$GAG ~ GAGurine$Age, log = "y")


aids <- Aids2
barplot(table(aids$sex))

mosaicplot(aids$T.categ ~ aids$sex)

pairs(aids)


plot(wine)
r.pr <- prcomp(wine, scale = TRUE)
summary(prcomp(wine, scale = TRUE))
biplot(prcomp(wine, scale = TRUE))

install.packages("ggfortify")
library(ggfortify)
autoplot(prcomp(wine, scale = TRUE), scale = FALSE, loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3)


dat <- data.frame(custMat)

custDat <- data.frame(knr = dat$knr, artnr = gsub("artnr.", "", dat$artnr))

sapply(custDat, typeof)
custDat$artnr <- as.numeric(custDat$artnr)

custDat <- merge(custDat, prodNames, all.x = TRUE)

maxprod <- sort(table(custDat$product_name), decreasing = TRUE)
maxprod[1]


wirk <- impfstoff$wirksamkeit == "ja"
prop.table(table(impfstoff$alter, impfstoff$wirksamkeit))

prop.table(table(impfstoff$impfstoff, impfstoff$wirksamkeit), margin = 1)

prop.table(table(impfstoff$alter, impfstoff$wirksamkeit, impfstoff$impfstoff), margin = c(1,3))


install.packages("explore")
library(explore)
explore(Aids2)


