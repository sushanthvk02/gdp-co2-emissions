# Load required library
library(tidyverse)

# Step 1: Load the raw GDP dataset
# - Skip the first 4 rows because they contain metadata (not actual data)
gdp_raw <- read_csv("data/original/gdp.csv", skip = 4)

# Preview the raw dataset
head(gdp_raw)

# Step 2: Select only necessary columns
# - Keep 'Country Name' and the GDP values for each year (from column 7 onwards)
# - Ignore other metadata columns like "Country Code", "Indicator Name", etc.
gdp_clean <- gdp_raw %>%
  select('Country Name', c(7:ncol(gdp_raw) - 2))

# Preview the cleaned subset
head(gdp_clean)
colnames(gdp_clean)

# Step 3: Reshape the data to long format
# - Pivot year columns (1960, 1961, ...) into two columns: 'Year' and 'GDP'
gdp_long <- gdp_clean %>%
  pivot_longer(
    cols = -`Country Name`,   # All columns except 'Country Name' will be pivoted
    names_to = "Year",        # New column to store year values
    values_to = "GDP"         # New column to store corresponding GDP values
  ) %>%
  rename(Country = `Country Name`) %>%  # Rename 'Country Name' to 'Country' for simplicity
  mutate(
    year = as.integer(Year),           # Ensure year is numeric
    gdp = as.numeric(GDP)               # Ensure GDP is numeric
  ) %>%
  select(Country, Year, GDP) %>%        # Reorder columns: Country, Year, GDP
  arrange(Year, Country)                # Sort the data first by Year, then Country

# Step 4: Save the cleaned long-format GDP dataset
write_csv(gdp_long, "data/cleaned/gdp.csv")

# Step 5: Quick preview of the final dataset
head(gdp_long)

