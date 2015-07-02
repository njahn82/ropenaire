#' Get EC projects
#'
#' @param org Search for projects by participant institutions (acronym)
#' @param limit number of projects to be returned
#' @param ... other API parameters \url{http://api.openaire.eu/}
#'
#' @import XML
#' @export
#'
#' @examples
#' roa_projects(org = "UGOE")
roa_projects <- function(org = NULL, limit = 1000, ...){
  if(is.null(org))
    stop("No acronym provided")
  args <- list(participantAcronyms = org,
               size = limit,
               format = "xml", ...)
  tt_GET(path = "search/projects", query = args) %>%
    content  %>%
    parse_project %>%
    tbl_df
}

parse_project <- function(x){
  if(is.null(x))
    stop("no xml input to parse")
  xp_queries <- c(grantID = "//code",
                  acronym = "//acronym",
                  title = "//title",
                  startdate = "//startdate",
                  enddate = "//enddate",
                  callidentifier = "//callidentifier",
                  ecsc39 = "//ecsc39")

  as.data.frame(sapply(xp_queries, function(xp_queries) XML::xpathSApply(x, xp_queries, XML::xmlValue)), stringsAsFactors = FALSE)
}
