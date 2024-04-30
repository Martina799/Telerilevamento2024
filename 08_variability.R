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

# NB --> la variabilità si calcola su una variabile quindi su una sola banda!
# scegliamo la banda: PRENDIAMO IL VICINO INFRAROSSO

nir <- sent[[1]] # doppia parentesi quadra per riferirsi all'elemento che consideriamo, ovvero la banda nir 1
cl <- colorRampPalette(c("red", "orange", "yellow"))(3) # associamo colori diversi all'immagine, cambio i colori alle singole bande
plot(nir, col=cl)

# funzione FOCAL: tira fuori delle statistiche all'interno di un gruppo di valori (definisce finestra e funzione che vogliamo usare)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # definisco da sx a dx: funzione, nome immagine, definisco matrice (vettore bidimensionale)
# matrix(1/9,3,3) --> 9 = numero, 3x3 matrice, 1/9 è uno su 9 pixel (definisce il numero associato alla matrice)
# fun=sd: indico che la funzione che voglio utilizzare è la deviazione standard
plot(sd3)

# usiamo un pacchetto che permette di utilizzare una palette per daltonici
viridisc <- colorRampPalette(viridis(7))(256) # con 7 si intende la settima di una serie di palette disponibili, 256: sfumature disponibili
plot(sd3, col=viridisc)

# Standard deviation 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# stack: mettiamo le devizioni standard tutte insieme)
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)
# finestre di calcolo più grandi avremo una deviazione standard più alta, le immagini vengono fuori più "sfocate"
# non c'è una finestra più giusta, la finestra dipende semplicemente dal tipo dell'analisi che sto facendo
