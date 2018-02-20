context("roa_datasets")

test_that("roa_datasets works: format tsv", {
  skip_on_cran()

  a <- sm(roa_datasets(title = "methane", limit = 3))
  b <- sm(roa_datasets(fp7 = "247153", limit = 3))
  c <- sm(roa_datasets(fp7 = "00000", limit = 3))

  expect_is(a, "tbl_df")
  expect_equal(NCOL(a), 10)
  expect_equal(NROW(a), 3)

  expect_is(b, "tbl_df")
  expect_equal(NCOL(b), 10)
  expect_equal(NROW(b), 3)

  expect_is(c, "tbl_df")
  expect_equal(NCOL(c), 10)
  expect_equal(NROW(c), 0)
})

test_that("roa_datasets works: format json", {
  skip_on_cran()

  a <- sm(roa_datasets(title = "methane", limit = 3, format = "json"))

  expect_is(a, "list")
  expect_named(a, 'response')
  expect_named(a$response, c('header', 'results', 'browseResults'))
  expect_is(a$response$results$result, "data.frame")
  expect_is(a$response$results$result$metadata, "data.frame")
  expect_named(a$response$results$result$metadata, "oaf:entity")
})

# test_that("roa_datasets fails well", {
#   skip_on_cran()
# })
