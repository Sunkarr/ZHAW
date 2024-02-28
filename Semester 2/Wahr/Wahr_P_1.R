# Installiere das tidyverse-Paket, falls es noch nicht installiert ist
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}

# Lade das tidyverse-Paket
library(tidyverse)

# Funktion zum Würfeln und DataFrame aktualisieren
wuerfelfunktion <- function() {
  # Würfeln mit drei sechsseitigen Würfeln
  wurf_resultate <- sample(1:6, 3, replace = TRUE)
  
  # Erstelle einen DataFrame oder benutze einen bestehenden
  if (!exists("ergebnis_dataframe")) {
    ergebnis_dataframe <- data.frame(Wurf1 = wurf_resultate[1],
                                     Wurf2 = wurf_resultate[2],
                                     Wurf3 = wurf_resultate[3])
  } else {
    neuer_datensatz <- data.frame(Wurf1 = wurf_resultate[1],
                                  Wurf2 = wurf_resultate[2],
                                  Wurf3 = wurf_resultate[3])
    ergebnis_dataframe <- bind_rows(ergebnis_dataframe, neuer_datensatz)
  }
  
  return(ergebnis_dataframe)
}

# Tausendmal würfeln und DataFrame aktualisieren
set.seed(123)  # Setze einen Seed für reproduzierbare Ergebnisse
for (i in 1:1000) {
  ergebnis_dataframe <- wuerfelfunktion()
}

# Ausgabe der ersten Zeilen des DataFrames
head(ergebnis_dataframe)

# Füge eine neue Spalte hinzu, um zu überprüfen, ob eine 4 vorhanden ist
ergebnis_dataframe$EnthaeltVier <- apply(ergebnis_dataframe, 1, function(x) any(x == 4))

# Erstelle einen Barplot
barplot(table(ergebnis_dataframe$EnthaeltVier), 
        col = c("red", "green"),
        main = "Enthält Zeile eine 4?",
        xlab = "Enthält 4",
        ylab = "Anzahl",
        names.arg = c("Nein", "Ja"))

