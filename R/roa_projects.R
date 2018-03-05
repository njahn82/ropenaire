#' Get EC projects
#'
#' @export
#' @param grant_id Gets the project with the given grant identifier, 
#' if any
#' @param publication_id publication ID
#' @param title Name of the project
#' @param acronym Gets the project with the given acronym, if any.
#' @param call_id Search for projects by call identifier
#' @param start_year Gets the projects that started in the given year. 
#' Format: YYYY
#' @param end_year Gets the projects that ended in the given year. 
#' Format: YYYY
#' @param country Search for projects by participant countries. Format: 
#' 2-letter country code
#' @param org Search for projects by participant institutions (acronym)
#' @param sort_by sort field, one of projectstartdate, projectstartyear, 
#' projectenddate, projectendyear, projectduration
#' @inheritParams roa_datasets
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
#' 
#' @note `format` is hard coded to `xml` for now
#'
#' @examples \dontrun{
#' roa_projects(org = "UGOE", size = 3)
#' roa_projects(call_id = "FP7-PEOPLE-2010-IRSES")
#' roa_projects(title = "open", size = 3)
#' 
#' # curl options
#' x <- roa_projects(org = "UGOE", size = 10, verbose = TRUE)
#' }
roa_projects <- function(grant_id = NULL, publication_id = NULL, title = NULL, 
  acronym = NULL, call_id = NULL, start_year = NULL, end_year = NULL,
  country = NULL, org = NULL, size = 1000, sort_by = NULL, sort_order = NULL, 
  ...) {
  
  if (!is.null(sort_order)) {
    if (!is.null(sort_by)) {
      sort_by <- paste(sort_by, sort_order, sep = ",")
    }
  }
  args <- comp(list(grantID = grant_id, openairePublicationID = publication_id,
      name = title, acronym = acronym, callID = call_id, startYear = start_year,
      endYear = end_year, participantAcronyms = org,
      participantCountries = country, size = size, sortBy = sort_by, 
      format = "xml"))
  assert_args(args)
  out <- tt_GET(path = "search/projects", query = args, ...)
  res <- tt_parse(out, 'xml')
  tibble::as_tibble(
    do.call("rbind", lapply(parse_project(res), as.data.frame, 
      stringsAsFactors = FALSE))
  )
}

xml_names <- c(
  grantID = "//code",
  acronym = "//acronym",
  title = "//title",
  startdate = "//startdate",
  enddate = "//enddate",
  callidentifier = "//callidentifier",
  ecsc39 = "//ecsc39",
  funding_level_0 = "//funding_level_0/name"
)

parse_project <- function(x) {
  results <- xml2::xml_find_all(x, xpath = '//results/result')
  lapply(results, function(z) {
    lapply(xml_names, function(w) {
      xml2::xml_text(xml2::xml_find_first(z, w))
    })
  })
}
