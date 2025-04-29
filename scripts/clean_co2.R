library(tidyr)
library(dplyr)

# Read data (replace with your actual file path)
co2 <- read.csv("data/original/co2_emissions.csv", check.names = FALSE, na.strings = c("", "NA"), skip = 1)

head(co2)

colnames(co2)[1] <- "Year"

# Clean column names and reshape
co2_long <- co2 %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "CO2",
    values_drop_na = TRUE
  ) %>%
  arrange(Year, Country)

# View result
head(co2_long, 10)

