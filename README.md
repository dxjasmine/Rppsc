
# Rppsc

<!-- badges: start -->
<!-- badges: end -->
## Description

Rppsc is a package to plot protein sequence compostion. The goal of Rppsc is to visualize the protein sequence composition regarding different composition descriptor. The 5 attributes include hydrophobiciy, van der Waals volume, polarity, polarizability, and desolvation.

## Installation

You can install the released version of Rppsc package using:

``` r
require("devtools")
install_github("dxjasmine/Rppsc", build_vignettes = TRUE)
library("Rppsc")

#To run shinyApp
runRppsc()
```
## Overview
An overview of the package is demonstrated as below.
![](./inst/extdata/A1.png)
Reference:
Xiao et al. (2015) Comprehensive toolkit for generating various numerical features of protein sequences  <doi:10.1093/bioinformatics/btv042>

## Contribution

Functions in this package includes:

- plotCG()
- plotAPCG()

The function plotCG and plotAPCG were authored by Jiayan Wang. Both functions take advantage of the functions in the protr package and make visualization extention.

plotCG() function uses sequence composition analysis function in protr package. ggplot2 package is used to generate visualization of proteins composition. For each plot, one compositon descriptor is analyzed within multiple proteins. Part of the code for plotting the circular chart are adated from the R graph gallery for formating.

plotAPCG() calculates the average of the compositon descriptor data obtained from the function from protr package. gplot package is used to generate compositon mapping for multiple proteins with multiple attributes.

##compostion mapping regarding 5 attributes
##hydrophobicity, van der waal, polarity, polarizability
##desolvation, desolvation
Here is an example which shows you how to solve a common problem:

user can use their own csv file providing pdbid and seuquence
Default data --"proSeq" are also provided

``` r
library(Rppsc)
#  example code
#default data
hydrophobicity_plot <- plotCG(file = "proSeq", type= 1, circular_plot = TRUE)
hydrophobicity_plot #call to view the plot
polarity_plot <- plotCG(file = "proSeq", type= 3, circular_plot = TRUE)
polarity_plot
# full heat map of sequence composition of 5 attributes
all_prot_comp <- plotAPCG(file = "proSeq")
all_prot_comp
```

## Reference

Xiao, N., Cao, D.-S., Zhu, M.-F., & Xu, Q.-S. (2015). protr/ProtrWeb: R package and web server for
generating various numerical representation schemes of protein sequences. Bioinformatics, 31(11), 1857–1859.
https://doi.org/10.1093/bioinformatics/btv042

The R Graph Gallery -Circular barplot with groups. (2018).
Retrieved December 1, 2019, from https://www.r-graph-gallery.com/297-circular-barplot-with-groups.html
