# utility functions
oa_base <- function() "http://api.openaire.eu/"

`%||%` <- function(x, y) if (is.null(x)) y else x
`%|m|%` <- function(x, y) {
  if (length(x) == 0) return(y)
  if (is.null(x) || !nzchar(x)) y else x
}

comp <- function(x) Filter(Negate(is.null), x)

tt_GET <- function(path, query, ...) {
  if (is.null(path)) stop("No path provided")
  cli <- crul::HttpClient$new(url = oa_base(), opts = list(...))
  req <- cli$get(path = path, query = query)
  req$raise_for_status()
  return(req)
}

# fix double quotation in tsv
quote_fixing <- function(x){
  gsub('\"', '', x)
}

assert <- function(x, y, name = NULL) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      if (is.null(name)) name <- deparse(substitute(x))
      stop(name, " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

assert_arg <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(sub("x\\$", "", deparse(substitute(x))), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

assert_args <- function(x) {
  assert_arg(x$size, c('numeric', 'integer'))
}

tt_parse <- function(x, format, xml_fun, raw = FALSE) {
  if (raw) return(x$parse("UTF-8"))
  switch(
    format,
    json = {
      tmp <- tryCatch(
        jsonlite::fromJSON(x$parse("UTF-8")), 
        error = function(e) e
      )
      if (inherits(tmp, "error")) {
        stop("invalid JSON, try setting raw=TRUE")
      } else {
        return(tmp)
      }
    },
    tsv = suppressMessages(readr::read_tsv(x$content)),
    csv = suppressMessages(readr::read_csv(x$content)),
    # xml = xml2::read_xml(x$content),
    xml = xml_fun(x),
    stop("'format' must be of json, tsv, csv, or xml")
  )
}

xml_content <- function(x) {
  xml2::read_xml(x$content)   
}

check_format <- function(x) {
  assert(x, "character", "format")
  if (!x %in% c('json', 'xml', 'csv', 'tsv')) {
    stop("'format' must be one of json, xml, csv or tsv")
  }   
}
