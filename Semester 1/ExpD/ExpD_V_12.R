library(readr)
zehnkampf_2021 <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/zehnkampf_2021.csv", 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(zehnkampf_2021)

library(ggplot2)

# Aufgabe a)
boxplot(zehnkampf_2021[,4:13], log = "y")
apply(zehnkampf_2021[,4:13],MARGIN = 2 , FUN = sd )
biplot