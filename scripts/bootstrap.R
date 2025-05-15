# 1. Bootstrapping Regression Coefficients
library(tidyverse)

df <- read_csv("gdp_co2_population_data.csv") %>%
  mutate(
    log_gdp = log(gdp),
    log_co2 = log(co2_emissions)
  )

set.seed(123)
n_boot <- 1000
coefs <- replicate(n_boot, {
  sample_df <- df[sample(1:nrow(df), replace = TRUE), ]
  model <- lm(log_co2 ~ log_gdp, data = sample_df)
  coef(model)
})

boot_coefs <- as_tibble(t(coefs), .name_repair = "minimal")
colnames(boot_coefs) <- c("Intercept", "log_gdp")

boot_ci <- boot_coefs %>%
  summarise(
    intercept_mean = mean(Intercept),
    intercept_lower = quantile(Intercept, 0.025),
    intercept_upper = quantile(Intercept, 0.975),
    slope_mean = mean(log_gdp),
    slope_lower = quantile(log_gdp, 0.025),
    slope_upper = quantile(log_gdp, 0.975)
  )
boot_ci
write_csv(boot_ci, "tables/bootstrap_confidence_intervals.csv")

# Plot histogram of slope
p1 <- ggplot(boot_coefs, aes(x = log_gdp)) +
  geom_histogram(bins = 50, fill = "darkgreen", color = "white") +
  labs(title = "Bootstrapped Distribution of log(GDP) Coefficient",
       x = "Slope Estimate", y = "Frequency") +
  theme_minimal()
p1
ggsave("plots/bootstrap_loggdp_coef_hist.png", p1, width = 8, height = 5)



# 2. Bootstrapped Prediction Distributions
library(tidyverse)

df <- read_csv("gdp_co2_population_data.csv") %>%
  mutate(
    log_gdp = log(gdp),
    log_co2 = log(co2_emissions)
  )

model_log <- lm(log_co2 ~ log_gdp, data = df)

gdp_vals <- quantile(df$gdp, probs = c(0.25, 0.5, 0.9))
gdp_labels <- c("Low GDP (25th %ile)", "Median GDP (50th %ile)", "High GDP (90th %ile)")
gdp_log <- log(gdp_vals)

bootstrap_pred <- function(log_gdp_value, n = 1000) {
  set.seed(123)
  preds <- numeric(n)
  for (i in 1:n) {
    sample_df <- df[sample(nrow(df), replace = TRUE), ]
    model <- lm(log_co2 ~ log_gdp, data = sample_df)
    preds[i] <- exp(model$coefficients[1] + model$coefficients[2] * log_gdp_value)
  }
  return(preds)
}

boot_preds <- map2_dfr(gdp_log, gdp_labels, ~ {
  tibble(
    co2 = bootstrap_pred(.x),
    scenario = .y
  )
})

summary_table <- boot_preds %>%
  group_by(scenario) %>%
  summarise(
    mean = mean(co2),
    sd = sd(co2),
    min = min(co2),
    max = max(co2),
    p10 = quantile(co2, 0.1),
    median = median(co2),
    p90 = quantile(co2, 0.9)
  )

write_csv(summary_table, "tables/bootstrap_prediction_summary_realistic_gdp.csv")

# Plot: density plot (full scale, no log)
p_density <- ggplot(boot_preds, aes(x = co2, fill = scenario)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Bootstrapped CO2 Predictions by Realistic GDP Levels",
    x = "Predicted CO2 Emissions (MtCO2)",
    y = "Density"
  ) +
  theme_minimal()
p_density
ggsave("plots/bootstrap_pred_density_realistic_gdp.png", plot = p_density, width = 9, height = 5)
