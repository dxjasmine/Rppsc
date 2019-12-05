library(shiny)
library(Rppsc)

ui <- fluidPage(

  titlePanel("Rppsc: R Package for Plotting Protein Composition"),
  #File input box
  fileInput(inputId = "file1",
            label = "Select your sequence.fasta file",
            multiple = FALSE),
  #instruction text
  textOutput("txt"),
  #5 button for 5 different kind of composition map
  actionButton("hydrophobicity", "hydrophobicity"),
  actionButton("Van_Der_Waals", "Van Der Waals"),
  actionButton("polarity", "polarity"),
  actionButton("polarizability", "polarizability"),
  actionButton("desolvation", "desolvation"),
  hr(),
  plotOutput("composition_plot")
)

server <- function(input, output){
  #initialize a default vector for the function parameters
  v <- reactiveValues(
    filepath = "proSeq",
    type = NULL,
    circular_plot = TRUE
    )
  #change type when user hit different button
  observeEvent(input$hydrophobicity, {
    v$type <- 1
  })
  observeEvent(input$Van_Der_Waals, {
    v$type <- 2
  })
  observeEvent(input$polarity, {
    v$type <- 3
  })
  observeEvent(input$polarizability, {
    v$type <- 4
  })
  observeEvent(input$desolvation, {
    v$type <- 5
  })
  #generate the plot
  output$composition_plot <- renderPlot({
    if (is.null(v$type)) return()
    plotCG(file = v$filepath, type = v$type, circular_plot = v$circular_plot)

  })

  output$txt <- renderText({
    paste("Click the following button to see the corresponding protein composition")
  })
}

shinyApp(ui, server)

