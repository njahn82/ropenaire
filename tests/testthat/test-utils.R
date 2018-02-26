context("utilties")

load("utils_obs.rda")

test_that("tt_parse function", {
    expect_is(tt_parse(utils_obs$json, "json"), "list")

    expect_is(sm(tt_parse(utils_obs$tsv, "tsv")), "tbl_df")
    expect_is(sm(tt_parse(utils_obs$csv, "csv")), "tbl_df")

    expect_identical(
        sm(tt_parse(utils_obs$tsv, "tsv")),
        sm(tt_parse(utils_obs$csv, "csv"))
    )

    expect_is(tt_parse(utils_obs$xml, "xml"), "xml_document")

    ## fails well
    expect_error(tt_parse("foo bar"), "argument \"format\" is missing")
    expect_error(tt_parse("foo bar", "stuff"),
        "'format' must be of json, tsv, csv, or xml")
})
