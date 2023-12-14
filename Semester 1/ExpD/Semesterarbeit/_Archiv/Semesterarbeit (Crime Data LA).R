library(readr)
datcrime <- read_csv("C:/Users/jonas/OneDrive - ZHAW/Sem 1/ExpD/Semesterarbeit/Crime_Data_from_2020_to_Present.csv")
View(datcrime)
colnames(datcrime) <- toupper(colnames(datcrime))
names(datcrime) <- gsub(pattern = " ", replacement = "_", x = names(datcrime))
# Histogram time occured
# Extract the 'TIME OCC' column and convert it to numeric
timeocc <- as.numeric(datcrime$TIME_OCC)

# Specify the breaks with 100-unit intervals from 0 to 2400
timeoccbreaks <- seq(0, 2400, by = 100)

# Create the histogram
histtimeocc <- hist(timeocc, 
                    breaks = timeoccbreaks,
                    freq = FALSE,
                    xlim = c(0, 2400), 
                    xlab = "Time", 
                    ylab = "Relative Frequency", 
                    main = "Distribution of Criminal Occurrences",
                    xaxt = "n")

# Rest of histogram customization
axis(1, at = timeoccbreaks, labels = timeoccbreaks, las = 2)

# Add median to the histogram
mediantime <- median(datcrime$TIME_OCC)
abline(v = mediantime, col = "red", lty = 1, lwd = 2)
legend("topright", legend = paste("Median =", mediantime), col = "red", lty = 1, lwd = 2)




# Age of victims
datcrime$VICT_AGE[datcrime$VICT_AGE == 0] <- NA
#plot(ecdf(datcrime$VICT_AGE),main = "Distribution ")
#boxplot(datcrime$VICT_AGE)


hist(datcrime$VICT_AGE, col = "lightblue", xlab = "Age [Years]",
     main = "Victims", ylab = "Density",
     las = 1, freq = FALSE)
median_age <- median(datcrime$VICT_AGE, na.rm = TRUE)
abline(v = median_age, col = "red", lty = 1, lwd = 2)
legend("topright", legend = paste("Median Age =", median_age), col = "red", lty = 1, lwd = 2)
