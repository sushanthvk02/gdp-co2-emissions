library(tidyverse)

df <- read_csv("gdp_co2_data.csv")

model <- lm(co2_emissions ~ gdp, data = df)
summary(model)














