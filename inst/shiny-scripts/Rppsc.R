library(shiny)


# Define UI ----
ui <- fluidPage(
  titlePanel("Rppsc: R Package for Plotting Protein Composition"),
  sidebarLayout(
    sidebarPanel(
      actionButton("go", "Go"),
      actionButton("plot_botton","Show compisiton plot"),

      numericInput("n", "n", 1),


      choice_list=list("hydrophobicity" = 1, "polarity"=2),
      checkboxGroupInput(inputId = "check_id",
                         label = "choose chemical attributes for composition analysis",
                         choices =  choice_list,
                         selected = choice_list),
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
      #actionButton("plot_botton","Show compisiton plot"),
      textOutput("selected_var"),
      plotOutput("plot2")


    )
  )





)

# Define server logic ----
server <- function(input, output) {


  randomVals <- eventReactive(input$go, {
    input$n
  })



  randomVals2 <- eventReactive(
    input$plot_button, {
    input$chem
  })

  output$selected_var <- renderText({
    paste("You have selected", randomVals2())
  })
  output$plot2 <- renderPlot({

    plotCG(file = "",type = randomVals2())
  })





}

# Run the app ----
shinyApp(ui = ui, server = server)

#reference
