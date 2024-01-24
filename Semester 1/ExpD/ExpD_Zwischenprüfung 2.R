sort(table(TR$age))

bew4.5 <- TR$eval > 4.5
sum(bew4.5)

x <- TR$native == "yes" & TR$tenure == "yes"
sum(x)

prop.table(table(x))


CS$price_diff <- CS$Price - CS$CompPrice
hist(CS$price_diff)

CS$price_diff_fct <- cut(CS$price_diff, c(seq(-60, 60, 20)))
barplot(table(CS$price_diff_fct))

plot(CS$Sales ~ CS$price_diff_fct)


read.table()