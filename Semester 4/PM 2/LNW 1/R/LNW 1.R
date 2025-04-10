library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)


# set working directory to current file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Korrigieren der csv Datei

## Lese die CSV als Textzeilen ein
lines <- readLines("ugz_luftqualitaetsmessung_seit-2012.csv")

## Ersetze in allen Zeilen das fehlerhafte Muster durch einen Zeilenumbruch
corrected_lines <- gsub("(\\d{2}\\.\\d{2})(\\d{4}-\\d{2}-\\d{2})", "\\1\n\\2", lines)

## Falls in einem Element mehrere Zeilen enthalten sind, splitte sie in separate Elemente
fixed_lines <- unlist(strsplit(corrected_lines, "\n"))

## Speichere die korrigierte Datei
writeLines(fixed_lines, "corrected_data.csv")


# Importieren der korrigierten Datei und Bereinigung des Tabellenformats

## Using readr to import with all columns as character
data <- read_csv("corrected_data.csv",
                 col_names = FALSE,
                 col_types = cols(.default = col_character()))


## Extract and clean the first column
standort <- data[1,] %>% unlist()|>
  str_replace_all("Zürich ", "") |>   # Remove "Zürich "
  tolower() |>                        # Convert to lowercase
  str_replace_all("strasse", "")  |>  # Remove "strasse"
  str_replace_all(c("ä" = "ae", "ö" = "oe", "ü" = "ue", "Ä" = "Ae", "Ö" = "Oe", "Ü" = "Ue")) |> # Replace umlauts
  unique()                           # Keep only unique values

## unique standort
standort_unique <- unique(standort[-1])


einheiten <- data[4,] |>           # Extract the fourth row and convert to a vector
  tolower() |>                      # Convert to lowercase
  str_replace_all(">", "gt") |>     # Replace ">" with "gt"
  replace_na("")                    # Replace NA with ""

## Combine column names with units and rename first element to "datum"
new_colnames <- paste(standort, einheiten, sep = "-") |>
  replace(1, "datum")

## Remove unnecessary rows (1-6)
data <- data[-c(1:6),]

## Insert new_rownames [,1]
colnames(data) <- new_colnames

## Pivot the data
data_long <- data %>%
  pivot_longer(
    cols = -datum, # Keep the 'datum' column as is
    names_to = c("standort", "variable"), # Split column names into 'location' and 'variable'
    names_sep = "-" # Separate location and variable by minus
  ) %>%
  pivot_wider(
    names_from = variable, # Use 'variable' to create new columns
    values_from = value # Fill the new columns with 'value'
  ) |>
  mutate(across(everything(), ~na_if(., "NaN"))) # Replace "NaN" with NA

## change data types
data_long <- data_long |>
  mutate(standort = factor(standort, levels = standort_unique)) |> # Change 'standort' to factor
  mutate(across(3:15, as.numeric)) |> # Change columns 3 to 15 to numeric
  mutate(datum = as.Date(datum, format = "%Y-%m-%d")) # Change 'datum' to date

## data types data_long
str(data_long)


# Erweiterung des Datensatzes


## Neue Spalten für Jahr, Monat und Wochentag hinzufügen
monate <- c("Jan", "Feb", "Mar", "Apr", "Mai", "Jun", 
            "Jul", "Aug", "Sep", "Okt", "Nov", "Dez")
wochentage <- c("Mo", "Di", "Mi", "Do", "Fr", "Sa", "So")

## Datentransformation
data_long <- data_long |> 
  mutate(
    datum = as.Date(datum),
    jahr = year(datum),
    monat = factor(
      monate[month(datum)],
      levels = monate,
      ordered = TRUE
    ),
    wochentag = factor(
      wochentage[wday(datum, week_start = 1)],
      levels = wochentage,
      ordered = TRUE
    )
  )

## Kontrolle der neuen Spalten
str(data_long)


# Visualisierung

## Plot 1

'
Stellen Sie in einem Scatterplot für den Standort Stampfenbachstrasse die Messgrössen
Globalstrahlung (y-Achse) und die maximale Ozonkonzentration während einer Stunde (xAchse) dar. Legen Sie zudem einen Glätter in die Grafik. Schauen Sie das beide Achsen
verständlich beschriftet sind und vergessen Sie die Bildunterschrift nicht. Ein Titel ist nicht
notwendig.
'

