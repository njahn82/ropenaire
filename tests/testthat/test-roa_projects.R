context("roa_projects")

test_that("roa_projects returns correct class", {
  skip_on_cran()

  a <- roa_projects(org = "UGOE", size = 5)

  expect_is(a, "data.frame")
  expect_is(a, "tbl_df")
  expect_is(a$grantID, "character")
  expect_named(a, c('grantID', 'acronym', 'title', 'startdate', 
    'enddate', 'callidentifier', 'ecsc39', 'funding_level_0')) 
})

test_that("roa_projects works with eg that used to fail due to missing data", {
  skip_on_cran()

  a <- roa_projects(keywords = "open science", start_year = "2009")

  expect_is(a, "data.frame")
  expect_is(a, "tbl_df")
  expect_gt(NROW(a), 0)
})

test_that("roa_projects fails well", {
  expect_error(roa_projects(size = "adf"), 
    "size must be of class numeric, integer")
})

