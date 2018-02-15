context("testing roa_datasets")

a <- roa_datasets(title = "methane")
b <- roa_datasets(fp7 = "247153")
c <- roa_datasets(fp7 = "00000")

test_that("roa_datasets returns correct class", {
  expect_is(a, "list")
  expect_named(a, "response")
  expect_is(a$response$results$result, "data.frame")
  expect_named(a$response$results$result$metadata, "oaf:entity")
})

test_that("roa_datasets returns correct class", {
  expect_is(b, "list")
})

test_that("roa_datasets returns correct object", {
  expect_is(c, "list")
  expect_null(c$response$results)
})
