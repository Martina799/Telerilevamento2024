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

# Carico le immagini "true color" - STROMBOLI
apr2022 <- rast("2022-04-12-True_color.jpg")
giu2022 <- rast("2022-06-01-True_color.jpg")
set2022 <- rast("2022-09-14-True_color.jpg")
ago2023 <- rast("2023-08-15-True_color.jpg")

# Carico le immagini "false color" - STROMBOLI
apr2022N <- rast("2022-04-12-False_color.jpg")
giu2022N <- rast("2022-06-01-False_color.jpg")
set2022N <- rast("2022-09-14-False_color.jpg")
ago2023N <- rast("2023-08-15-False_color.jpg")

# Carico le immagini "true color" - AUSTRALIA
#mar2019 <- rast("2019-03-26-True_color.jpg")
#feb2020 <- rast("2020-02-04-True_color.jpg")
#gen2021 <- rast("2021-01-24-True_color.jpg")
#feb2024 <- rast("2024-02-13-True_color.jpg")

# Carico le immagini "true color" - AUSTRALIA
#mar2019 <- rast("2019-03-26-False_color.jpg")
#feb2020 <- rast("2020-02-04-False_color.jpg")
#gen2021 <- rast("2021-01-24-False_color.jpg")
#feb2024 <- rast("2024-02-13-False_color.jpg")

# Plot delle 4 immagini True color in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(apr2022, 1, 2, 3)
plotRGB(giu2022, 1, 2, 3)
plotRGB(set2022, 1, 2, 3)
plotRGB(ago2023, 1, 2, 3)

# Plot delle 4 immagini NIR in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(apr2022N, 1, 2, 3)
plotRGB(giu2022N, 1, 2, 3)
plotRGB(set2022N, 1, 2, 3)
plotRGB(ago2023N, 1, 2, 3)

plotRGB(apr2022, 1, 2, 3)
plotRGB(apr2022, 2, 1, 3)
