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
#' composition_plot <- plotAPCG(file = "proSeq")
#' protein_seq_plot
#'
#' @export
#' @import protr
#' @import gplots
#' @import utils

library(protr)
library(gplots)
library(utils)
library()

plotAPCG <- function(file = "proSeq") {
  #Validate file path
  if(!(file_test("-f",file)) & (file != "proSeq")){
    stop("Invalid file path.")
  }

  #load the default data or from validated file path
  if (file == "proSeq"){
    data("proSeq")
    protein_sequence = data.frame(lapply(proSeq, as.character), stringsAsFactors=FALSE)
  }else{
    raw_sequence = read.csv(filepath,header = TRUE,sep = ",")
    protein_sequence = data.frame(lapply(raw_sequence, as.character), stringsAsFactors=FALSE)
  }

  tsize = nrow(protein_sequence)
  colname = c("hydrophobicity","VWF Volume","polarity", "polarizability","desolvation")
  m = NULL
  for(i in 1:tsize ) {
    pdb = protein_sequence[i,1]
    pseq = protein_sequence[i,2]

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
  par(mar=c(8,2,2,0.5))
  mp = heatmap.2(scale(m), cexCol = 1, margins = c(8, 4))

  return(list(dm,mp))

}

