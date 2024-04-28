# Aufgabe 1

x <- 0:20
plot(x, pexp(x, 0.34), type = "l", lwd = 2)

pexp(1, 0.34)

pexp(5, 0.34) - pexp(4, 0.34)

n <- 100000
hist(rexp(n, 0.34) + rexp(n, 0.34) + rexp(n, 0.34), freq=F)
lines(0:40, dgamma(0:40, shape = 3, rate = 0.34), col = "blue", lwd = 2)


# Aufgabe 2

n <- 100000
kunden_wetter_schlecht <- rpois(n*0.4, 10)
kunden_wetter_gut <- rpois(n*0.6, 30)
kunden_total <- c(kunden_wetter_gut, kunden_wetter_schlecht)
hist(kunden_total, freq = F, breaks = 50)
abline(v = mean(kunden_total), col = "red", lwd = 2)
mean(kunden_total)

q <- 0.1
fixkosten_pro_tag <- -1000
q_zusatzkosten_pro_kunde <- -qunif(1-q, min = 20, max = 30)
q_einnahmen_pro_kunde <- 60 + qexp(q, 1/30)
umsatz_pro_tag <- numeric(n)
for (i in 1:n){
  umsatz_pro_tag[i] <- fixkosten_pro_tag + kunden_total[i]*q_zusatzkosten_pro_kunde + kunden_total[i]*q_einnahmen_pro_kunde
}
umsatz_pro_tag_immer_offen <- mean(umsatz_pro_tag)


umsatz_pro_tag <- numeric(n)
for (i in 1:length(kunden_wetter_gut)){
  umsatz_pro_tag[i] <- fixkosten_pro_tag + kunden_wetter_gut[i]*q_zusatzkosten_pro_kunde + kunden_wetter_gut[i]*q_einnahmen_pro_kunde
}
umsatz_pro_tag[umsatz_pro_tag == 0] <- -200
umsatz_pro_tag_nur_schön_wetter_offen <- mean(umsatz_pro_tag)



                                      