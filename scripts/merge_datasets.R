library(tidyverse)

# Load cleaned GDP and CO2 datasets
gdp <- read_csv("data/cleaned/gdp.csv")      
co2 <- read_csv("data/cleaned/co2_emissions.csv")  

# Standardize country names
gdp <- gdp %>%
  mutate(country = str_to_lower(country))

co2 <- co2 %>%
  mutate(country = str_to_lower(country))

# Inner join on 'country' and 'year'
merged_data <- inner_join(gdp, co2, by = c("country", "year"))

# Save the merged dataset
write_csv(merged_data, "data/cleaned/merged_dataset.csv")

head(final_data)
