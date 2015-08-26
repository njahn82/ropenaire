#' Search FP7 publications
#'
#' @param fp7 Search for publications associated to a FP7 project with the given grant number
#' @param limit limit number of records
#' @param doi Gets the publications with the given DOIs
#' @param id Gets the publication with the given openaire identifier, if any.
#' @param from_date Gets the publications whose date of acceptance is greater than or equal the given date.
#' Allowed values: date formatted as YYYY-MM-DD.
#' @param to_date Gets the publications whose date of acceptance is less than or equal the given date.
#' Allowed values: date formatted as YYYY-MM-DD.
#' @param title Publication title
#' @param author Search for publications by authors
#'
#' @param ... other API parameters \url{http://api.openaire.eu/}
#'
#' @export
#' @import httr
#' @import dplyr
#' @examples \dontrun{
#' # Search for FP7 grant-supported publications
#' my_pubs <- roa_pubs(fp7 = "283595")
#' Show how many of them are Open Access
#' table(my_pubs$Access)
#'
#' Search by doi
#' roa_pubs(doi = "10.1051/0004-6361/201220935")
#' }
roa_pubs <-
  function(fp7 = NULL, limit = 1000, id = NULL, doi = NULL, title = NULL, author = NULL, from_date = NULL,
           to_date = NULL, ...) {
    args <- list(
      FP7ProjectID = fp7,
      size = limit,
      id = id,
      doi = doi,
      title = title,
      fromDateAccepted = from_date,
      toDateAccepted = to_date,
      format = "tsv", ...
    )
    if (is.null(args))
      stop("empty query")
    out <- tt_GET(path = "search/publications", query = args) %>%
      content(quote = "")
    if (nrow(out) == 0)
      NULL
    else
      as.data.frame(sapply(out, function(x)
        gsub("\"", "", x)), stringsAsFactors  = FALSE)
  }

