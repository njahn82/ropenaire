context("testing roa_pubs")

a <- roa_pubs("307535")

test_that("roa_pubs returns correct class", {
  expect_is(a, "tbl_df")
  expect_is(a$Title, "character")
})
