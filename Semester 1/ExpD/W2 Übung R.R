Hobbies = c("Fussball", "Fussball", "Fussball", "Fussball", "Fussball", "Backen", "Backen", "Shoppen", "Surfen", "Surfen", "Surfen", "Surfen", "Surfen", "Surfen", "Surfen", "Lesen", "Lesen", "Lesen", "Gitarre", "Gitarre", "Gitarre", "Gitarre")

table(Hobbies)

table(Hobbies)/length(Hobbies)

barplot(sort(table(Hobbies), decreasing=TRUE))

pie(table(Hobbies))

  
      