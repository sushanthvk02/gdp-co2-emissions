library(tidyverse)

df <- read_csv("gdp_co2_data.csv")

# Summary for GDP
gdp_summary <- df %>%
  summarise(
    min_gdp = min(gdp, na.rm = TRUE),
    max_gdp = max(gdp, na.rm = TRUE),
    mean_gdp = mean(gdp, na.rm = TRUE),
    median_gdp = median(gdp, na.rm = TRUE)
  )

# Summary for CO2 Emissions
co2_summary <- df %>%
  summarise(
    min_co2 = min(co2_emissions, na.rm = TRUE),
    max_co2 = max(co2_emissions, na.rm = TRUE),
    mean_co2 = mean(co2_emissions, na.rm = TRUE),
    median_co2 = median(co2_emissions, na.rm = TRUE)
  )

# Print summaries
print(gdp_summary)
print(co2_summary)
