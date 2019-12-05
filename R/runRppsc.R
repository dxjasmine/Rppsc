#' launch Rppsc shiny app
#'
#' A function launches the Rppsc Shiny app that allows the user to use the features
#' of Rppsc package in an interactive way.
#'
#'
#' @return null
#'
#' @examples
#' \dontrun{
#'   runRppsc()
#' }
#'
#'
#' @export
#' @importFrom shiny runApp
runRppsc <- function() {
  appDir <- system.file("shiny-scripts","Rppsc",
                        package = "Rppsc")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
