# Casino Behavior Prediction

An R project for exploring betting activity in the Bustabit dataset. It includes data cleaning, player clustering, and basic classification and regression exercises.

## Project scope

- Explore the betting data and prepare a few derived fields
- Group players by bet count and average bet
- Compare simple models on simulated data
- Save plots for the analysis

The classification and regression examples use synthetic records. Their scores do not show how well a model would predict real gambling outcomes.

## Data

The raw file comes from the [Gambling Behavior Bustabit dataset on Kaggle](https://www.kaggle.com/datasets/kingabzpro/gambling-behavior-bustabit). It contains 50,000 records from October to December 2016 and is included in `datos/raw/bustabit.csv`. The processed files are also tracked in this repository.

The preparation script removes rows with missing `Profit` and adds the hour, day of the week, loss flag, and bet-size group. In the included raw file, 21,266 of 50,000 rows have no `Profit`, and none of the remaining values are negative. The prepared loss flag is therefore zero for every retained row. Classification and regression use a separate file of 5,000 synthetic records with a 60% loss rate.

## Analysis

### Player clustering

The clustering script groups players by total bets and average bet. It scales both features and uses K-Means with three clusters. Only players with at least five bets are included.

The cluster names in the visualization are descriptive labels assigned by cluster size. They are not validated risk scores.

### Classification and regression

The classification scripts compare logistic regression and random forest using the simulated data. The model-comparison script uses five-fold cross-validation.

The regression script compares two linear models with an 80/20 split. Since its target is simulated, its scores are only an exercise in model fitting and evaluation.

## Visualizations

Run `notebooks/07_visualizaciones_linkedin.R` to create these figures:

| File | Description |
|---|---|
| `player_segmentation_kmeans.png` | Player clusters by average bet and bet count |
| `bet_distribution_by_profile.png` | Bet distribution for each cluster |
| `linear_regression_profit_analysis.png` | Predicted and actual profit, with prediction errors |

## Repository structure

```text
casino-behavior-prediction/
├── datos/
│   ├── raw/bustabit.csv
│   └── processed/
│       ├── bustabit_procesado.csv
│       └── casino_simulado.csv
├── notebooks/
│   ├── 01_analisis_exploratorio.R
│   ├── 02_preparacion_datos.R
│   ├── 03_clustering_perfiles.R
│   ├── 04_prediccion_churn.R
│   ├── 05_regresion_lineal.R
│   ├── 06_modelos_avanzados.R
│   └── 07_visualizaciones_linkedin.R
├── results/figures/
├── results/models/
└── README.md
```

## Setup

Install the R packages used by the scripts:

```r
install.packages(c(
  "dplyr", "ggplot2", "caret", "randomForest",
  "lubridate", "readr", "scales", "patchwork"
))
```

Run each script from the repository root, in order:

```r
source("notebooks/01_analisis_exploratorio.R")
source("notebooks/02_preparacion_datos.R")
source("notebooks/03_clustering_perfiles.R")
source("notebooks/04_prediccion_churn.R")
source("notebooks/05_regresion_lineal.R")
source("notebooks/06_modelos_avanzados.R")
source("notebooks/07_visualizaciones_linkedin.R")
```

## Notes

- The scripts set a seed before their random steps
- GitHub Copilot was used for code suggestions and autocomplete; the analysis decisions were made manually

## Author

Héctor Zamorano García
