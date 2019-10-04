#'Plot All Protein Composition Graph
#'
#' A function that plots a comprehensive composition mapping given protein list.
#' The composition descriptors includes hydrophobicity, van der Waals volume,
#' polarity, polarizability and desolvation.
#'
#' @param file input csv file containing list of protein name and sequence
#'
#' @return
#'This function returns a full composition graph given the proteins.
#'
#' @examples
#' p <- plotAPCG(file = "data/pdbSeq.csv")
#' print(p)
#'
#' @export
#' @import protr
plotAPCG <- function(file="protrdata/pdbSeq.csv") {


  proSeq = read.table("protrdata/pdbSeq.csv", header = TRUE, sep= ",",colClasses=c("character"))
  tsize = nrow(proSeq)
  #allpdb = unique(proSeq$pdb)
  #rowname = c(allpdb)
  colname = c("hydrophobicity","vwfVolume","polarity", "polarizability","desolvation")
  #m <- matrix(nrow = tsize,ncol= 5, dimnames = list(rowname, colname))
  #m <- matrix(data = NA, nrow = tsize,ncol= 5, dimnames = list(rowname, colname))
  m = NULL
  for(i in 1:tsize ) {
    pdb = proSeq[i,1]
    pseq = proSeq[i,2]
    if (!require("protr")) {
      install.packages("protr")
      library(protr)
    }
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
  install.packages("gplots")
  library(gplots)
  m= scale(m)
  heatmap.2(as.matrix(m))
  print(m)
  return(p)

}

