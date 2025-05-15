library(tidyverse)

df <- read_csv("gdp_co2_population_data.csv")

summary_table <- tibble(
  Variable = c("GDP", "CO₂ Emissions", "Population"),
  Min = c(min(df$gdp, na.rm = TRUE),
          min(df$co2_emissions, na.rm = TRUE),
          min(df$population, na.rm = TRUE)),
  Max = c(max(df$gdp, na.rm = TRUE),
          max(df$co2_emissions, na.rm = TRUE),
          max(df$population, na.rm = TRUE)),
  Mean = c(mean(df$gdp, na.rm = TRUE),
           mean(df$co2_emissions, na.rm = TRUE),
           mean(df$population, na.rm = TRUE)),
  Median = c(median(df$gdp, na.rm = TRUE),
             median(df$co2_emissions, na.rm = TRUE),
             median(df$population, na.rm = TRUE))
)

print(summary_table)

write_csv(summary_table, "tables/summary_statistics.csv")

