context("Ploting all protein compostion")
library(Rppsc)



test_that("return a correct list object", {

  file_path = "proSeq"


  plot <-  plotAPCG(file_path)
  expect_true(is.list(plot))
})


test_that("The plot has five categories", {


  file_path = "proSeq"

  plot <-  plotAPCG(file_path)
  expect_that(length(plot$colInd), equals(5))

})
