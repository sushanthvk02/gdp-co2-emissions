library(tidyverse)

df <- read_csv("gdp_co2_data.csv")

# Basic Scatterplot
ggplot(df, aes(x = gdp, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(
    title = "Scatterplot of GDP vs CO2 Emissions",
    x = "GDP (US Dollars)",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()


# Log-Log Scatterplot
ggplot(df, aes(x = gdp, y = co2_emissions)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "Log-Log Scatterplot of GDP vs CO2 Emissions",
    x = "Log(GDP)",
    y = "Log(CO2 Emissions)"
  ) +
  theme_minimal()


# Example countries 
selected_countries <- c("united states", "china", "india", "germany", "brazil")

# Line plot: CO2 over time
ggplot(df %>% filter(country %in% selected_countries), aes(x = year, y = co2_emissions, color = country)) +
  geom_line() +
  labs(
    title = "CO2 Emissions Over Time (1990–2023)",
    x = "Year",
    y = "CO2 Emissions (MtCO2)"
  ) +
  theme_minimal()


# Line plot: GDP over time
ggplot(df %>% filter(country %in% selected_countries), aes(x = year, y = gdp, color = country)) +
  geom_line() +
  labs(
    title = "GDP Over Time (1990–2023)",
    x = "Year",
    y = "GDP (US Dollars)"
  ) +
  theme_minimal()

# Colored log-Log Scatterplot by Year
ggplot(df, aes(x = gdp, y = co2_emissions, color = year)) +
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


# Faceted Log-Log Plots by Decade
df <- df %>% mutate(decade = paste0(floor(year / 10) * 10, "s"))

ggplot(df, aes(x = gdp, y = co2_emissions)) +
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


