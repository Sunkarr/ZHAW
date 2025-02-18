library(tidyverse)
library(dplyr)

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



