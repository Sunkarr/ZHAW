# Afugabe 1
dia <- diamonds
library(ggplot2)
ggplot(data = dia, mapping = aes(x = price, y = carat, color = color, shape = cut)) +
  geom_point() +
  theme_minimal()

