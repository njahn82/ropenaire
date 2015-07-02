# utility functions

tt_GET <- function(path, ...){
  if (is.null(path))
    stop("Nothing to parse")
  uri <- "http://api.openaire.eu/"
  # call api
  req <- httr::GET(uri, path = path, ...)
  # check for http status
  tt_check(req)
  req
}

tt_check <- function(req) {
  if (req$status_code < 400)
    return(invisible())
  stop("HTTP failure: ", req$status_code, "\n", call. = FALSE)
}
