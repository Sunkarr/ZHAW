library(tidyverse)
library(dplyr)
library(ggplot2)

# Aufgabe 1

load("/Users/jonas/Library/CloudStorage/OneDrive-ZHAW/Sem 4/PM 2/data/Uebung01/judgments.rda")

glimpse(judgments)

select(judgments, gender, age, condition)
select(judgments, ends_with("date"), contains("dilemma"))
select(judgments, where("is.character"))

judgments |>
  filter(between(mood_pre, 40, 60)) |>
  select(age, gender, condition, mood_pre, mood_post)

judgments |>
  select(gender, subject, age, contains("STAI")) |>
  filter(STAI_pre > 65 & STAI_post > 40) |>
  arrange(desc(STAI_pre)) |>
  relocate(subject, STAI_pre, STAI_post)

judgments |>
  mutate(mood_change = mood_post - mood_pre) |>
  relocate(starts_with("mood"))

judgments |>
   mutate(mood_pre_cat = case_when(
     mood_pre < 25 ~ "poor", # ~ = then
     mood_pre > 75 ~ "great",
     TRUE ~ "normal")) |> # sonst
   select(starts_with("mood")) |>
   arrange(desc(mood_pre)) |>
   relocate(mood_pre_cat)


judgments |>
  summarise(n_distinct(gender))

judgments |>
  group_by(condition, gender) |>
  summarise(n = n(), mAge = mean(age))

us_rent_income |>
  pivot_wider(names_from = variable, values_from =c(estimate, moe)) |>
  slice_head(n=3)

# Aufgabe 2

starwars <- as_tibble(starwars)

starwars |>
  select(starts_with("h") & contains("e"))

starwars |>
  select(where(is.integer) | ends_with("color"))

starwars |>
  mutate(class = case_when(
    height < 100 ~ "small", # ~ = then
    height > 200 ~ "big",
    TRUE ~ "medium"),
    class = factor(class,
                   levels = c("small", "medium", "big"),
                   ordered = T)) |> pull(class)

# Change any letter to uppercase
starwars |>
  mutate_if(is.character, toupper)

# Standardize all numeric columns
starwars |>
  mutate_if(is.numeric, scale)


# Aufgabe 3

dataPath <- "/Users/jonas/Library/CloudStorage/OneDrive-ZHAW/Sem 4/PM 2/data/Uebung01/exercises_fish.csv"
fish_df <- read_csv(file = dataPath,
                    col_types = cols(
                      salmon_id = col_integer(),
                      `common_name-size` = col_factor(),
                      variable = col_factor(),
                      value = col_double()))
fish_df |>
  separate(`common_name-size`, sep = " - ", into=c("name", "age"), remove=TRUE) |>
  pivot_wider(names_from = variable, values_from = value) -> fish_df

fish_df |>
  filter(name == "Steelhead") |>
  select(age, IGF1_ng_ml)

fish_df |>
  filter(str_starts(name,'S')) |>
  select( -IGF1_ng_ml) |>
  arrange(name, desc(length_mm))

fish_df |>
  group_by(age) |>
  filter(rank(length_mm) <= 5) |>
  summarise(mean_length = mean(length_mm),
            var_length = var(length_mm))

fish_df |>
  filter(age == "yearling") |>
  group_by(name) |>
  mutate(stan_length = scale(length_mm)) |>
  ggplot(aes(x = name, y = stan_length)) +
  geom_boxplot()


# Aufgabe 4

mtcars <- tibble::as_tibble(mtcars)

mtcars |>
  filter(hp < 100) |>
  summarise(count = n())

mtcars |>
  select(-c(gear, carb)) -> dat

dat |>
  arrange(desc(cyl), desc(hp)) -> dat

dat |>
  rename(power = hp) -> dat


