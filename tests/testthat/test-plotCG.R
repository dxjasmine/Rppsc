context("Ploting Protein Sequence Composition")
library(Rppsc)

test_that("plotting a composiiton graph", {

  file_path = "proSeq"
  type = 1

  p <- plotCG(file = file_path, type = type)

  expect_true(is.ggplot(p))
  expect_that( p$labels$fill, equals("category"))
})

test_that("correct number of categories", {

  file_path = "proSeq"
  type = 2

  p <- plotCG(file = file_path, type = type)

  expect_that(length(unique(p$data$category)), equals(3))
})


