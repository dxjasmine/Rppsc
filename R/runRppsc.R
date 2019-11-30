
#run shiny app
runRppsc <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "TestingPackage")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
