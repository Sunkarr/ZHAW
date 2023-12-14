# Aufgabe 2

library(readr)
censUSA <- read_delim("GitHub/ZHAW/Semester 1/ExpD/Grundlagen/censUSA.txt", 
                      delim = "\t", escape_double = FALSE, 
                      trim_ws = TRUE)
View(censUSA)

censUSA$education <- factor(gsub(" ", "", censUSA$education))

mosaicplot(censUSA$education ~ censUSA$occupation, censUSA=censUSA, las= 2,
           xlab = "education", ylab = "occupation",
           main = "education vs. occupation")

eduLev <- c("Preschool", "1st-4th", "5th-6th", "7th-8th", "9th",
            "10th", "11th", " 12th", "HS-grad", "Prof-school",
            "Assoc-acdm", "Assoc-voc", "Some-college", "Bachelors",
            "Masters", "Doctorate")
eduRedLev <- c(rep("easicEdu", 8), "HS-grad",
               "Prof-school-Doctorate", rep("Assoc-acdm-voc",2),
               "Some-college","Bachelors", "Masters", "Prof-school-Doctorate")
print(eduRedLev)
censUSA$eduRed <- factor(censUSA$education, levels = eduLev, labels =eduRedLev )
censUSA$eduRed <- factor(censUSA$eduRed,
                     levels = levels(censUSA$eduRed)[c(1:2, 4:7,3)])
occLevSort <- names(sort(table(censUSA$occupation)))
censUSA$occupation <-factor(censUSA$occupation, levels = occLevSort)
mosaicplot(censUSA$eduRed ~ censUSA$occupation, las= 2,
           xlab = "education", ylab = "occupation",
           main = "education vs. occupation")

# Aufgabe 3
nzz <- readRDS("C:\\Users\\jonas\\OneDrive\\Dokumente\\GitHub\\ZHAW\\Semester 1\\ExpD\\Grundlagen\\nzz.rds")
data.class(nzz)
words <- strsplit(nzz, " ")[[1]]
data.class(words)
length(words)

nzznew <- gsub("ä", "ae", nzz)
nzznew <- gsub("ö", "ee", nzz)
nzznew <- gsub("ü", "ue", nzz)

sentences <- unlist(strsplit(nzznew, "[.?!]"))




