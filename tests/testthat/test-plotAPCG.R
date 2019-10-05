context("Ploting all protein compostion")
library(Rppsc)
test_that("return a data frame object with correct nunmber of rows", {

  file <- system.file("data/proSeq.rda",package = "Rppsc")

  ob <-  plotAPCG(file)
  expect_that(length(ob), equals(2))

})
