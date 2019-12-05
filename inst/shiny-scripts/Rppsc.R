
library(shiny)

ui <- fluidPage(
  titlePanel("Rppsc: R Package for Plotting Protein Composition"),

  fileInput(inputId = "file1",
            label = "Select your sequence.fasta file",
            multiple = FALSE),
  textOutput("txt"),
  actionButton("hydrophobicity", "hydrophobicity"),
  actionButton("Van_Der_Waals", "Van Der Waals"),
  actionButton("polarity", "polarity"),
  actionButton("polarizability", "polarizability"),
  actionButton("desolvation", "desolvation"),

  hr(),
  plotOutput("composition_plot")
)

server <- function(input, output){
  v <- reactiveValues(
    filepath = "proSeq",
    type = NULL,
    circular_plot = TRUE
    )

  observeEvent(input$hydrophobicity, {
    v$type = 1
  })
  observeEvent(input$Van_Der_Waals, {
    v$type = 2
  })
  observeEvent(input$polarity, {
    v$type = 3
  })
  observeEvent(input$polarizability, {
    v$type = 4
  })
  observeEvent(input$desolvation, {
    v$type = 5
  })

  output$composition_plot <- renderPlot({
    if (is.null(v$type)) return()
    #plotCG(file = V$filepath, type = v$type, circular_plot = v$circular_plot)
    plotCG(file = v$filepath, type = v$type, circular_plot = v$circular_plot)

  })

  output$txt <- renderText({
    paste("Click the following button to see the corresponding protein composition")
  })
}

shinyApp(ui, server)

