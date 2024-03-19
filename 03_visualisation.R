# Satellite data visualisation in R usando imageRy
# RS data
# Pacchetti installati su R
library(imageRy)
library(terra)

# lista dei dati disponibili: qualsiasi funzione del pacchetto di imageRy inizia con im.
im.list() # in R vanno sempre usate le parentesi tonde
# Importing data
# Funzione per importare/utilizzare uno dei dati all'interno della lista: im.import("nomedato")
mato <- im.import("matogrosso_ast_2006209_lrg.jpg") # mato: oggetto
b2 <- im.import("sentinel.dolomites.b2.tif") # Immagine composta da tante bande (tanti sensori per ogni lunghezza d'onda)

# Voglio plottare i dati
plot(mato)

# Voglio cambiare la scala dei colori (scala dei grigi): 
# colorRampPalette(c("nomecolore1", "nomecolore2", "...")) (valore sfumatura)
# c() serve per concatenare e creare così l'array
# Tra parentesi il numero indica la sfumatura al passaggio da un colore all'altro
clg <- colorRampPalette(c("black", "grey", "lightgrey")) (1000)

# Plotto b2 con il colore che ho scelto in clg
plot(b2, col=clg)

# La roccia riflette tutte le bande colorate, mentre la vegetazione assorbe tutta la lunghezza 
# d'onda del blu (per il processo di fotosintesi)

# Importo le bande addizionali
# Importo la banda verde del Sentinel-2 (banda 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=clg)

# Importo la banda rossa del Sentinel-2 (banda 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=clg)

# Importo la banda del vicino infrarosso NIR del Sentinel-2 (banda 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=clg)

# Voglio mettere tutte le bande insieme in un unico plot --> multiframe
# Funzione par(mfrow=c(righe,colonne)) --> 2 righe e 2 colonne --> par(mfrow=c(2,2))
par(mfrow=c(2,2))
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

# Esercizio: plottare le 4 bande in una singola riga
par(mfrow=c(1,4))
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

# Considero le immagini come facenti parte di un unico array
stacksent <- c(b2, b3, b4, b8)
plot(stacksent, col=clg)

# Plotto solo un elemento specifico dell'array --> selezione l'elemento con la parentesi quadre
# Uso 2 parentesi quadre perchè sto lavorando con una matrice
# Plotto solo il quarto elemento --> banda 8
plot(stacksent[[4]], col=clg)

# Anniento l'immagine precedente --> dev.off()
# Cancello il comando par() precedente
dev.off()


# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, r=4, g=3, b=2)
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent)
