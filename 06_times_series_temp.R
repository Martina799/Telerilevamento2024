# time series analysis
# secondo metodo per quantificare i cambiamenti nel tempo (il primo si basava sulla classificazione)

library(imageRy)
library(terra)

im.list()

# import the data: EN = European Nitrogen da gennaio (01) a marzo (13)
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow=c(2,1)) # se metti .auto, prende in automatico la prima, seconda e terza banda
im.plotRGB.auto(EN01) # si vede la differenza tra gennaio e marzo 2020
im.plotRGB.auto(EN13)

# fino ad adesso abbiamo importato delle immagini con 3 bande, facciamo ora la differenza tra due layer di due anni diversi (es: differenza tra i livelli 1
# delle due immagini, l'importante che siano della stessa banda)
# using the first element (band) of images --> differenza tra le due immagini
dif = EN01[[1]] - EN13[[1]] # seleziono la prima banda

# palette
cldif <- colorRampPalette(c("blue", "white", "red")) (100) # 100 numero di gradazioni
plot(dif, col=cldif) # ci dice quali punti dell'Europa hanno subito un cambiamento maggiore

dev.off() # visualizza l'immagine grande (devo rimettere su R le stringhe 23 e 24)


### New example: temperature in Greenland

g2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col=clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

# stacking the data
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

# Exercise: make the differencxe between the first and the final elemnts of the stack
difg <- stackg[[1]] - stackg[[4]]
# difg <- g2000 - g2015
plot(difg, col=cldif)

# Exercise: make a RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3)
