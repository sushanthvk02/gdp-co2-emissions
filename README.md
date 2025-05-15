# Does Economic Growth Increase CO₂ Emissions?
### An Analysis of Global GDP and Environmental Impact

This solo project investigates whether economic growth, measured by GDP, is still tightly linked to CO₂ emissions, and whether signs of decoupling are beginning to emerge. It was completed as part of DATA 375: Statistical Computing at the University of Arizona.

##  Project Summary
- Built a merged dataset using public data from the World Bank and Our World in Data (1990–2023)
- Explored patterns using time series plots, scatterplots, and summary statistics
- Fitted linear and log-log regression models, including models with population as a second predictor
- Used **Monte Carlo simulation** to estimate CO₂ outcomes under varying GDP growth scenarios
- Applied **bootstrapping** to assess model stability and construct confidence intervals
- Performed **fairness analysis** by comparing CO₂ emissions and GDP on a per capita basis and across income groups

##  Repository Structure

project-root/
├── data/
│ ├── original/ # Raw input data
│ └── cleaned/ # Final merged dataset (1990–2023)
├── scripts/
│ ├── modeling.R # All regression, simulation, and bootstrap code
│ ├── visualizations.R # Plots used in the report
│ └── summary_statistics.R # EDA and variable summaries
├── plots/
│ ├── *.png # All generated visualizations
├── tables/
│ ├── *.csv # Output tables (model coeffs, summaries, etc.)
├── docs/
│ ├── Data 375_Preliminary Report.pdf
│ ├── DATA 375 Presentation.pdf
│ └── Final Report.pdf
└── README.md


## Data Sources
- **GDP:** [World Bank](https://data.worldbank.org/indicator/NY.GDP.MKTP.CD)
- **CO₂ Emissions:** [Our World in Data](https://ourworldindata.org/co2-dataset-sources)
- **Population:** [Our World in Data](https://ourworldindata.org/population-growth#explore-data-on-population-growth)

## Tools & Libraries
- R (tidyverse, ggplot2)
- Linear regression, log-log models
- Monte Carlo simulation
- Bootstrapping
- Data visualization and EDA

## Author
Viswa Sushanth Karuturi  
University of Arizona | DATA 375 — Statistical Computing  
Instructor: Prof. Niu

## 🔗 Repository
All data, code, and output files are available in this GitHub repository:  
[github.com/sushanthvk02/gdp-co2-emissions](https://github.com/sushanthvk02/gdp-co2-emissions)


