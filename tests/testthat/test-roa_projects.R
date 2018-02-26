context("roa_projects")

test_that("roa_projects returns correct class", {
  skip_on_cran()

  a <- roa_projects(org = "UGOE", size = 5)

  expect_is(a, "data.frame")
  expect_is(a, "tbl_df")
  expect_is(a$grantID, "character")
  expect_equal(NROW(a), 5) 
})

test_that("roa_projects fails well", {
  expect_error(roa_projects(size = "adf"), 
    "size must be of class numeric, integer")
})

