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


