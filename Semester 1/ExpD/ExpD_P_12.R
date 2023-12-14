# Aufgabe 1

radius <- function(r){
  area <- (r^2)*pi
  circumference <- 2*r*pi
  return(c(area, circumference))
}
radius(5)

mittelwert <- function(vec) {
  vec <- na.omit(vec)
  len <- length(vec)
  avg <- sum(vec) / len
  return(avg)
}


v_a <- 1:100
v_b <- 3
v_c <- c(2, 4, 5, NA, 6)

mittelwert(v_a)
mittelwert(v_b)
mittelwert(v_c)

mean(v_a)
mean(v_b)
mean(v_c)

# Aufgabe 2 (Notenauswertung)


library(readr)
NotenSek3_SO_naturlehre <- read_delim("~/GitHub/ZHAW/Semester 1/ExpD/Grundlagen/NotenSek3-SO-naturlehre.csv", 
                                      delim = ";", escape_double = FALSE, col_names = FALSE, 
                                      trim_ws = TRUE)
NotenSek3_SO_mathematik <- read_delim("~/GitHub/ZHAW/Semester 1/ExpD/Grundlagen/NotenSek3-SO-mathematik.csv", 
                                      delim = ";", escape_double = FALSE, col_names = FALSE, 
                                      trim_ws = TRUE)
NotenSek3_SO_franzoesisch <- read_delim("~/GitHub/ZHAW/Semester 1/ExpD/Grundlagen/NotenSek3-SO-franzoesisch.csv", 
                                        delim = ";", escape_double = FALSE, col_names = FALSE, 
                                        trim_ws = TRUE)
NotenSek3_SO_englisch <- read_delim("~/GitHub/ZHAW/Semester 1/ExpD/Grundlagen/NotenSek3-SO-englisch.csv", 
                                    delim = ";", escape_double = FALSE, col_names = FALSE, 
                                    trim_ws = TRUE)

new_colnames <- c("Namen", "p1", "p2", "p3", "p4", "p5", "p6", "p7")
colnames(NotenSek3_SO_englisch) <- new_colnames
colnames(NotenSek3_SO_mathematik) <- new_colnames
colnames(NotenSek3_SO_naturlehre) <- new_colnames
colnames(NotenSek3_SO_franzoesisch) <- new_colnames

sapply(NotenSek3_SO_englisch, length)
sapply(NotenSek3_SO_mathematik, length)
sapply(NotenSek3_SO_naturlehre, length)
sapply(NotenSek3_SO_franzoesisch, length)

eng <- NotenSek3_SO_englisch[order(NotenSek3_SO_englisch$Namen), ]
math <- NotenSek3_SO_mathematik[order(NotenSek3_SO_mathematik$Namen), ]
nat <- NotenSek3_SO_naturlehre[order(NotenSek3_SO_naturlehre$Namen), ]
fran <- NotenSek3_SO_franzoesisch[order(NotenSek3_SO_franzoesisch$Namen), ]

fnamen <- function(dataframe){
  namen <- dataframe$Namen
  return(namen)
}

namen_eng <- fnamen(eng)
namen_math <- fnamen(math)
namen_nat <- fnamen(nat)
namen_fran <- fnamen(fran)

length(namen_eng == namen_fran)
length(namen_eng == namen_math)
length(namen_eng == namen_nat)

sapply(eng, rowMeans(x = p1 ~ p7, na.rm = TRUE))









