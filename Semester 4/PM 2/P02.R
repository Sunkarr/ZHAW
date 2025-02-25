library(stringr)

# Aufgabe 2
# Generieren Sie aus dem Zeichenkettenvektor words einen String in dem die einzelnen Wörter
# ohne Trennzeichen vorkommen und einmal durch das Trennzeichen + verbunden sind.

x <- words
x <- str_c(c, collapse = "+")

# Finden sie alle Wörter im Vektor words . . .

# die mit einem Vokal beginnen.
str_subset(words, "^[aeiou]")

# die nur Konsonanten enthalten (Tipp: Denken Sie an passende “nicht”-Vokale).
str_subset(words, "^[^aeiou]+$")

# ending on ed but not on eed
str_subset(words, "ed$") %>% str_subset("eed$", negate = TRUE)

# ending with ing or ise
str_subset(words, "ing$|ise$")

# a = word group containing cei or ie without c before
str_subset(words, "cei|ie") %>% str_subset("cie", negate = TRUE)
# b = word group containing cie or ei without c before
str_subset(words, "cie|ei") %>% str_subset("cie", negate = TRUE)

# Any word containing q but not qu
str_subset(words, "q") %>% str_subset("qu", negate = TRUE)
# Any word containing q
str_subset(words, "q")


imdb_urls <- c(
  "https://www.imdb.com/title/tt6751668/?ref_=hm_fanfav_tt_4_pd_fp1",
  "https://www.imdb.com/title/tt0260991/",
  "www.imdb.com/title/tt7282468/reviews",
  "https://m.imdb.com/title/tt4768776/"
)

# Extract the movie id from the urls
str_extract(imdb_urls, "tt[0-9]+")


# Aufgab2 3

library(tidyverse)

filenames <- c( 'S123.P2.C10_20120621_213422.jpg',
                'S10.P1.C1_20120622_050148.jpg',
                'S187.P2.C2_20120702_023501.jpg')

# Create a tibble with the columns site, plot, camera, year, month, day, hour, minute, second
# and the values extracted from the filenames

# Regex pattern to capture Site, Plot, Camera, Date and Time
pattern <- "(S\\d+)\\.(P\\d+)\\.(C\\d+)_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})([0-9]{2})"

# Extract data with str_match
matched <- str_match(filenames, pattern)

# Convert to tibble and clean up
result <- tibble(
  Site = matched[, 2],
  Plot = matched[, 3],
  Camera = matched[, 4],
  Year = as.integer(matched[, 5]),
  Month = as.integer(matched[, 6]),
  Day = as.integer(matched[, 7]),
  Hour = as.integer(matched[, 8]),
  Minute = as.integer(matched[, 9]),
  Second = as.integer(matched[, 10])
)

print(result)


# Aufgabe 4

library(readxl)
library(janitor)
path <- "/Users/jonas/Library/CloudStorage/OneDrive-ZHAW/Sem 4/PM 2/data/bad-table-psych.xlsx"
dat <- read_excel(path, skip = 2, n_max = 12)

clean_names(dat)


# Aufgabe 5

adressen = c(
  "Platz der Republik 1, D-11011 Berlin",
  "Dr.-Karl-Renner-Ring 3, A-1017 Wien",
  "Bundesplatz 3, CH-3005 Bern"
)

# Extract street name without number, remove last space
str_extract(adressen, "^[^0-9]+") %>% str_replace(" $", "")

# Extract house number
str_extract(adressen, "[0-9]+")

# Extract postal code
str_extract(adressen, "[0-9]{4,5}")

# Extract city (the last word)
str_extract(adressen, "[^ ]+$")

# Extract country shortcut (1-2 characters before postal code), without -
str_extract(adressen, "[A-Z]{1,2}(?=-[0-9]{4,5})")

# now i want to do every of those steps in one regex
pattern <- "([^0-9]+) ([0-9]+), ([A-Z]{1,2})-?([0-9]{4,5}) ([^ ]+)$"
matched <- str_match(adressen, pattern)
print(matched)


# Aufgabe 6

install.packages("babynames")
library(babynames)
library(dplyr)

babynames <- babynames

# Group by sex and summarize
babynames |>
  group_by(sex) |>
  summarize(
    total = sum(n),
    mean = mean(n),
    median = median(n),
    min = min(n),
    max = max(n)
  )

# Count the number of the name "shine"
babynames |>
  filter(name == "Shine") |>
  summarize(
    total = sum(n)
  )

# Count the number of names with exactly four vocals
babynames |>
  filter(str_count(name, "[aeiou]") == 4) |>
  summarize(
    total = sum(n)
  )


