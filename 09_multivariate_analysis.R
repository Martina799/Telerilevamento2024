# how to make multivariate analysis in R with remote sensing data

# im.pca funzione che andremo ad utilizzare --> compatta il set in poche dimensioni e restituisce le componenti
# PCA portare la l'immagine con tante bande a una sola

library(terra)
library(imageRy)
library(viridis) # for the final plot

im.list() # lista delle immagini/dati

# andiamo ad utilizzare le immagini di sentinel delle dolomiti
b2 <- im.import("sentinel.dolomites.b2.tif")  # banda numero 2 --> blu
b3 <- im.import("sentinel.dolomites.b3.tif")  # banda numero 3 --> verde
b4 <- im.import("sentinel.dolomites.b4.tif")  # banda numero 4 --> rosso
b8 <- im.import("sentinel.dolomites.b8.tif")  # banda numero 8 --> NIR, infrarosso vicino

# mettiamo insieme tutte le bande per comporre l'immagine
sentdo <- c(b2, b3, b4, b8) # c --> concatenate, metto insieme le 4 bande 

im.plotRGB(sentdo, 4, 3, 2) # visualizzo l'immagine, metto le 3 bande che ci interessano RED, GREEN, BLUE, l'immagine viene rossa NIR su red
im.plotRGB(sentdo, 3, 4, 2) # immagine verde, NIR su green

pairs(sentdo) # ci dice quanto le bande sono correlate tra di loro --> in generale ci dice la correlazione delle variabili

# PCA

# 1. Sample
# sample <- spatSample(sentdo, 100)
# sample

# 2. PCA
# pca <- prcomp(sample)

# variance explained
# summary(pca)

# 3. PCA map
# pcmap <- predict(sentdo, pca, index=c(1:4))

pcimage <- im.pca(sentdo)


# [1] 1552.56446  646.51287   47.47171   28.33535
tot <- sum(1552.56446, 646.51287, 47.47171, 28.33535)
1552.56446*100 / tot # faccio questo calcolo per ogni numero ottenuto e ottengo la percentuale
# dal primo numero viene fuori che la variabile è 68%


plot(pcimage, col=viridis(100)) # 100 è la sfumatura

plot(pcimage, col=magma(100))


# [1] 1719.25654  626.98962   54.63642   34.92315
tot <- sum(1719.25654,626.98962,54.63642,34.92315)
1719.25654*100 / tot

viridis <- colorRampPalette(viridis(7))(255)
plot(pcimage, col=viridis)

magma <- colorRampPalette(magma(7))(255)
plot(pcimage, col=magma)
