# spectral indices

library(imageRy)
library(terra)

# list of files: 
im.list()

# importing data
# https://visibleearth.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil/35892l sito di immagini
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #"matogrosso_l5_1992219_lrg.jpg" uso questa immagine, immagine Landsat.
# per creare questa immagine hanno utilizzato le bande riporatate in seguito:
# band 1 = nir = R (infrarosso vicino)
# band 2 = red = G
# band 3 = green = B

im.plotRGB(m1992, 1, 2, 3)  # funzione di plot dell'immagine che dice a R come plottarle con i dati colori

# Exercise: put the nir ontop of the G component, infrarosso su G
im.plotRGB(m1992, 2, 1, 3) #le parti rosa sono quelle dove la vegetazione non c'è

# nir ontop of the B component
im.plotRGB(m1992, 2, 3, 1) #per far vedere in giallo le aree di suolo spoglio in cui l'uomo ha interagito

# importing the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
par(mfrow=c(1,2))
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m2006, 1, 2, 3)

# nir on the green component of RGB 
im.plotRGB(m2006, 2, 1, 3)
# nir on the blue component of RGB
im.plotRGB(m2006, 2, 3, 1)

# multiframe
par(mfrow=c(2,3)) # mettiamo le immagini insieme
im.plotRGB(m1992, 1, 2, 3) # nir on R 1992
im.plotRGB(m1992, 2, 1, 3) # nir on G 1992
im.plotRGB(m1992, 2, 3, 1) # nir on B 1992
im.plotRGB(m2006, 1, 2, 3) # nir on R 2006
im.plotRGB(m2006, 2, 1, 3) # nir on G 2006
im.plotRGB(m2006, 2, 3, 1) # nir on B 2006

# calculating the DVI (Difference vegetation index)
dvi1992 = m1992[[1]] -m1992[[2]]  # uguale perchè è un'operazione matematica in cui prendo ogni singolo pixel della banda e lo sottraggo con 
# il pixel della banda del rosso, sottraiamo quindi la banda numero 1 meno la banda numero 2
# DVI varia da 255 a -255, questo perchè 8bit sono 256 pixel
# la stessa formula si può utilizzare sapendo il nome delle bande: dvi1992=m1992$matagrosso-2219_lrg_1 - m199
dvi1992
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

dev.off() # e rifaccio rilancio il plot e mi ingrandisce l'immagine

m2006 <-- im.import("matogrosso_ast_2006209_lrg.jpg") #faccio la stessa cosa con l'immagine del 2006
# dvi 2006
dvi2006 = m2006[[1]] - m2006[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100) # il giallo è una delle radiazioni che si vede di più
plot(dvi2006, col=cl)

#esercizio: plot dvi1992 di fianco al dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

#facciamo una normalizzazione --> NDVI (nir - red / nir + red). se il nir è max 255-0/255+0= 1 che è il max
# se 0-255/0+255= -1, NDVI varia da 1 a -1
# Normalized Difference Vegetation Index
ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)    
plot(ndvi2006, col=cl) 
