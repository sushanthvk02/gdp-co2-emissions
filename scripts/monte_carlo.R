library(tidyverse)
library(ggplot2)

df <- read_csv("gdp_co2_data.csv")

model_log <- lm(log(co2_emissions) ~ log(gdp), data = df)

set.seed(123)
n_sim <- 10000
gdp_sample <- sample(df$gdp, size = n_sim, replace = TRUE)

gdp_low <- gdp_sample * runif(n_sim, 1.01, 1.03)
gdp_med <- gdp_sample * runif(n_sim, 1.05, 1.10)
gdp_high <- gdp_sample * runif(n_sim, 1.10, 1.20)

pred_low <- predict(model_log, newdata = data.frame(gdp = gdp_low))
pred_med <- predict(model_log, newdata = data.frame(gdp = gdp_med))
pred_high <- predict(model_log, newdata = data.frame(gdp = gdp_high))

co2_low <- exp(pred_low)
co2_med <- exp(pred_med)
co2_high <- exp(pred_high)

sim_df <- tibble(
  co2 = c(co2_low, co2_med, co2_high),
  scenario = rep(c("Low (1–3%)", "Medium (5–10%)", "High (10–20%)"), each = n_sim)
)
sim_df

p_hist <- ggplot(sim_df, aes(x = co2, fill = scenario)) +
  geom_histogram(bins = 50, alpha = 0.6, position = "identity") +
  facet_wrap(~scenario, scales = "free_y") +
  labs(
    title = "Histogram of Simulated CO2 Emissions (Random GDP Growth)",
    x = "CO2 Emissions (MtCO2)",
    y = "Frequency"
  ) + 
  scale_x_continuous(breaks = seq(0, 6000, by = 2000)) +
  coord_cartesian(xlim = c(0, 6000)) +
  theme_minimal()
p_hist
ggsave("plots/mc_sim_histograms_facet.png", plot = p_hist, width = 10, height = 5)

p_hist_log <- ggplot(sim_df, aes(x = co2, fill = scenario)) +
  geom_histogram(bins = 50, alpha = 0.6, position = "identity") +
  facet_wrap(~scenario, scales = "free_y") +
  scale_x_log10() +
  labs(
    title = "Log-Scaled Histogram of Simulated CO2 Emissions",
    x = "CO2 Emissions (log MtCO2)",
    y = "Frequency"
  ) +
  theme_minimal()
p_hist_log
ggsave("plots/mc_sim_log_histograms_facet.png", plot = p_hist_log, width = 10, height = 5)

p_density <- ggplot(sim_df, aes(x = co2, fill = scenario)) +
  geom_density(alpha = 0.6) +
  labs(
    title = "Density Plot – Monte Carlo Simulation (Random GDP Growth)",
    x = "CO₂ Emissions (MtCO2)",
    y = "Density"
  ) +
  scale_x_continuous(breaks = seq(0, 1000, by = 200)) +
  coord_cartesian(xlim = c(0, 1000)) +
  theme_minimal()
p_density
ggsave("plots/mc_sim_density_overlay.png", plot = p_density, width = 9, height = 5)


p_density_log <- ggplot(sim_df, aes(x = co2, fill = scenario)) +
  geom_density(alpha = 0.6) +
  scale_x_log10() +
  labs(
    title = "Density Plot (Log X-Axis)",
    x = "CO2 Emissions (log MtCO2)",
    y = "Density"
  ) +
  theme_minimal()
p_density_log
ggsave("plots/mc_sim_log_density_overlay.png", plot = p_density_log, width = 9, height = 5)

summary_df <- sim_df %>%
  group_by(scenario) %>%
  summarise(
    mean = mean(co2),
    sd = sd(co2),
    min = min(co2),
    max = max(co2),
    p10 = quantile(co2, 0.10),
    median = median(co2),
    p90 = quantile(co2, 0.90)
  )
summary_df
write_csv(summary_df, "tables/mc_sim_random_gdp_summary.csv")





