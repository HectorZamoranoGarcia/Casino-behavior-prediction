# 05 Linear regression

library(dplyr)
library(caret)
library(ggplot2)

# Read the simulated data

data <- read.csv("datos/processed/casino_simulado.csv")

# Split the data into training and test sets

set.seed(123)
trainIndex <- createDataPartition(data$Profit, p = 0.8, list = FALSE)
train      <- data[trainIndex, ]
test       <- data[-trainIndex, ]

# Fit a simple regression model

modelo_simple <- lm(Profit ~ Bet + hora, data = train)
summary(modelo_simple)

# Fit a model with an interaction

modelo_interacciones <- lm(Profit ~ Bet * hora + dia_semana, data = train)
summary(modelo_interacciones)

# Predict on the test set

pred_simple <- predict(modelo_simple, test)
pred_int    <- predict(modelo_interacciones, test)

# Compare the model errors

cat("\n=== SIMPLE MODEL ===\n")
cat("RMSE:", RMSE(pred_simple, test$Profit), "\n")
cat("R²:",   R2(pred_simple,   test$Profit), "\n")

cat("\n=== MODEL WITH INTERACTIONS ===\n")
cat("RMSE:", RMSE(pred_int, test$Profit), "\n")
cat("R²:",   R2(pred_int,   test$Profit), "\n")

# Plot actual and predicted values

ggplot(
  data.frame(Real = test$Profit, Predicho = pred_int),
  aes(x = Real, y = Predicho)
) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(
    title = "Linear Regression: Predicted vs Actual",
    x     = "Actual Profit",
    y     = "Predicted Profit"
  ) +
  theme_minimal()

ggsave("results/figures/regresion_lineal.png", width = 8, height = 6)
