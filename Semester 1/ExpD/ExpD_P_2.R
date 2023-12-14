w <- c(1:5, 2)
x <- c(6:13)/3
y <- c(TRUE, FALSE, TRUE, TRUE)
z <- c("Marie", "Betty", "Peter", "Peter")
z_f <- as.factor(z)

typeof(w)
typeof(x)
typeof(y)
typeof(z)
typeof(z_f)

#Aufgabe 1b)
u <- (w <= 2)
u
mode(u)
as.numeric(u)
as.character(u)
as.character(z_f)
as.numeric(z_f)
as.numeric(z)
unique(z_f)
unique(w)
?unique


#Aufgabe 2a)
Vec1<-c(seq(from=95, to=-5, by=-5))
Vec1

Vec2<-c(letters, letters)
Vec2<-sort(Vec2)

Vec3<-c(1:10)
rep(1:10, Vec3)

#Aufgabe 2b)

MatVal<-c(seq(from=3, to=75, by=3))
Mat<-matrix(MatVal, nrow=5, ncol=5, byrow=TRUE)
Mat

#Aufgabe 3

Name<-c("Ruedi", "Hans", "Peter", "Stefan", "Julia", "Maria")
Alter<-c(27, 34, 21, 25, 29, 23)
Note<-c(5.0, 6.0, 5.5, 4.0, 3.5, 5.0)
Studium<-c(FALSE, TRUE, TRUE, TRUE, FALSE, TRUE)

dat<-data.frame(Name, Alter, Note, Studium)

nrow(dat)*ncol(dat)

sapply(dat, typeof)

Studiumchr<-Studium

tableStudium<-table(dat$Studium)
pie(tableStudium)
barplot(tableStudium)


#Aufgabe 4

dat<-readRDS("C:\\Users\\jonas\\OneDrive - ZHAW\\Sem 1\\ExpD\\datDS23t_raw.rds")

head(dat)    
dim(dat)
sapply(dat, typeof)

tableHaar<-table(dat$Q00_Haarfarbe)
tableHaar
tableHaarPro<-tableHaar
tableHaarPro<-tableHaarPro / length(dat$Q00_Haarfarbe)

round(tableHaarPro, digits = 2)

pie(tableHaarPro, col = col)

col<-c("yellow", "burlywood4", "black")

tableStockwerk<-table(dat$Q00_Schlafzimmer)
barplot(tableStockwerk, 
        main = "Stockwerk des Schlafzimmers", 
        ylab = "Stockwerk", 
        col = col, 
        las=2)
tablePost<-table(dat$Q00_Postleitzahl)
barplot(tablePost,
        las=2, 
        cex.names = 0.8,
        col = col2)


col2<-c("grey", "blue")
