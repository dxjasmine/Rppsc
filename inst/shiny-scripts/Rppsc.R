library(shiny)


# Define UI ----
ui <- fluidPage(
  titlePanel("Rppsc: R Package for Plotting Protein Composition"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(inputId = "check_id",
                         label = "Choose Chemical attribute:",
                         c("hydrophobicity"= "hydro","polarity"= "pol")),
      tableOutput("chem"),

      fileInput(inputId = "file1",
                label = "Select your sequence.fasta file",
                multiple = FALSE),

      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 25, min = 1, max = 100),
      plotOutput("hist")
    ),
    mainPanel(
      h1("Protein Composition plot"),
      plotOutput('plot2')
    )
  )





)

# Define server logic ----
server <- function(input, output) {
  plot2 = plotCG( )
  output$plot2 <- renderPlot({
    plot2
    #hist(rnorm(input$num))
  })

}

# Run the app ----
shinyApp(ui = ui, server = server)

#reference
