context("Ploting Protein Sequence Composition")
library(Rppsc)

test_that("plotting a composiiton graph", {

  file = system.file("data/proSeq.rda",package = "Rppsc")
  type = 1

  p <- plotCG(file = system.file("data/proSeq.rda",package = "Rppsc"),type = 1)

  expect_true(is.ggplot(p))
  expect_that( p$labels$fill, equals("category"))
})

