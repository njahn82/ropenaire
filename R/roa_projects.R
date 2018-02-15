#' Get EC projects
#'
#' @param grant_id Gets the project with the given grant identifier, if any
#' @param title Name of the project
#' @param acronym Acronym
#' @param call_id Search for projects by call identifier
#' @param start_year Gets the projects that started in the given year. Format: YYYY
#' @param end_year Gets the projects that ended in the given year. Format: YYYY
#' @param country Search for projects by participant countries. Foramt: 2-letter country code
#' @param org Search for projects by participant institutions (acronym)
#' @param limit number of projects to be returned
#' @param ... other API parameters \url{http://api.openaire.eu/}
#'
#' @export
#'
#' @examples \dontrun{
#' roa_projects(org = "UGOE")
#'
#' roa_projects(call_id = "FP7-PEOPLE-2010-IRSES")
#' }
roa_projects <- function(grant_id = NULL, title = NULL, acronym = NULL,
                         call_id = NULL, start_year = NULL, end_year = NULL,
                         country = NULL, org = NULL, limit = 1000, ...) {
  args <- list(
    participantAcronyms = org,
    grantID = grant_id,
    name = title,
    acronym = acronym,
    callID = call_id,
    startYear = start_year,
    endYear = end_year,
    participantCountries = country,
    size = limit,
    format = "xml", ...
  )
  if (is.null(args))
    stop("empty query")
  out <- tt_GET(path = "search/projects", query = args) %>%
    content  %>%
    parse_project
  as.data.frame(out, stringsAsFactors = FALSE)
}

parse_project <- function(x) {
  if (is.null(x))
    stop("no xml input to parse")
  xp_queries <- c(
    grantID = "//code",
    acronym = "//acronym",
    title = "//title",
    startdate = "//startdate",
    enddate = "//enddate",
    callidentifier = "//callidentifier",
    ecsc39 = "//ecsc39",
    funding_level_0 = "//funding_level_0/name"
#    funding_level_1 = "//funding_level_1/name",
#    funding_level_2 = "//funding_level_2/name"
  )
  sapply(xp_queries, function(xp_queries)
    XML::xpathSApply(x, xp_queries, XML::xmlValue))
}
