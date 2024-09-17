# CODICE ESAME TELERILEVAMENTO 2024

# Caricamento dei pacchetti
library(terra)
library(devtools)
library(imageRy)
library(ggplot2)
library(patchwork) 
library(viridis)
library(RNetCDF)


# IMPORTAZIONE DELLE IMMAGINI E PLOT
# Importo i dati dal sito di Copernicus

# Setto la working directory per le immagini scelte
setwd("C:/Users/Martina/OneDrive - Alma Mater Studiorum Università di Bologna/Documents/UNIVERSITA'/TELERILEVAMENTO")

# Carico le immagini "true color"
apr2022 <- rast("2022-06-01-True_color.jpg")
giu2022 <- rast("2022-06-01-True_color.jpg")
set2022 <- rast("2022-06-01-True_color.jpg")
ago2023 <- rast("2022-06-01-True_color.jpg")

# Carico le immagini "false color"
apr2022N <- rast("2022-06-01-True_color.jpg")
giu2022N <- rast("2022-06-01-True_color.jpg")
set2022N <- rast("2022-06-01-True_color.jpg")
ago2023N <- rast("2022-06-01-True_color.jpg")

plotRGB(giugno2022, 1, 2, 3)
