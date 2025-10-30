# Aufgabe 1
# a)

binom.test(x = 35, n = 487, conf.level=0.95)$conf.int

# b)

binom.test(x = 2, n = 44, conf.level=0.9)$conf.int


# Aufgabe 2
# a)

poisson.test(x = 62, T = 1, conf.level = 0.95)$conf.int

# b)

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/asbestos.RData")

poisson.test(x = sum(asbestos), T = length(asbestos), conf.level = 0.99)$conf.int


# Aufgabe 3
# a)

# Load galaxies from R-dataset MASS
library(MASS)
data(galaxies)

median(galaxies)
bootRes <- boot(galaxies, function(z, ind) median(z[ind]), R = 5000)
bootRes
plot(bootRes)
boot.ci(bootRes, type = c("perc", "bca"))

# b)

QDK <- function(d,i){
  dat <- d[i]
  return( ( quantile(dat,0.75)- quantile(dat,0.25) ) / quantile(dat,0.5) )
}

bootRes_QDK <- boot(galaxies, QDK, R = 5000)
bootRes_QDK
plot(bootRes_QDK)
boot.ci(bootRes, type = c("perc", "bca"), conf = 0.99)


# Aufgabe 4
# a)

load("/Users/jonas/Documents/GitHub/ZHAW/Semester 5/GStat/Daten/spatial.RData")

cor(spatial$A, spatial$B)
plot(spatial$A, spatial$B)
abline(lm(spatial$B ~ spatial$A), col = "red", lwd = 2)
text(x = min(spatial$A), y = max(spatial$B),
     labels = paste("Korrelationskoeffizient: ",
                    round(cor(spatial$A, spatial$B), 3)), pos = 4)

# b)



