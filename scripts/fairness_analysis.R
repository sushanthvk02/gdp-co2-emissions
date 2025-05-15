library(tidyverse)
library(ggplot2)

df <- read_csv("gdp_co2_population_data.csv")
df <- df %>%
  mutate(
    gdp_per_capita = gdp / population,
    co2_per_capita = co2_emissions / population
  )

df <- df %>%
  mutate(
    income_group = case_when(
      country %in% c("united states", "germany", "canada", "japan", "france") ~ "High income",
      country %in% c("china", "brazil", "south africa", "mexico", "turkey") ~ "Upper middle income",
      country %in% c("india", "nigeria", "indonesia", "pakistan") ~ "Lower middle income",
      TRUE ~ "Other"
    )
  )

# Create quintiles for optional comparison
df <- df %>%
  mutate(
    gdp_pc_quintile = ntile(gdp_per_capita, 5),
    co2_pc_quintile = ntile(co2_per_capita, 5)
  )

# Save basic fairness summary table
fairness_summary <- df %>%
  summarise(
    gdp_pc_mean = mean(gdp_per_capita, na.rm = TRUE),
    gdp_pc_median = median(gdp_per_capita, na.rm = TRUE),
    co2_pc_mean = mean(co2_per_capita, na.rm = TRUE),
    co2_pc_median = median(co2_per_capita, na.rm = TRUE)
  )
fairness_summary
write_csv(fairness_summary, "tables/fairness_summary.csv")

# Boxplot: CO2 per capita by income group
p_income_box <- ggplot(df, aes(x = income_group, y = co2_per_capita, fill = income_group)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7) +
  coord_cartesian(ylim = c(0, quantile(df$co2_per_capita, 0.95, na.rm = TRUE))) +
  labs(
    title = "CO2 per Capita by Income Group",
    x = "Income Group",
    y = "CO2 per Capita (MtCO2)"
  ) +
  theme_minimal()
p_income_box
ggsave("plots/co2_per_capita_by_income_group.png", p_income_box, width = 9, height = 5)

# Line plot: Trends in GDP & CO2 per capita by income group
df_grouped <- df %>%
  group_by(year, income_group) %>%
  summarise(
    gdp_pc = mean(gdp_per_capita, na.rm = TRUE),
    co2_pc = mean(co2_per_capita, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(gdp_pc, co2_pc), names_to = "metric", values_to = "value")

p_income_trend <- ggplot(df_grouped, aes(x = year, y = value, color = income_group)) +
  geom_line(size = 1) +
  facet_wrap(~metric, scales = "free_y") +
  labs(
    title = "Per Capita GDP and CO2 Trends by Income Group",
    x = "Year",
    y = "Value"
  ) +
  theme_minimal()
p_income_trend
ggsave("plots/per_capita_trends_by_income_group.png", p_income_trend, width = 10, height = 6)


