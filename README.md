# GDP and CO₂ Emissions Project

This repository contains all the materials for my DATA 375 (Introduction to Statistical Computing) project at the University of Arizona.  
The project explores the relationship between a country's GDP and its CO₂ emissions using real-world data, along with regression analysis, simulations, and visualizations.

---

## Folder Structure

- **data/**
  - **original/**: Original unmodified datasets
  - **cleaned/**: Dataset after cleaning, filtering, and transformations for analysis.

- **docs/**
  - Project documents including the proposal, preliminary report, final report, presentation slides, and supplementary materials.

- **scripts/**
  - R scripts used for data cleaning, modeling, simulation, and visualization.

- **plots/**
  - Graphs and figures generated for the project, used in the reports and presentation.

---

## Dataset Sources

- **CO₂ Emissions Data:**  
  Downloaded from the [Global Carbon Atlas](https://globalcarbonatlas.org/).  
  This dataset provides annual territorial CO₂ emissions by country, measured in million tonnes of CO₂ (MtCO₂), covering multiple decades.

- **GDP Data:**  
  Downloaded from the [World Bank World Development Indicators](https://data.worldbank.org/indicator/NY.GDP.MKTP.CD).  
  This dataset includes each country's annual Gross Domestic Product (GDP) in current US dollars (USD), starting from 1960 onwards.

---

## Notes on the Data

- **Primary Key:** Both datasets use (`country`, `year`) as the primary key for merging.
- **CO₂ Units:** Territorial CO₂ emissions are reported in million tonnes (MtCO₂).
- **GDP Units:** GDP is reported in current U.S. dollars without inflation adjustment.

---

## Project Goals

- Explore whether GDP is positively correlated with CO₂ emissions across countries and over time.
- Fit linear and log-transformed regression models to understand the relationship.
- Apply simulation techniques (e.g., bootstrap sampling) to assess variability and future scenarios.
- Visualize the patterns across countries and regions.

---



****
