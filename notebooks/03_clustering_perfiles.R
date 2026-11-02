# 03 Player clustering

library(dplyr)
library(ggplot2)
library(scales)

# Read the processed data

data <- read.csv("datos/processed/bustabit_procesado.csv")

# Summarize each player

jugadores <- data %>%
  group_by(Username) %>%
  summarise(
    apuestas_totales = n(),
    apuesta_promedio = mean(Bet),
    tasa_perdida     = mean(perdio, na.rm = TRUE)
  ) %>%
  # Keep players with five or more bets

  filter(apuestas_totales >= 5)

# Scale the features

datos_cluster <- jugadores %>%
  select(apuestas_totales, apuesta_promedio) %>%
  scale()

# Create three clusters

set.seed(123)
kmeans_result    <- kmeans(datos_cluster, centers = 3, nstart = 25)
jugadores$cluster <- as.factor(kmeans_result$cluster)

# Plot the clusters

ggplot(jugadores, aes(x = apuesta_promedio, y = apuestas_totales, color = cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Player Profiles (Logarithmic Scale)",
    x     = "Average Bet (Log Scale)",
    y     = "Number of Bets",
    color = "Cluster"
  ) +
  theme_minimal()

# Save the plot

ggsave("results/figures/clusters_perfiles_log.png", width = 9, height = 6)