data_long %>%
  filter(standort == "stampfenbach") %>%
  drop_na(o3_max_h1, strglo) %>%
  ggplot(aes(x = o3_max_h1, y = strglo)) +
  geom_point() +
  geom_smooth() +
  labs(
    x = "Maximale Ozonkonzentration während einer Stunde [µg/m³]",
    y = "Globalstrahlung [W/m²]",
  )

Bildunterschrift

data_long %>%
  filter(standort == "stampfenbach") %>%
  drop_na(o3_max_h1, strglo) %>%
  ggplot(aes(x = o3_max_h1, y = strglo)) +
  geom_point(alpha = 0.3) +  # Added alpha parameter for transparency
  geom_smooth() +
  labs(
    x = "Maximale Ozonkonzentration während einer Stunde [µg/m³]",
    y = "Globalstrahlung [W/m²]",
  )

## Plot 2

'
Stellen Sie den Verlauf der Stickoxidkonzentration (NOx = NO + NO2) über den gesamten
Zeitraum gemeinsam für die Standorte Schimmelstrasse und Heubeeribüel dar. Achten sie
darauf, dass der zeitliche Verlauf der für beide Standorte gut erkennbar ist, beide Achsen
und die Legende (innerhalb der Grafik plaziert) verständlich beschriftet sind und vergessen
Sie die Bildunterschrift nicht. Die Grafik braucht keinen Titel.
'

data_long$nox <- data_long$no + data_long$no2
data_long %>%
  filter(standort == "schimmel" | standort == "heubeeribueel") %>%
  ggplot(aes(x = datum, y = nox, color = standort)) +
  geom_line() +
  scale_color_manual(
    values = c("schimmel" = "brown3", "heubeeribueel" = "lightskyblue"),
    labels = c("schimmel" = "Schimmelstrasse", "heubeeribueel" = "Heubeeribüel")
  ) +
  labs(
    x = "Datum",
    y = "Stickoxidkonzentration (NO + NO2) [µg/m³]",
    color = "Standort"
  ) +
  theme(legend.position = "bottom")

Bildunterschrift

## Plot 3

'
Stellen Sie die Streuung der PM10 Konzentration an der Rosengartenstrasse pro Wochentag
dar. Schauen Sie, dass beide Achsen verständlich beschriftet sind und vergessen Sie die
Bildunterschrift nicht. Die Grafik braucht keinen Titel.
'

data_long %>%
  filter(standort == "rosengarten", !is.na(pm10)) %>%
  ggplot(aes(x = wochentag, y = pm10)) +
  geom_boxplot() +
  scale_y_log10() +  # fügt logarithmische Skala hinzu
  labs(
    x = "Wochentag",
    y = "PM10 Konzentration [µg/m³] (log-Skala)"
  )

Bildunterschrift

## Plot 4

'
Stellen Sie den zeitlichen Verlauf der Stickoxidkonzentration an allen vier Stationen von 2012-
2020 für jeden Monat dar. In der Abbildung sollte der mittlere Verlauf und die Streuung der
Monate für alle Jahre ersichtlich sein. Schauen Sie, dass beide Achsen verständlich beschriftet
sind und vergessen Sie die Bildunterschrift nicht. Die Grafik braucht keinen Titel.
'

data_long %>%
  mutate(
    datum = as.Date(datum),
    standort = str_to_title(standort)
  ) %>%
  filter(datum >= as.Date("2014-01-01") & datum <= as.Date("2020-12-31")) %>%
  ggplot(aes(x = datum, y = nox, fill = standort)) +  # fill = standort wieder hinzugefügt
  # Boxplots für jeden Monat und Standort
  geom_boxplot(
    aes(group = format(datum, "%Y-%m")), 
    outlier.size = 0.5, 
    alpha = 0.7
  ) +
  # Achsenbeschriftungen
  labs(
    x = "Jahr",
    y = "Stickoxidkonzentration (NO + NO2) [µg/m³] (log-Skala)"
  ) +
  # Zeitachse formatieren - nur Jahreszahlen
  scale_x_date(
    date_breaks = "1 year",
    date_labels = "%Y",
    expand = expansion(mult = 0.02)
  ) +
  # Logarithmische y-Achse
  scale_y_log10() +
  # Facetten für jeden Standort untereinander
  facet_wrap(~standort, ncol = 1) +
  # Minimalistisches Theme
  theme_minimal() +
  theme(
    legend.position = "none",  # Legende ausgeblendet
    axis.text.x = element_text(angle = 0, hjust = 0.5)
  )





