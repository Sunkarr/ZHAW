# Aufgabe 1
library(readr)
imports85 <- read_table("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/imports85.txt")
View(imports85)

imports85$cyl <- factor(imports85$cyl, levels = c("two", "three", "four", "five", "six"))
table <- table(imports85$wheels, imports85$cyl)
print(table)
mosaicplot(table)

barplot(table, beside = TRUE)
barplot(table, beside = FALSE)

boxplot(imports85$price ~ imports85$cyl)

# Aufgabe 2
library(readxl)
datDS23t <- read_excel("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/datDS23t.xlsx")
View(datDS23t)

quantile(datDS23t$anreisezeit_an_die_zhaw, 
         probs = 0.75,
         na.rm = TRUE)

quantile(datDS23t$anreisezeit_an_die_zhaw, 
         probs = 0.9,
         na.rm = TRUE)

mosaicplot(datDS23t$geschlecht ~ datDS23t$programmierkenntnisse)

plot(datDS23t$alter ~ datDS23t$koerpergroesse)
