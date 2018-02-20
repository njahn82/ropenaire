# utility functions
oa_base <- function() "http://api.openaire.eu/"

`%||%` <- function(x, y) if (is.null(x)) y else x

comp <- function(x) Filter(Negate(is.null), x)

tt_GET <- function(path, ...) {
  if (is.null(path)) stop("Nothing to parse")
  cli <- crul::HttpClient$new(url = oa_base())
  req <- cli$get(path = path, ...)
  req$raise_for_status()
  return(req)
}

# fix double quotation in tsv
quote_fixing <- function(x){
  gsub('\"', '', x)
}

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

tt_parse <- function(x, format) {
  switch(
    format,
    json = jsonlite::fromJSON(x$parse("UTF-8")),
    tsv = readr::read_tsv(x$content),
    csv = readr::read_csv(x$content),
    xml = xml2::read_xml(x$content),
    stop("'format' must be of josn, tsv, csv, or xml")
  )
}
