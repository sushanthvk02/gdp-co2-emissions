library(tidyverse)

df <- read_csv("gdp_co2_population_data.csv")

df <- df %>%
  mutate(decade = paste0(floor(year / 10) * 10, "s"))


# 1. Basic Scatterplot: GDP vs CO₂ Emissions
p1 <- ggplot(df, aes(x = gdp, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(
    title = "Scatterplot of GDP vs CO2 Emissions",
    x = "GDP (US Dollars)",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()
p1
ggsave("plots/gdp_vs_co2_scatter.png", plot = p1, width = 8, height = 5)



# 2. Log-Log Scatterplot
p2 <- ggplot(df, aes(x = gdp, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "Log-Log Scatterplot of GDP vs CO2 Emissions",
    x = "Log(GDP)",
    y = "Log(CO2 Emissions)"
  ) +
  theme_minimal()
p2
ggsave("plots/gdp_vs_co2_loglog_scatter.png", plot = p2, width = 8, height = 5)



# 3. Colored Log-Log by Year
p3 <- ggplot(df, aes(x = gdp, y = co2_emissions, color = year)) +
  geom_point(alpha = 0.6) +
  scale_color_viridis_c() +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "GDP vs CO2 Emissions Colored by Year",
    x = "GDP (US Dollars)",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()
p3
ggsave("plots/gdp_vs_co2_loglog_colored_by_year.png", plot = p3, width = 8, height = 5)



# 4. Log-Log Faceted by Decade
p4 <- ggplot(df, aes(x = gdp, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "purple") +
  scale_x_log10() +
  scale_y_log10() +
  facet_wrap(~decade) +
  labs(
    title = "Log-Log Scatterplot of GDP vs CO2 Emissions by Decade",
    x = "Log(GDP)",
    y = "Log(CO2 Emissions)"
  ) +
  theme_minimal()
p4
ggsave("plots/gdp_vs_co2_loglog_facet_by_decade.png", plot = p4, width = 10, height = 6)



# 5. Line Plot: CO₂ Emissions Over Time (Top 5 Countries)
selected_countries <- c("united states", "china", "india", "germany", "brazil")
p5 <- ggplot(df %>% filter(country %in% selected_countries),
             aes(x = year, y = co2_emissions, color = country)) +
  geom_line() +
  labs(
    title = "CO2 Emissions Over Time (1990–2023)",
    x = "Year",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()
p5
ggsave("plots/co2_over_time_selected_countries.png", plot = p5, width = 8, height = 5)



# 6. Line Plot: GDP Over Time (Top 5 Countries)
p6 <- ggplot(df %>% filter(country %in% selected_countries),
             aes(x = year, y = gdp, color = country)) +
  geom_line() +
  labs(
    title = "GDP Over Time (1990–2023)",
    x = "Year",
    y = "GDP (US Dollars)"
  ) +
  theme_minimal()
p6
ggsave("plots/gdp_over_time_selected_countries.png", plot = p6, width = 8, height = 5)



# 7. Population Over Time (Top 5 Countries)
p7 <- ggplot(df %>% filter(country %in% selected_countries),
             aes(x = year, y = population, color = country)) +
  geom_line() +
  labs(
    title = "Population Over Time (1990–2023)",
    x = "Year",
    y = "Population"
  ) +
  theme_minimal()
p7
ggsave("plots/population_over_time_selected_countries.png", plot = p7, width = 8, height = 5)



# 8. Population vs CO₂ Emissions (Scatterplot)
p8 <- ggplot(df, aes(x = population, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "darkred") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "Population vs CO2 Emissions (Log-Log Scale)",
    x = "Population",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()
p8
ggsave("plots/population_vs_co2_loglog.png", plot = p8, width = 8, height = 5)



# 9. Population vs GDP (Scatterplot)
p9 <- ggplot(df, aes(x = population, y = gdp)) +
  geom_point(alpha = 0.5, color = "steelblue") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "Population vs GDP (Log-Log Scale)",
    x = "Population",
    y = "GDP (US Dollars)"
  ) +
  theme_minimal()
p9
ggsave("plots/population_vs_gdp_loglog.png", plot = p9, width = 8, height = 5)





