# Casino Behavior Prediction

Project analyzing online casino player behavior using different machine learning approaches (supervised and unsupervised) in **R**

## Description

This project aims to detect patterns in player behavior and predict outcomes of online betting
The main approach was not only writing code, but exploring and cleaning data, testing different machine learning models in R, and analyzing their results
Clustering techniques were applied to segment user profiles and classification and regression models were used to estimate losses, gains, and outcome probabilities
During development, subtle assistance from artificial intelligence was used, mainly Copilot in Visual Studio Code for code suggestions and autocompletion, but all decisions and analyses were made manually

## Objectives

* Identify different types of players through clustering analysis
* Estimate the probability of losing a bet
* Calculate expected returns with regression models
* Compare performance among several predictive models

## Data

**Main source:** Bustabit Gambling Behavior Dataset (Kaggle)

* 50 000 betting records
* 9 main variables (Id, GameID, Username, Bet, Profit, etc)
* Year 2023
* Approximate size 2.3 MB

**Created variables**

* `hour`: hour of the day (0–23)
* `weekday`: day of the week (1–7)
* `lost`: 1 if the bet resulted in a loss, 0 if it was a win
* `bet_type`: small / medium / large depending on the amount

To balance the data (the original dataset only had wins) 5 000 synthetic records were generated with a more realistic distribution (60% losses and 40% wins) using base R functions (rexp, sample, rbinom)

## Methodology

### 1. Exploratory analysis

General dataset review, missing value cleaning, and descriptive analysis of numerical variables
Extraction of temporal information such as hour and day from the PlayDate variable

### 2. Data preparation

Conversion of dates to POSIXct format
Creation of derived variables and bet categorization by amount

### 3. Partition

Training set 80 %
Test set 20 %
Stratified sampling with createDataPartition from caret
Random seed 123

### 4. Clustering

K-means algorithm with k = 3
Variables used: total and average bet per player
Data aggregated by user (1 182 unique players with at least 5 bets)

| Cluster | # Players   | Average Bet | Interpretation          |
| ------- | ------------ | ------------ | ------------------------ |
| 1       | 19 (1.6%)    | 177 505      | High-risk players        |
| 2       | 109 (9.2%)   | 418          | Frequent users           |
| 3       | 1 054 (89.2%)| 1 953        | Casual players           |

### 5. Classification models

Target variable: lost (0 = won, 1 = lost)
Models tested

* Simple logistic regression and with interaction
* Random Forest (ntree = 500)

Cross-validation results (5-fold)

| Model        | Accuracy | Kappa | Observations                         |
| ------------- | -------- | ----- | ------------------------------------- |
| Logistic      | 0.585    | 0.00  | Predicts the majority class           |
| Random Forest | 0.530    | 0.01  | Slight improvement, low discrimination |

### 6. Regression models

Target variable Profit

Models

* Simple linear Profit ~ Bet + hour
* Linear with interaction Profit ~ Bet * hour + weekday

| Model            | R²    | RMSE   | Significant variables |
| ----------------- | ----- | ------ | ---------------------- |
| Simple            | 0.029 | 136.45 | Bet                    |
| With interactions | 0.019 | 136.26 | Bet, Bet:hour          |

Bet is the best predictor, although the explained variance is low, which makes sense in a gambling context

## Conclusions

Three distinct player profiles were identified
Classification models have limited performance, consistent with the random nature of gambling
Bet amount (Bet) is the most relevant variable
Logistic regression was the model with the best average accuracy (≈ 0.58)

## Repository structure

```
casino-behavior-prediction/
├── datos/
│   ├── raw/
│   └── processed/
├── notebooks/
│   ├── 01_analisis_exploratorio.R
│   ├── 02_preparacion_datos.R
│   ├── 03_clustering_perfiles.R
│   ├── 04_prediccion_churn.R
│   ├── 05_regresion_lineal.R
│   └── 06_modelos_avanzados.R
├── results/
│   └── figures/
└── README.md
```


## Technologies

* R language 4.5
* Libraries dplyr, ggplot2, caret, randomForest, lubridate, readr
* Version control with Git / GitHub
* IDE Visual Studio Code with R extension

## Execution

Install dependencies

install.packages(c("dplyr", "ggplot2", "caret", "randomForest", "readr", "lubridate"))


Run scripts in order

source("notebooks/01_exploratory_analysis.R")
source("notebooks/02_data_preparation.R")
source("notebooks/03_profile_clustering.R")
source("notebooks/04_churn_prediction.R")
source("notebooks/05_linear_regression.R")
source("notebooks/06_advanced_models.R")


Author

Héctor Zamorano García

Fixed seed 123
Synthetic dataset generated with exponential and binomial distributions
