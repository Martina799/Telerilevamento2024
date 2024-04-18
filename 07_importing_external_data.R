# How to import external data in R

library(terra)

# set the working directory based on your path: --> è la cartella dove stiamo lavorando, prendendo come esempio l'immagine dell'eclissi salvata (tasto dx e proprietà sull'immagine)
# setwd("youtpath") --> funzione del set della cartella di lavoro
# W***** users: C:\\path\Downloads -> C://path/Downloads
# My own: C:\Users\Martina\OneDrive - Alma Mater Studiorum Università di Bologna\Documents\UNIVERSITA'\TELERILEVAMENTO
setwd("/Downloads") # esempio 
setwd("C:/Users/Martina/OneDrive - Alma Mater Studiorum Università di Bologna/Documents/UNIVERSITA'/TELERILEVAMENTO") # dove ho salvato l'immagine dell'eclissi

# carichiamo ora l'immagine dell'eclissi:
eclissi <- rast("eclissi.png") # corrispondente di im.import() in imageRy, rast è una funzione di terra

# plot data
plotRGB(eclissi, 1, 2, 3) #R=1, G=2, B=3, se metto im.plot uso imageRy
# plotRGB(eclissi, 2, 1, 3) plotto un'immagine con le bande invertite

library(imageRy)
im.plotRGB(eclissi, 1, 2, 3)
dev.off()
par(mfrow=c(1,2)) # metto le due immagini, usando terra e imageRy
im.plotRGB(eclissi, 1, 2, 3)
plotRGB(eclissi, 1, 2, 3)    

# differenza tra banda 1 e 2
dif = eclissi[[1]] - eclissi [[2]] # utile per fare delle analisi di differenza tra le due immagini
plot(dif)

# esempio del prof
naja <- rast("najafiraq_etm_2003140_lrg.jpg")  # like in im.import()

plotRGB(naja, r=1, g=2, b=3) # im-plotRGB

# Exercise: Download the second image from the same site and import it in R
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3) # im-plotRGB
plotRGB(najaaug, r=1, g=2, b=3)

# multitemporal change detection
najadif = naja[[1]] - najaaug[[1]] 
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl)

# Download your own preferred image:
typhoon <- rast("mawar_vir2_2023144_lrg.jpg")

plotRGB(typhoon, r=1, g=2, b=3)
plotRGB(typhoon, r=2, g=1, b=3)
plotRGB(typhoon, r=3, g=2, b=1)


# The Mato Grosso image can be downloaded directly from EO-NASA:

mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3) 
plotRGB(mato, r=2, g=1, b=3) 
