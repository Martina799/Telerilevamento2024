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


# Il seguente codice analizza l'espansione di un campo lavico in Islanda da settembre 2023 a settembre 2024
# NOME: Vulcano Fagradalsfjall-Grindavik


# PLOT IMMAGINI

# Carico le immagini "true color" - ISLANDA
set2023 <- rast("2023-09-21-True_color.jpg")
mar2024 <- rast("2024-03-02-True_color.jpg")
lug2024 <- rast("2024-07-07-True_color.jpg")
set2024 <- rast("2024-09-13-True_color.jpg")

# Carico le immagini "false color" - ISLANDA
set2023N <- rast("2023-09-21-False_color.jpg")
mar2024N <- rast("2024-03-02-False_color.jpg")
lug2024N <- rast("2024-07-07-False_color.jpg")
set2024N <- rast("2024-09-13-False_color.jpg")

# Plot delle 4 immagini True color in una griglia 1x4 (righe-colonne)
par(mfrow=c(1,4))
plotRGB(set2023, 1, 2, 3)
plotRGB(mar2024, 1, 2, 3)
plotRGB(lug2024, 1, 2, 3)
plotRGB(set2024, 1, 2, 3)

# Plot delle 4 immagini NIR in una griglia 1x4 (righe-colonne)
par(mfrow=c(1,4))
plotRGB(set2023N, 1, 2, 3)
plotRGB(mar2024N, 1, 2, 3)
plotRGB(lug2024N, 1, 2, 3)
plotRGB(set2024N, 1, 2, 3)

dev.off() #pulizia



# DIFFERENZE

# Quantifico i cambiamenti nell'estensione del campo di lava tra le diverse immagini nel tempo:

difMS2423 <- mar2024N[[1]] - set2023N[[1]]
difLM2424 <- lug2024N[[1]] - mar2024N[[1]]
difSL2424 <- set2024N[[1]] - lug2024N[[1]]
difPD <- set2024N[[1]] - set2023N[[1]]
stackdif <- c(difMS2423, difLM2424, difSL2424, difPD)

# imposto la palette dei colori: prima per daltonici, seconda nero, arancio e giallo.
viridisc <- colorRampPalette(viridis(7))(255)
clg <- colorRampPalette(c("black", "orange", "yellow")) (100)
#plot immagini differenze a colori
plot(stackdif, col=clg)
plot(stackdif, col=viridisc)



# CLASSIFICAZIONE
par(mfrow=c(1,2))
mS2023c <- im.classify(set2023N, num_clusters=2)
mS2024c <- im.classify(set2024N, num_clusters=2)

# Settembre 2023:
# Calcolo la frequenza, numero di pixel per ogni classe 
fS2023 <- freq(mS2023c)
fS2023
# Calcolo proporzione numero di pixel rispetto al totale e percentuale
totS2023 <- ncell(mS2023c) # calcolo del totale
totS2023
propS2023 = fS2023 / totS2023 # frequenza diviso tot
percS2023 = propS2023 * 100 # percentuale

# Settembre 2024:
# Calcolo la frequenza, numero di pixel per ogni classe 
fS2024 <- freq(mS2024c)
fS2024
# Calcolo proporzione numero di pixel rispetto al totale e percentuale
totS2024 <- ncell(mS2024c) # calcolo del totale
totS2024
propS2024 = fS2024 / totS2024 # frequenza diviso tot
percS2024 = propS2024 * 100 # percentuale

# calcolo il numero di pixel che costituiscono il campo lavico
Campolavico = 336254-225896 
Campolavico
