sort(table(cyber$State), decreasing = T)[1:3]

sapply(cyber$State, cyber$Affected, mean)

cyber$YearNumeric <- as.numeric(gsub("MMM_", "", cyber$MonthYear))

scatter.smooth(cyber$YearClean, cyber$Affected)
cor(cyber$YearClean, cyber$Affected, method = "spearman")

cyber2 <- cyber[cyber$Location %in% c("Laptop", "Desktop Computer", "Network Server"),]     

K <- 1.58 * (IQR(cyber2$Affected) / (length(cyber2$Affected))**0.5)
print(K)


prop.table(table(mean(Gigglezol$Lachwert), Gigglezol$Geschlecht, Gigglezol$Gruppe), margin = c(1,3))

table(Gigglezol$Gruppe, sum(Gigglezol$Lachwert))


gold_news$Forecast <- as.numeric(gold_news$Forecast)
gold_price$Price <- as.numeric(gold_price$Price)

gold_news$Date <- as.Date(gold_news$Date, format = "%m/%d/%y")
gold_price$Date <- as.Date(gold_price$Date, format = "%m/%d/%y")

sum(gold_news$Inflation_news)
gold_news_inf <- gold_news[gold_news$Inflation_news == TRUE, ]
gold_news_inf <- gold_news[tolower(gold_news$Inflation_news) %in% c("%inflation%"), ]

gold_merged <- merge(gold_news_inf, gold_price, by.x = "Date", all.x = TRUE)


prcomp(Siebenkampf[,5:11], scale. = TRUE)
biplot(prcomp(Siebenkampf[,5:11], scale. = TRUE))
summary(prcomp(Siebenkampf[,5:11], scale. = TRUE))


sum(Gigglezol$Lachwert[Gigglezol$Gruppe == "Treatment"])
sum(Gigglezol$Lachwert[Gigglezol$Gruppe == "Kontroll"])

boxplot(Gigglezol$Lachwert, Gigglezol$Gruppe, Gigglezol$Geschlecht)

apply(gold_merged[c(4,6),], MARGIN = 1, FUN = mean)

gold_merged[,c(4,6)]

apply(gold_merged[,c(4,6)], mean)
