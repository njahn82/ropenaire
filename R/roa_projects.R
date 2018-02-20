#' Get EC projects
#'
#' @export
#' @param grant_id Gets the project with the given grant identifier, 
#' if any
#' @param publication_id publication ID
#' @param title Name of the project
#' @param acronym Acronym
#' @param call_id Search for projects by call identifier
#' @param start_year Gets the projects that started in the given year. 
#' Format: YYYY
#' @param end_year Gets the projects that ended in the given year. 
#' Format: YYYY
#' @param country Search for projects by participant countries. Foramt: 
#' 2-letter country code
#' @param org Search for projects by participant institutions (acronym)
#' @param limit number of projects to be returned
#' @param sort_by sort field
#' @param ... curl options passed on to [crul::HttpClient]
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
#' 
#' @note `format` is hard coded to `xml` for now
#'
#' @examples \dontrun{
#' x <- roa_projects(org = "UGOE", limit = 10)
#' roa_projects(call_id = "FP7-PEOPLE-2010-IRSES")
#' 
#' # curl options
#' x <- roa_projects(org = "UGOE", limit = 10, verbose = TRUE)
#' }
roa_projects <- function(grant_id = NULL, publication_id = NULL, title = NULL, 
  acronym = NULL, call_id = NULL, start_year = NULL, end_year = NULL,
  country = NULL, org = NULL, limit = 1000, sort_by = NULL, ...) {
  
  args <- comp(list(grantID = grant_id, openairePublicationID = publication_id,
      name = title, acronym = acronym, callID = call_id, startYear = start_year,
      endYear = end_year, participantAcronyms = org,
      participantCountries = country, size = limit, sortBy = sort_by, 
      format = "xml"))
  if (is.null(args)) stop("empty query")
  out <- tt_GET(path = "search/projects", query = args, ...)
  res <- tt_parse(out, format)
  as.data.frame(parse_project(res), stringsAsFactors = FALSE)
}

parse_project <- function(x) {
  xp_queries <- c(
    grantID = "//code",
    acronym = "//acronym",
    title = "//title",
    startdate = "//startdate",
    enddate = "//enddate",
    callidentifier = "//callidentifier",
    ecsc39 = "//ecsc39",
    funding_level_0 = "//funding_level_0/name"
  )
  lapply(xp_queries, function(z) {
    xml2::xml_text(xml2::xml_find_all(x, xpath = z))
  })
}
