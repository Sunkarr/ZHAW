cu <- c(7459.5, 7480.5, 7517.0, 7545.0, 7630.5,
            7660.5, 7685.5, 7708.0, 7710.0, 7740.0,
            7775.0, 7800.5, 7854.0, 7980.0, 8089.0, 
            8195.5, 8234.0, 8318.0, 8401.0, 8528.0)
which.min(cu)
which.max(cu)
cu[20]
breakhistcu <- c(seq(7250, (7250+(6*250)), 250))
hist(cu, breaks = breakhistcu)


verbrauch <- c(6.1, 7.2, 5.7, 5.0, 6.6, 4.0, 6.0, 7.5, 4.8, 5.8, 6.2)
boxplot(verbrauch)
quantile(verbrauch, c(0.25, 0.75))
median(verbrauch)
