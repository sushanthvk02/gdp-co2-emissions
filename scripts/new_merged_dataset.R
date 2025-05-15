library(tidyverse)

pop <- read_csv("data/cleaned/population.csv") 
df <- read_csv("gdp_co2_data.csv")

setdiff(df$country, pop$country)

df_final <- df %>%
  left_join(pop, by = c("country", "year"))

df_final


sum(is.na(df_final$population))

df_new <- df_final %>%
  filter(!is.na(population))

sum(is.na(df_new$population))


write_csv(df_new, "data/final/gdp_co2_population_data.csv")
write_csv(df_new, "gdp_co2_population_data.csv")
