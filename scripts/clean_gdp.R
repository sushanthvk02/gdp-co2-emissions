library(tidyverse)

gdp_raw <- read_csv("data/original/gdp.csv", skip = 4)

head(gdp_raw)

# Select only necessary columns
gdp_clean <- gdp_raw %>%
  select('Country Name', c(7:ncol(gdp_raw) - 2))

head(gdp_clean)
colnames(gdp_clean)

# Reshape the data to long format
gdp_long <- gdp_clean %>%
  pivot_longer(
    cols = -`Country Name`,   
    names_to = "year",    
    values_to = "gdp"     
  ) %>%
  rename(country = `Country Name`) %>%  
  mutate(
    year = as.integer(year),           # Ensure year is numeric
    gdp = as.numeric(gdp)               # Ensure GDP is numeric
  ) %>%
  filter(year >= 1990 & year <= 2023) %>%
  select(country, year, gdp) %>%        
  arrange(year, country)                # Sort the data first by Year, then Country



# Save the cleaned long-format GDP dataset
write_csv(gdp_long, "data/cleaned/gdp.csv")

head(gdp_long)

