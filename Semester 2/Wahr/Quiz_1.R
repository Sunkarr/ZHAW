nsim <- 1000000
count = 0
punkte = 0
totpunkte <- 0
probs <- c(rep(((100-22)/5), 5), 22)/100
würfel <- c(seq(1:6))
for (i in 1:nsim) {
  while (punkte < 48) {
    punkte = punkte + sample(1:6, size = 1, replace = TRUE,prob = probs)
    count = count + 1
  }
  punkte = 0
  totpunkte = totpunkte+ count
  count = 0
}

totpunkte / nsim


choose(42, 5) * choose(8,2)
























