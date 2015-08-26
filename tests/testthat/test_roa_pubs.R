context("testing roa_pubs")

a <- roa_pubs("307535")
b <- roa_pubs(fp7 = "218816")

test_that("roa_pubs returns correct class", {
  expect_is(a, "data.frame")
  expect_is(b, "data.frame")
  expect_is(a$Title, "character")
})
