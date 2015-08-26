context("testing roa_datasets")

a <- roa_datasets(title = "methane")
b <- roa_datasets(fp7 = "247153")
c <- roa_datasets(fp7 = "00000")

test_that("roa_datasets returns correct class", {
  expect_is(a, "data.frame")
  expect_is(a$Title, "character")
})

test_that("roa_datasets returns correct class", {
  expect_is(b, "data.frame")
})

test_that("roa_datasets returns correct object", {
  expect_null(c)
})
