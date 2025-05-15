library(tidyverse)

gdp <- read_csv("data/cleaned/gdp.csv")      
co2 <- read_csv("data/cleaned/co2_emissions.csv")  

gdp <- gdp %>%
  mutate(country = str_to_lower(country))

co2 <- co2 %>%
  mutate(country = str_to_lower(country))

merged_data <- inner_join(gdp, co2, by = c("country", "year"))
write_csv(merged_data, "data/cleaned/merged_dataset.csv")

head(final_data)
