library(tidyverse)

pop_raw <- read_csv("data/original/population.csv")


pop_clean <- pop_raw %>%
  rename(
    country = Entity,
    year = Year,
    population = `all years`
  ) %>%
  filter(year >= 1990 & year <= 2023) %>%
  mutate(
    country = tolower(country),
    year = as.integer(year)
  )
pop_clean <- pop_clean %>%
  arrange(year, country)


head(pop_clean)


write_csv(pop_clean, "data/cleaned/population.csv")


