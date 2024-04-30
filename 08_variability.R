# Measuring variability from satellite imagery

library(imageRy) # estraiamo qui il dato
library(terra)
# install.packages("viridis")
library(viridis) # mappe visibili a tutti, anche per chi soffre di daltonismo

im.list() # carichiamo il dato con questa funzione

sent <- im.import("sentinel.png") # plotta 4 immagini: il quarto verde non serve, servono le altre 3

im.plotRGB(sent, 1, 2, 3) # con questo plot in celeste abbiamo suolo nudo, in rosso vegetazione, nero acqua perchè assorbe tutto l'infrarosso (banda 1)

# le diverse bande:
# NIR = band 1
# red = band 2
# green = band 3

# infrarosso messo sul verde
im.plotRGB(sent, r=2, g=1, b=3) # posso scrivere la stessa cosa così usando le lettere 

# Calcoliamo ora la variabilità spettrale
nir <- sent[[1]]
cl <- colorRampPalette(c("black", "blue", "green", "yellow"))(4)
plot(nir, col=cl)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col=viridisc)

# Standard deviation 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# stack
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)
