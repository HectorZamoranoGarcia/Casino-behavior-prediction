# 06 Model comparison

library(caret)
library(randomForest)

# Read the simulated data

data        <- read.csv("datos/processed/casino_simulado.csv")
data$perdio <- as.factor(data$perdio)

# Set up five-fold cross-validation

control <- trainControl(method = "cv", number = 5)

# Fit the logistic model

set.seed(123)
modelo_logit <- train(
  perdio ~ Bet + hora,
  data      = data,
  method    = "glm",
  family    = "binomial",
  trControl = control
)

# Fit the random forest

set.seed(123)
modelo_rf <- train(
  perdio ~ Bet + hora + dia_semana,
  data      = data,
  method    = "rf",
  trControl = control
)

# Compare the models

resultados <- resamples(list(
  Logistica    = modelo_logit,
  RandomForest = modelo_rf
))

summary(resultados)

# Plot the model results

png("results/figures/comparacion_modelos.png", width = 800, height = 600)
bwplot(resultados)
dev.off()

# Show the model accuracy

cat("\n=== BEST MODEL ===\n")
cat("Logistic Regression - Accuracy:", max(modelo_logit$results$Accuracy), "\n")
cat("Random Forest       - Accuracy:", max(modelo_rf$results$Accuracy),    "\n")
