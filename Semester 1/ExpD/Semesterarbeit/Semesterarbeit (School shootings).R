library(readr)
dat <- read_csv("school-shootings-data.csv")
View(dat)

# Age of Shooter
vec_shooter_age <- c(dat$age_shooter1,dat$age_shooter2) 
vec_shooter_age <- na.exclude(vec_shooter_age)
View(vec_shooter_age)

hist(vec_shooter_age, col = "lightblue", xlab = "Age [Years]",
     main = "Shooter", ylab = "Density",
     breaks = c(seq(0, 80, by = 1)),
     las = 1, freq = FALSE)
axis(side=1, at=seq(0, 100, by=10))
median_age_shooter <- median(vec_shooter_age,na.rm = TRUE)
abline(v = median_age_shooter, col = "red", lty = 1, lwd = 2)
legend("top", legend = paste("Median =", median_age_shooter), col = "red", lty = 1, lwd = 2)

# Number schoolshootings
hist(dat$year,
     breaks = c(seq(1999, 2023)),
     main = "Number of school shootings in the US since 1999",
     xaxt = "n",
     xlab = "Years",
     col = "lightblue")
axis(side = 1, at = seq(1999, 2023, by = 1), las = 2)

meanshootings <- length(dat$year)/length(unique(dat$year))

# Median
mediantable <- table(dat$year)
medianshootings <- median(c(mediantable))

# Add Median and Legend to plot
abline(h = medianshootings, col = "red", lty = 1, lwd = 2)
legend("top", legend = paste("Median Shootings: ", round(medianshootings, 2)), col = "red", lty = 1, lwd = 2)
