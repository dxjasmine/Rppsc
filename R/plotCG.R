#'Plot A protein Composition Graph
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
#' # defaul value is to show hydrophobicity composition in a circular plot
#' p <- plotCG(file = "proSeq",type= 1, circular_plot = TRUE )
#' p #call p to see the plot
#'
#' @references
#'The R Graph Gallery -Circular barplot with groups. (2018).Retrieved
#'December 1, 2019, from https://www.r-graph-gallery.com/297-circular-barplot-with-groups.html
#'
#' @export
#' @import ggplot2
#' @import protr
#' @import utils
plotCG <- function(file = "proSeq",type= 1, circular_plot = TRUE ) {

  library(utils)
  library(ggplot2)
  library(protr)

  #Check type value
  if(!(type<6 & type>0 & type %% 1== 0)) {
    stop("Invalid value. Should be integer between 1-5")
  }
  #validate file path
  if(!(file_test("-f",file)) & (file != "proSeq")){
      stop("Invalid file path.")
  }

  #load the default data or from validated file path
  if (file == "proSeq"){
    protein_sequence <- data.frame(lapply(proSeq, as.character), stringsAsFactors=FALSE)
  }else{
    raw_sequence <- read.csv(filepath,header = TRUE,sep = ",")
    protein_sequence <- data.frame(lapply(raw_sequence, as.character), stringsAsFactors=FALSE)
  }

  #get number of proteins in list
  protein_num <- nrow(protein_sequence)

  #all protein name
  protein_name <- NULL



  #loop over all proteins to get their protein composition by extractCTDC function
  #Data are stored in 5 categories: hydrophobiciy, van der Waals volume, polarity
  #polarizability,desolvation.
  for(i in seq_along(protein_sequence[,1]) ) {

    #initiation
    if(is.null(protein_name)){
      protein_name  <- protein_sequence[i,1]
      hydro  <- data.matrix(extractCTDC (protein_sequence[i,2]))[1:3,1]
      vdm  <- data.matrix(extractCTDC (protein_sequence[i,2]))[4:6,1]
      pol  <- data.matrix(extractCTDC (protein_sequence[i,2]))[7:9,1]
      polabil  <- data.matrix(extractCTDC (protein_sequence[i,2]))[10:12,1]
      desol  <- data.matrix(extractCTDC (protein_sequence[i,2]))[19:21,1]

    #add new data
    }else{
      protein_name  <- rbind(protein_name, protein_sequence[i,1],row.names = NULL)
      hydro  <- cbind(hydro, data.matrix(extractCTDC (protein_sequence[i,2]))[1:3,1],row.names = NULL)
      vdm  <- cbind(vdm, data.matrix(extractCTDC (protein_sequence[i,2]))[4:6,1],row.names = NULL)
      pol  <- cbind(pol, data.matrix(extractCTDC (protein_sequence[i,2]))[7:9,1],row.names = NULL)
      polabil  <- cbind(polabil, data.matrix(extractCTDC (protein_sequence[i,2]))[10:12,1],row.names = NULL)
      desol  <- cbind(desol, data.matrix(extractCTDC (protein_sequence[i,2]))[19:21,1],row.names = NULL)
    }

  }
  attr_name  <- switch(type,"hydrophobicity","VWF Volume","polarity", "polarizability","desolvation")
  #different attribute data selected according to type
  len_type  <- switch(type, hydro, vdm, pol, polabil, desol)
  #adding category name
  category_name  <- switch(type,
                    c("Polar","Neutral","Hydrophobic"),
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
  #3 sub categories for each category
  protein_data=rep(protein_name, each=3)

  len=c(len_type)

  #construct dataframe for plotting
  dataf <- data.frame(protein_data=rep(c(protein_name), each=3),
                      category=rep(category_name, protein_num),
                      len=hydro, row.names =NULL,stringsAsFactors=FALSE)

  #circular plot option
  #Some code in circular plot on formatting (clean grid and adjust size)
  #are adapted from the R graph gallery
  #https://www.r-graph-gallery.com/297-circular-barplot-with-groups.html
  if(circular_plot){
    p  <- ggplot(data = dataf,
               aes(x = protein_data, y = len, fill = category)) +
      geom_bar(stat = "identity") + ylim(-1, 1) + theme_minimal() +
      theme(
            plot.title = element_text(hjust = 0.5),
            axis.title = element_blank(),
            panel.grid = element_blank(), ) +
      coord_polar(start = 0) +
      ggtitle(paste("Protein Sequence composition of ",attr_name,sep = ""))
  # normal plot option
  }else{
    p <- ggplot(data=dataf,
               aes(x=protein_data, y=len, fill=category)) +
      geom_bar(stat="identity") +
      ggtitle(paste("Protein Sequence composition of ",attr_name,sep = ""))

  }

  return(p)


}
#Reference
#The R Graph Gallery -Circular barplot with groups. (2018).
#Retrieved December 1, 2019, from https://www.r-graph-gallery.com/297-circular-barplot-with-groups.html

