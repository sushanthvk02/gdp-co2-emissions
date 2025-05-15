library(tidyverse)
library(broom)    

df <- read_csv("gdp_co2_population_data.csv")

df_log <- df %>%
  mutate(
    log_gdp = log(gdp),
    log_co2 = log(co2_emissions),
    log_population = log(population)
  ) %>%
  drop_na(log_gdp, log_co2, log_population)

# Simple Model
model_simple <- lm(co2_emissions ~ gdp, data = df)
simple_coefs <- tidy(model_simple)
summary(model_simple)

# Simple Log Model
model_log_simple <- lm(log_co2 ~ log_gdp, data = df_log)
simple_log_coefs <- tidy(model_log_simple)
summary(model_log_simple)

# Full Log Model
model_log_full <- lm(log_co2 ~ log_gdp + log_population, data = df_log)
full_log_coefs <- tidy(model_log_full)
summary(model_log_full)

write_csv(simple_coefs, "tables/simple_model_coefficients.csv")
write_csv(simple_log_coefs, "tables/simple_log_model_coefficients.csv")
write_csv(full_log_coefs, "tables/full_log_model_coefficients.csv")

# ANOVA table
anova(model_log_simple, model_log_full)
anova_table <- anova(model_log_simple, model_log_full) %>% 
  as_tibble(rownames = "Model_Comparison")

write_csv(anova_table, "tables/anova_model_comparison.csv")






