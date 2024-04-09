# quantifying land cover change --> copertura del suolo

# installiamo nuovi pacchetti:
# intsall.packages("ggplot2")
# intsall.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

# importing images
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # nell'immagine prendiamo i 3 colori come 3 diversi livelli energetici

# classifying images
sunc <- im.classify(sun, num_clusters=3) # num_clusters è il numero di classi che secondo noi ci sono, sun = nome immagine. quello che plotta è un'immagine con 3
# colori diversi a cui ogni colore rappresenta un diverso livello energetico (pixel classificati in base ai livelli)

# importing Mato grosso images --> faccio la stessa cosa utilizzando le immagini del matogrosso
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# classifying images --> classificazione delle due immagini
m1992c <- im.classify(m1992, num_clusters=2) # num_clusters=2 perchè vogliamo la classificazione nella foresta e sul suolo

# 1992
# class 1 = forest
# class 2 = human

m2006c <- im.classify(m2006, num_clusters=2)

# 2006
# class 1 = human
# class 2 = forest

# frequencies --> frequnza: calcolo il numero di pixel di suolo o di foresta
f1992 <- freq(m1992c)

# proportions
tot1992 <- ncell(m1992c)
prop1992 = f1992 / tot1992

# percentages
perc1992 = prop1992 * 100

# 17% human, 83% forest

# frequencies
f2006 <- freq(m2006c)

# proportions
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006

# percentages
perc2006 = prop2006 * 100

# 1992: 17% human, 83% forest
# 2006: 55% human, 45% forest

# let's build a dataframe
class <- c("forest", "human")
p1992 <- c(83, 17)
p2006 <- c(45, 55)

tabout <- data.frame(class, p1992, p2006)
tabout

# plotting the output
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")

# patchwork
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# varying axis and using lines
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
