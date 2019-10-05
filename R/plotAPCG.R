#' Plot All Protein Composition Graph
#'
#' A function that plots a comprehensive composition mapping given a protein list.
#' The composition descriptors includes hydrophobicity, van der Waals volume,
#' polarity, polarizability and desolvation. A hierarchical row and column clustering
#' will also be displayed on the side to showing the similarity analysis
#'
#' @param file input csv file containing the list of pdb id and sequence
#'
#' @return
#' This function returns a matrix of composition descriptor infomation as well as
#' a full composition graph given the proteins.
#'
#' @examples
#' f = system.file("data/proSeq.rda",package = "Rppsc")
#' p <- plotAPCG(f)
#' p
#'
#' @export
#' @import protr
#' @import gplots
#' @import utils
plotAPCG <- function(file = "data/proSeq.rda") {
  if(!(file_test("-f",file))){
    warning("Invalid file path.")
    return()
  }
  if (!require("protr")) {
    install.packages("protr")
    library(protr)
  }
  if (!require("gplots")) {
    install.packages("gplots")
    library(gplots,warn.conflicts = FALSE)
  }
  load(file)
  proSeq = data.frame(lapply(proSeq, as.character), stringsAsFactors=FALSE)
  #proseq = read.table(file, header = TRUE, sep= ",",colClasses=c("character"))
  tsize = nrow(proSeq)
  colname = c("hydrophobicity","vwfVolume","polarity", "polarizability","desolvation")
  m = NULL
  for(i in 1:tsize ) {
    pdb = proSeq[i,1]
    pseq = proSeq[i,2]

    pdata = extractCTDC (pseq)

    hydro = pdata[[3]]
    vdw = (pdata[[4]]*2.78+pdata[[5]]*4+pdata[[6]]*8.08)/3
    pol= (pdata[[7]]*6.2+pdata[[8]]*9.2+pdata[[9]]*13.0)/3
    polarizability = (pdata[[10]]*1.08+pdata[[11]]*0.186+pdata[[12]]*0.409)/3
    desol = pdata[[19]]

    if (is.null(m)){
      m = matrix(c(hydro,vdw, pol, polarizability, desol), nrow = 1,ncol= 5, dimnames = list(pdb, colname))
    }else{
      subm = matrix(c(hydro,vdw, pol, polarizability, desol), nrow = 1,ncol= 5, dimnames = list(pdb, colname))
      m = rbind(m,subm)
    }

  }
  dm = as.data.frame(m)
  mp = heatmap.2(scale(m))

  return(list(dm,mp))

}

