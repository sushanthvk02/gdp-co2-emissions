library(tidyverse)

# Load your merged dataset
final_data <- read_csv("data/cleaned/merged_dataset.csv")

# Check missing counts by Country
missing_by_country <- final_data %>%
  group_by(country) %>%
  summarise(
    missing_gdp = sum(is.na(gdp)),
    missing_co2 = sum(is.na(co2_emissions)),
    total_missing = missing_gdp + missing_co2
  ) %>%
  arrange(desc(total_missing))
print(missing_by_country)

# Check missing counts by Year
missing_by_year <- final_data %>%
  group_by(year) %>%
  summarise(
    missing_gdp = sum(is.na(gdp)),
    missing_co2 = sum(is.na(co2_emissions)),
    total_missing = missing_gdp + missing_co2
  ) %>%
  arrange(desc(total_missing))
print(missing_by_year)

# Drop rows where either GDP or CO2_Emissions is missing
final_data_filtered <- final_data %>%
  drop_na(gdp, co2_emissions)


# Save the final cleaned dataset
write_csv(final_data_filtered, "data/final/gdp_co2_data.csv")
write_csv(final_data_filtered, "gdp_co2_data.csv")
