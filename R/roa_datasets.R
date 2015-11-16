#' Search datasets
#'
#' @details  OpenAIRE is collecting the metadata of research datasets
#' that are related to an open access publication in OpenAIRE or linked to a funding stream
#'
#' @param fp7 Search for dataset associated to a FP7 project with the given grant number
#' @param limit limit number of records
#' @param id Gets the dataset with the given openaire identifier, if any.
#' @param from_date Gets the dataset whose date of acceptance is greater than or equal the given date.
#' Allowed values: date formatted as YYYY-MM-DD.
#' @param to_date Gets the dataset whose date of acceptance is less than or equal the given date.
#' Allowed values: date formatted as YYYY-MM-DD.
#' @param title Publication title
#' @param author Search for dataset by authors
#'
#' @param ... other API parameters \url{http://api.openaire.eu/}
#'
#' @export
#' @import httr
#' @import dplyr
#' @examples \dontrun{
#' # Search for FP7 grant-supported datasets
#' roa_datasets(fp7 = "247153")
#'
#' roa_datasets(title = "methane")
#' }
roa_datasets <-
  function(fp7 = NULL, limit = 1000, id = NULL, title = NULL, author = NULL,
           from_date = NULL, to_date = NULL, ...) {
    args <- list(
      FP7ProjectID = fp7,
      size = limit,
      id = id,
      # doi = doi,
      # doi is currently not supported by openaire; returns empty value
      title = title,
      fromDateCollected = from_date,
      toDateCollected = to_date,
      format = "tsv", ...
    )
    if (is.null(args))
      stop("empty query")
    out <- tt_GET(path = "search/publications", query = args) %>%
      content(quote = "")
    if (nrow(out) == 0)
      NULL
    else
      dplyr::mutate_each(out, funs(quote_fixing))
  }
