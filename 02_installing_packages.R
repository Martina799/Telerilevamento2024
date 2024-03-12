# installing new packages in R
# PACCHETTI PRESENTI
# Pacchetto terra
# Pacchetto devtools
# Pacchetto imageRy

install.packages("terra") # funzione per installare i pacchetti install.packages()
# NB: ogni volta che prendiamo un pacchetto va sempre messo tra virgolette, il pacchetto viene preso da CRAN
# se quando faccio sta roba qui mi chiede da quale città, devo scegliene una a caso
# tramite la funzione library il pacchetto viene installato su R e controlla se è stato installato bene
# se voglio rimuovere un pacchetto utilizzo: remove.packages()
library(terra)

install.packages("devtools")
library(devtools) 

# install the imageRy package from GitHub: install_github, serve aver installato devtools che è sul CRAN
# a devtools function: va nel github di qualcuno e vede se c'è la funzione
devtools::install_github("ducciorocchini/imageRy") # per far vedere dove arrivano le funzioni uso :: (questa deriva dal pacchetto devtools)

library(imageRy) # dentro install.github trovo imageRy
# utile per avere funzioni in modo veloce
