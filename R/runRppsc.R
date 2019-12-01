
#run shiny app
runRppsc <- function() {
  appDir <- system.file("shiny-scripts","Rppsc",
                        package = "Rppsc")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
