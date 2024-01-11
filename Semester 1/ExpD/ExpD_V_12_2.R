library(readr)
zehnkampf_2021 <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/zehnkampf_2021.csv", 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(zehnkampf_2021)

boxplot(zehnkampf_2021[4:13])

apply(zehnkampf_2021[4:13], 2, sd)

prcomp(zehnkampf_2021[4:13], scale. = TRUE)

summary(prcomp(zehnkampf_2021[4:13], scale. = TRUE))

biplot(prcomp(zehnkampf_2021[4:13], scale. = TRUE, ))

screeplot(prcomp(zehnkampf_2021[4:13], scale. = TRUE), type = "line")



