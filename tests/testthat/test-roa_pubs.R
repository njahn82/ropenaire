context("roa_pubs")

test_that("roa_pubs works correctly", {
  skip_on_cran()

  a <- suppressWarnings(roa_pubs(fp7 = 307535, size = 5))
  b <- roa_pubs(fp7 = 218816, size = 5)
  
  expect_is(a, "data.frame")
  expect_is(a, "tbl_df")
  expect_is(a$Title, "character")
  expect_is(a$DOI, "character")
  expect_is(a$`Publication Year`, "Date")
  expect_equal(NROW(a), 5)

  expect_is(b, "data.frame")
  expect_is(b, "tbl_df")
  expect_is(b$Title, "character")
  expect_is(b$DOI, "character")
  expect_is(b$`Publication Year`, "Date")
  expect_equal(NROW(b), 5)
})

test_that("roa_pubs fails well", {
  expect_error(roa_pubs(size = "adf"), 
    "size must be of class numeric, integer")
  expect_error(roa_pubs(format = "foobar"), 
    "'format' must be one of")
  expect_error(roa_pubs(format = 5), 
    "format must be of class character")
})
