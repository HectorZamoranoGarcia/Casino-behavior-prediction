# 01 Exploratory analysis

# Load packages

library(readr)
library(dplyr)
library(ggplot2)

# Read the raw data

data <- read_csv("datos/raw/bustabit.csv")

# Check the data

str(data)
head(data)
summary(data)

# Check the dimensions

cat("Rows:", nrow(data), "\n")
cat("Columns:", ncol(data), "\n")

# Check the column names

colnames(data)

# Count missing values

colSums(is.na(data))
