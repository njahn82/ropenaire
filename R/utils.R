# utility functions
oa_base <- function() "http://api.openaire.eu/"

`%||%` <- function(x, y) if (is.null(x)) y else x

comp <- function(x) Filter(Negate(is.null), x)

tt_GET <- function(path, ...){
  if (is.null(path)) stop("Nothing to parse")
  # call api
  cli <- crul::HttpClient$new(url = oa_base())
  req <- cli$get(path = path, ...)
  # check for http status
  req$raise_for_status()
  # tt_check(req)
  req
}

tt_check <- function(req) {
  if (req$status_code < 400)
    return(invisible())
  stop("HTTP failure: ", req$status_code, "\n", call. = FALSE)
}

# fixes
# fix double quotation in tsv
quote_fixing <- function(x){
  gsub('\"', '', x)
}
