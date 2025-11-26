# ============================================
# 03 - CLUSTERING: PERFILES DE JUGADORES (LOG SCALE)
# ============================================

library(dplyr)
library(ggplot2)
# library(scales) # Asegúrate de tenerlo instalado: install.packages("scales")

# --- (Esta parte de carga y proceso es igual) ---
# Cargar datos procesados
data <- read.csv("datos/processed/bustabit_procesado.csv")

# Crear dataset de jugadores
jugadores <- data %>%
  group_by(Username) %>%
  summarise(
    apuestas_totales = n(),
    apuesta_promedio = mean(Bet),
    tasa_perdida = mean(perdio, na.rm = TRUE)
  ) %>%
  filter(apuestas_totales >= 5)

# Clustering
datos_cluster <- jugadores %>%
  select(apuestas_totales, apuesta_promedio) %>%
  scale()

set.seed(123)
kmeans_result <- kmeans(datos_cluster, centers = 3, nstart = 25)

jugadores$cluster <- as.factor(kmeans_result$cluster)
# -----------------------------------------------


# --- VISUALIZACIÓN MEJORADA (Escala Log) ---
ggplot(jugadores, aes(x = apuesta_promedio, y = apuestas_totales, color = cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  # CAMBIO CLAVE AQUÍ: Usamos scale_x_log10 en vez de continuous
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Perfiles de Jugadores (Escala Logarítmica)",
    x = "Apuesta Promedio (Escala Log)", # Avisamos en el eje
    y = "Número de Apuestas",
    color = "Cluster"
  ) +
  theme_minimal()

# Guardamos con un nombre nuevo para comparar
ggsave("results/figures/clusters_perfiles_log.png", width = 9, height = 6)
