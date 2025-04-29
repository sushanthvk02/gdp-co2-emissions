library(tidyverse)

co2_raw <- read_csv("data/original/co2_emissions.csv")

# Clean as needed
co2_clean <- co2_raw %>%
  select(-Code) %>%  # Remove 'Code' column
  rename(
    country = Entity,
    year = Year,
    co2_emissions = `Annual CO₂ emissions`
  ) %>%
  mutate(
    year = as.integer(year),
    co2_emissions = as.numeric(co2_emissions) / 1e6  # Convert tonnes to million tonnes
  ) %>%
  filter(year >= 1990 & year <= 2023) %>%  # Filter only years 1990 to 2023
  arrange(year, country)

Save cleaned, filtered data
write_csv(co2_clean, "data/cleaned/co2_emissions.csv")

head(co2_clean)

