iris <- iris

library(ggplot2)

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species, size = Petal.Width)) +
  geom_point()

ggplot(data = iris, mapping = aes(x = Species)) +
  geom_bar()

ggplot(data = iris, mapping = aes(x = Sepal.Width, fill = "deeppink")) +
  geom_bar()

ggplot(data = iris, mapping = aes(x = Sepal.Width, fill = Species)) +
  geom_density(alpha = 0.2)

ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Width, fill = Species)) +
  geom_violin() +
  geom_jitter(color = 'black', alpha = 0.7, size = 3)






  
