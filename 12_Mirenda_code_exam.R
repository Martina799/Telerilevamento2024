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
#apr2022 <- rast("2022-04-12-True_color.jpg")
#giu2022 <- rast("2022-06-01-True_color.jpg")
#set2022 <- rast("2022-09-14-True_color.jpg")
#ago2023 <- rast("2023-08-15-True_color.jpg")

# Carico le immagini "false color" - STROMBOLI
#apr2022N <- rast("2022-04-12-False_color.jpg")
#giu2022N <- rast("2022-06-01-False_color.jpg")
#set2022N <- rast("2022-09-14-False_color.jpg")
#ago2023N <- rast("2023-08-15-False_color.jpg")

# Carico le immagini "true color" - AUSTRALIA
mar2019 <- rast("2019-03-26-True_color.jpg")
feb2020 <- rast("2020-02-04-True_color.jpg")
gen2021 <- rast("2021-01-24-True_color.jpg")
feb2024 <- rast("2024-02-13-True_color.jpg")

# Carico le immagini "true color" - AUSTRALIA
mar2019N <- rast("2019-03-26-False_color.jpg")
feb2020N <- rast("2020-02-04-False_color.jpg")
gen2021N <- rast("2021-01-24-False_color.jpg")
feb2024N <- rast("2024-02-13-False_color.jpg")

# Plot delle 4 immagini True color in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(mar2019, 1, 2, 3)
plotRGB(feb2020, 1, 2, 3)
plotRGB(gen2021, 1, 2, 3)
plotRGB(feb2024, 1, 2, 3)

# Plot delle 4 immagini NIR in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(mar2019N, 1, 2, 3)
plotRGB(feb2020N, 1, 2, 3)
plotRGB(gen2021N, 1, 2, 3)
plotRGB(feb2024N, 1, 2, 3)

#feb2020N <- rast("2020-02-04-False_color.jpg")
#plotRGB(feb2020N, 1, 2, 3)
#plotRGB(feb2020N, 2, 3, 1)


# DIFFERENZE
# Quantifico i cambiamenti della vegetazione nel tempo tra le diverse immagini:

#diffGA2022 <- giu2022N[[1]] - apr2022N[[1]]
#diffSG2022 <- set2022N[[1]] - giu2022N[[1]]
#diffAS2223 <- ago2023N[[1]] - set2022N[[1]]
#diffPrePost <- set2022N[[1]] - ago2023N[[1]]
#stackdiff <- c(diffGA2022, diffSG2022, diffAS2223,diffPrePost)
difFM2019 <- feb2020N[[1]] - mar2019N[[1]]
difGF2021 <- gen2021N[[1]] - feb2020N[[1]]
difFG2421 <- feb2024N[[1]] - gen2021N[[1]]
difeventoPost <- feb2024N[[1]] - feb2020N[[1]]
stackdif <- c(difFM2019, difGF2021, difFG2421, difeventoPost)

# imposto la palette dei colori: prima per daltonici, seconda rosso, bianco e verde.
viridisc <- colorRampPalette(viridis(7))(255)
clg <- colorRampPalette(c("red", "white", "green")) (100)
#plot immagini differenze a colori
plot(stackdif, col=clg)
plot(stackdif, col=viridisc)
