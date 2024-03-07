# First R script

# R as a calculator
a <- 6*7
b <- 5*8
a+b

# Arrays: serie di dati concatenati tramite c()
flowers <- c(3, 6, 8, 10, 15, 18)  
# vettore che mi dice quanti fiori ho nel plot
flowers

insects <- c(10, 16, 25, 42, 61, 73)
insects

# metto in relazione i fiori con gli insetti. il prot mi plotta un grafico xy
plot(flowers, insects)
# pch mi permette di cambaire il simbolo dei parametri
plot(flowers, insects, pch=19)
# per variare la dimensione dei punti, symbol dimensions tramite cex (2 vuol dire che raddoppiano di grandezza, con .5 dimezzo i punti)
plot(flowers, insects, pch=19, cex=2)
# cambio il colore con col e le virgolette
plot(flowers, insects, pch=19, cex=2, col="chocolate1") #ciao
