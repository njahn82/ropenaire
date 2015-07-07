#' Search FP7 publications
#'
#' @param fp7 Search for publications associated to a FP7 project with the given grant number
#' @param limit limit number of records
#' @param ... other API parameters \url{http://api.openaire.eu/}
#'
#' @export
#' @import httr
#' @import dplyr
#'
roa_pubs <- function(fp7 = NULL, limit = 1000, ...){
    if(is.null(fp7))
      stop("No project provided")
  args <- list(FP7ProjectID = fp7,
               size = limit,
               format = "tsv", ...)
  tt_GET(path = "search/publications", query = args) %>%
    content(quote = "") %>%
    tbl_df
}
