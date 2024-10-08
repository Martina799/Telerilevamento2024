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

# classifico le immagini in 3 classi
par(mfrow=c(1,2))
mS2023c <- im.classify(set2023N, num_clusters=3)
mS2024c <- im.classify(set2024N, num_clusters=3)

# Settembre 2023:
# Calcolo la frequenza, numero di pixel per ogni classe 
fS2023 <- freq(mS2023c)
fS2023
# Calcolo proporzione numero di pixel rispetto al totale e percentuale
totS2023 <- ncell(mS2023c) # calcolo del totale
totS2023
propS2023 = fS2023 / totS2023 # frequenza diviso tot
percS2023 = propS2023 * 100 # percentuale
percS2023

# Settembre 2024:
# Calcolo la frequenza, numero di pixel per ogni classe 
fS2024 <- freq(mS2024c)
fS2024
# Calcolo proporzione numero di pixel rispetto al totale e percentuale
totS2024 <- ncell(mS2024c) # calcolo del totale
totS2024
propS2024 = fS2024 / totS2024 # frequenza diviso tot
percS2024 = propS2024 * 100 # percentuale
percS2024

# calcolo il numero di pixel che costituiscono il campo lavico
Campolavico = 289041-184947 
Campolavico
propcampo = Campolavico / totS2024 # frequenza diviso tot
percCampolavico = propcampo* 100
percCampolavico

# Ordino i dati ottenuti in una tabella 4x5
classi<-c("suolo", "vegetazione", "H2O", "campo lavico")
frequenza2023<-c(358670, 309532, 184947, 0)
frequenza2024<-c(294505, 269603, 289041, Campolavico)
percentuale2023<-c(42, 36, 21, 0)
percentuale2024<-c(34, 32, 22, 12)
# Uso la funzione data.farme per creare la tabella
tabout <- data.frame(classi, frequenza2023, frequenza2024, percentuale2023, percentuale2024) 
tabout
View(tabout) # visualizzo la tabella


# Plotto un grafico (istogramma) utilizzando il pacchetto ggplot
# ggplot --> funzione
# tabout --> dati 
# aes --> estetica/costruzione del grafico
# geom_bar --> geometria del grafico, in questo caso istogramma
# stat=identity --> valore come è stato inserito
# fill --> colore
ggplot(tabout, aes(x=classi, y=percentuale2023, color=classi)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=classi, y=percentuale2024, color=classi)) + geom_bar(stat="identity", fill="white") 

# Utilizzo il pacchetto patchwork che permette di mettere i grafici a confronto
# correggo gli assi dei grafici con la funzione ylim(c(0,100)) --> y = da 0 a 100
p1 <- ggplot(tabout, aes(x=classi, y=percentuale2023, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=classi, y=percentuale2024, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) 
p1 + p2

dev.off()




# NDVI - Normalized Difference Vegetation Index

# NDVI (nir - red / nir + red)
ndviS2023 = (set2023N[[1]] - set2023N[[2]]) / (set2023N[[1]] + set2023N[[2]])
ndviM2024 = (mar2024N[[1]] - mar2024N[[2]]) / (mar2024N[[1]] + mar2024N[[2]])
ndviL2024 = (lug2024N[[1]] - lug2024N[[2]]) / (lug2024N[[1]] + lug2024N[[2]])
ndviS2024 = (set2024N[[1]] - set2024N[[2]]) / (set2024N[[1]] + set2024N[[2]])


cl <- colorRampPalette(c("yellow", "lightyellow", "white", "lightgreen", "darkgreen")) (100)
par(mfrow=c(2,2))
plot(ndviS2023, col=cl)    
plot(ndviM2024, col=cl) 
plot(ndviL2024, col=cl) 
plot(ndviS2024, col=cl)

# Metodo più rapido per calcolare NDVI --> im.ndvi(immagine, 1, 2)
NDVIS2023 <- im.ndvi(set2023N, 1, 2)
NDVIM2024 <- im.ndvi(mar2024N, 1, 2)
NDVIL2024 <- im.ndvi(lug2024N, 1, 2)
NDVIS2024 <- im.ndvi(set2024N, 1, 2)

stackNDVI <- c(NDVIS2023, NDVIM2024, NDVIL2024, NDVIS2024)
plot(stackNDVI, col=cl)

dev.off()




# Calcolo NDVI su immagini risalenti ad agosto 2024 prima e durante l'ultima eruzione:

# True color
ago162024 <- rast("2024-08-16-00_00_2024-08-16-23_59_Sentinel-2_L2A_True_color.jpg")
ago262024 <- rast("2024-08-26-00_00_2024-08-26-23_59_Sentinel-2_L2A_True_color.jpg")
# False color
ago162024N <- rast("2024-08-16-00_00_2024-08-16-23_59_Sentinel-2_L2A_False_color.jpg")
ago262024N <- rast("2024-08-26-00_00_2024-08-26-23_59_Sentinel-2_L2A_False_color.jpg")
# NDVI
ndviA1624 = (ago162024N[[1]] - ago162024N[[2]]) / (ago162024N[[1]] + ago162024N[[2]])
ndviA2624 = (ago262024N[[1]] - ago262024N[[2]]) / (ago262024N[[1]] + ago262024N[[2]])
 # Plot
par(mfrow=c(2,2))
plotRGB(ago162024, 1, 2, 3)
plot(ndviA1624, col=cl)
plotRGB(ago262024, 1, 2, 3)
plot(ndviA2624, col=cl) 





# VARIABILITA'

# Calcolo la variabilità dell'immagine utilizzando una singola banda (NIR, banda 1). 
# Il calcolo sfrutta il metodo della "moving window": costruisco, con una matrice da me impostata
# (es: matrix(1/9,3,3) --> matrice 3x3, 1/9=numero associato alla metrice, 1 su 9 pixel) 
# una finestra di calcolo che, applicata all'immagine, calcola la funzione che mi interessa,
# (in questo caso fun=sd --> deviazione standard) e l'associa al pixel centrale della mia finestra 3x3.
# Il procedimento si ripete per tutta l'immagine traslando la finestra di un pixel.

# Per fare tutto ciò utilizzo la funzione: FOCAL
# funzione FOCAL: tira fuori delle statistiche all'interno di un gruppo di valori 
# (definisce finestra e funzione che vogliamo usare)

# Raggruppo tutte le immagini NIR
stackNIR <- c(set2023N[[1]], mar2024N[[1]], lug2024N[[1]], set2024N[[1]])
# definisco la palette di colori
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(stackNIR, col=cl)

# Utilizzo la funzione FOCAL e calcolo la deviazione standard
sd <- focal(stackNIR, matrix(1/9, 3, 3), fun=sd)
plot(sd, col=viridisc)




# ANALISI MULTIVARIATA

# Per ogni immagine vado a creare gli stack delle bande che mi interessano:
# blu, verde, rosso, NIR
bset2023 <- c(set2023[[3]], set2023[[2]], set2023[[1]], set2023N[[1]])
bmar2024 <- c(mar2024[[3]], mar2024[[2]], mar2024[[1]], mar2024N[[1]])
blug2024 <- c(lug2024[[3]], lug2024[[2]], lug2024[[1]], lug2024N[[1]])
bset2024 <- c(set2024[[3]], set2024[[2]], set2024[[1]], set2024N[[1]])

# Funzione che calcola la correlazione delle variabili (bande) usando l'indice di Pearson
pairs(bset2023)
pairs(bset2024)
