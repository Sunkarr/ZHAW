library(readr)
library(dplyr)

# 1. Datei zeilenweise einlesen
lines <- read_lines("ugz_luftqualitaetsmessung_seit-2012.csv")

# 2. Die problematische Zeile 2959 anzeigen
cat("Problematische Zeile (original):\n", lines[2959], "\n")

# 3. Spezifisch für die Zeile 2959 das Muster "11.292020" durch "11.29,2020" ersetzen
lines[2959] <- gsub("11.292020", "11.29,2020", lines[2959])

# 4. Die korrigierte Zeile anzeigen
cat("Korrigierte Zeile:\n", lines[2959], "\n")

# 5. Die korrigierten Zeilen als CSV einlesen
dat <- paste(lines, collapse = "\n") %>%
  read_csv(
    locale = locale(encoding = "UTF-8"),
    na = c("", "NA", "N/A"),
    col_types = cols(.default = col_character())
  )

# 6. Überprüfen, ob das Problem behoben wurde
if(length(problems(dat)$row) > 0) {
  cat("Es gibt noch", length(problems(dat)$row), "Probleme.\n")
  print(problems(dat))
} else {
  cat("Alle Probleme wurden behoben!\n")
}

dat <- read_csv("test.csv")
library(readr)
test <- read_csv("test.csv")
View(test)
