context("testing roa_projects")

a <- roa_projects(org = "UGOE")

test_that("roa_projects returns correct class", {
  expect_is(a, "data.frame")
  expect_is(a$grantID, "character")
})
