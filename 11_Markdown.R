---
title: "Vignette"
author: "Martina Mirenda"
date: "2024-05-16"
output:
  pdf_document: default
  html_document: default
---
# My first markdown document!

This file contains functions for R scripting in Geo-ecological Remote Sensing.

We are going to take use of the following packages:

```{r}
library(imageRy)
library(terra)
library(viridis)
```

In order to visualize the list of data use:

```{r, eval=T}
im.list()
```

In order to import data we can use the following function:
```{r, eval=T}
mato <- im.import("matogrosso_l5_1992219_lrg.jpg")
```
This plot is related to the following bands: band 1 = NIR, band 2 = RED, band 3 = GREEN.

We can change the visualization by changing the order of bands in  the RGB space,as:

We are using a set from Mato Grosso, and we can plot it in a RGB space, as:
```{r, eval=T}
im.plotRGB(mato, 2, 1, 3)
```

In order to look at different band combinations altogether we can use:
```{r, eval=T}
par(mfrow=c(1,3))
im.plotRGB(mato, 1, 2, 3)
im.plotRGB(mato, 2, 1, 3)
im.plotRGB(mato, 3, 2, 1)
```

##Calculating spectral indices
```{r, eval=T}
dvi<- mato[[1]]-mato[[2]]
plot(dvi, col=viridis(100))
```

##Calculating spatial variability
```{r, eval=T}
sd5 <- focal(mato[[1]], matrix(1/25, 5, 5), fun=sd)
plot(sd5, col=magma(100))
```
