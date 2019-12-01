
#'Plot Composition Graph
#'
#'A function that plots the composition of protein sequence given one attribute
#'at a time. Attributes include hydrophobicity, van der Waals volume, polarity,
#'polarizability, and desolvation
#'
#' @param file input csv file containing the protein name and sequence
#' @param type integer, indicates one attribute for plotting the composition
#' different Attributes are listed below:
#' 1: hydrophobicity
#' 2: van der Waals volume
#' 3: polarity
#' 4: polarizability
#' 5: desolvation
#'
#' @return
#' This function returns a composition graph given the attribute type.
#'
#' @examples
#' filepath = "./data/proSeq.rda"
#' p <- plotCG(filepath,type = 1) # default type is to show hydrophobicity composition
#'
#'
#' @export
#' @import ggplot2
#' @import protr
#' @import utils

library(utils)

plotCG <- function(file = "",type = 1) {
  #prepare data: from composition double to table
  if(!(type<6 & type>0 & type %% 1== 0)) {
    stop("Invalid value. Should be integer between 1-5")
  }
#  if(!(file_test("-f",file))){
#    stop("Invalid file path.")
#    return()
#  }
  if (!require("ggplot2")) {
    install.packages("ggplot2")
    library(ggplot2)
  }
  if (!require("protr")) {
    install.packages("protr")
    library(protr)
  }
  #load(file)
  if (file == ""){

  }
  proSeq = data.frame(lapply(proSeq, as.character), stringsAsFactors=FALSE)
  tsize = nrow(proSeq)
  pname = NULL
  pdata = NULL
  category = NULL


  for(i in 1:tsize ) {

    if(is.null(pname)){
      pname = proSeq[i,1]
      pdata = data.matrix(extractCTDC (proSeq[i,2]))
      hydro = data.matrix(extractCTDC (proSeq[i,2]))[1:3,1]
      vdm = data.matrix(extractCTDC (proSeq[i,2]))[4:6,1]
      pol = data.matrix(extractCTDC (proSeq[i,2]))[7:9,1]
      polabil =data.matrix(extractCTDC (proSeq[i,2]))[10:12,1]
      desol = data.matrix(extractCTDC (proSeq[i,2]))[19:21,1]


    }else{
      pname = rbind(pname, proSeq[i,1],row.names = NULL)
      pdata = cbind(pdata, data.matrix(extractCTDC (proSeq[i,2])),row.names = NULL)
      hydro = cbind(hydro, data.matrix(extractCTDC (proSeq[i,2]))[1:3,1],row.names = NULL)
      vdm = cbind(vdm, data.matrix(extractCTDC (proSeq[i,2]))[4:6,1],row.names = NULL)
      pol =cbind(pol, data.matrix(extractCTDC (proSeq[i,2]))[7:9,1],row.names = NULL)
      polabil =cbind(polabil, data.matrix(extractCTDC (proSeq[i,2]))[10:12,1],row.names = NULL)
      desol = cbind(desol, data.matrix(extractCTDC (proSeq[i,2]))[19:21,1],row.names = NULL)
    }

  }
  len_type = switch(type, hydro, vdm, pol, polabil, desol)
  attrname = switch(type, c("Polar","Neutral","Hydrophobic"),
                    c("van der Waals 0-2.78 ",
                      "van der Waals 2.95-4.0",
                      "van der Waals 4.03-8.08"),
                    c("polarity 4.9-6.2 ",
                      "polarity 8.0-9.2",
                      "polarity 10.4-13.0"),
                    c("Polarizability 0-1.08 ",
                      "Polarizability 0.128-0.186",
                      "Polarizability 0.219-0.409"),
                    c("Buried ","Exposed","Intermediate"))

  supp=rep(pname, each=3)
  len=c(len_type)
  dataf <- data.frame(supp=rep(c(pname), each=3),category=rep(attrname, tsize),len=hydro)
    p = ggplot(data=dataf, aes(x=supp, y=len, fill=category)) +
    geom_bar(stat="identity") +

    ggtitle("Protein Sequence composition")

  return(p)


}


