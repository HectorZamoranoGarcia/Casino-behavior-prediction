# 02 Data preparation

library(dplyr)
library(lubridate)
library(readr)

# Read the raw data

data <- read_csv("datos/raw/bustabit.csv")

# Prepare the fields

data <- data %>%
  # Drop rows without profit

  filter(!is.na(Profit)) %>%
  mutate(
    # Parse the date

    PlayDate = as.POSIXct(PlayDate, format = "%Y-%m-%d %H:%M:%S"),

    # Add time fields

    hora       = hour(PlayDate),
    dia_semana = wday(PlayDate, label = TRUE),

    # Flag negative profit values

    perdio = ifelse(Profit < 0, 1, 0),

    # Group bets by size

    tipo_apuesta = case_when(
      Bet < 10  ~ "pequeña",
      Bet < 100 ~ "media",
      TRUE      ~ "grande"
    )
  )

# Check the target

sum(is.na(data$perdio))

# Save the processed data

write.csv(data, "datos/processed/bustabit_procesado.csv", row.names = FALSE)
