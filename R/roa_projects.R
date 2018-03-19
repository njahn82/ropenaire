#' Get EC projects
#'
#' @export
#' @param grant_id (character) Gets the project with the given grant 
#' identifier, if any
#' @param publication_id (character) publication ID
#' @param title (character) Name of the project
#' @param acronym (character) Gets the project with the given acronym, if any.
#' @param call_id (character) Search for projects by call identifier
#' @param start_year (numeric) Gets the projects that started in the given 
#' year. Format: YYYY
#' @param end_year (numeric) Gets the projects that ended in the given year. 
#' Format: YYYY
#' @param country (character) Search for projects by participant countries. 
#' Format: 2-letter country code
#' @param org (character) Search for projects by participant institutions 
#' (acronym)
#' @param sort_by (character) sort field, one of projectstartdate, 
#' projectstartyear, projectenddate, projectendyear, projectduration
#' @template common
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
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
  country = NULL, org = NULL, model = NULL, fp7_scientific_area = NULL, 
  has_ec_funding = NULL, has_wt_funding = NULL, funder = NULL, 
  funding_stream = NULL, keywords = NULL, sort_by = NULL, sort_order = NULL, 
  size = 1000, page = 1, format = "xml", ...) {
  
  if (!is.null(sort_order)) {
    if (!is.null(sort_by)) {
      sort_by <- paste(sort_by, sort_order, sep = ",")
    }
  }
  assert_arg(model, "character")
  if (is.character(model)) if (model == "sygma") format <- "xml"
  args <- comp(list(grantID = grant_id, openairePublicationID = publication_id,
    name = title, acronym = acronym, callID = call_id, startYear = start_year,
    endYear = end_year, participantAcronyms = org, model = model,
    FP7scientificArea = fp7_scientific_area, hasECFunding = has_ec_funding,
    hasWTFunding = has_wt_funding, funder = funder, 
    fundingStream = funding_stream, keywords = keywords,
    participantCountries = country, size = size, page = page, sortBy = sort_by, 
    format = format))
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
