#' Search FP7 publications
#'
#' @export
#' @param fp7 Search for publications associated to a FP7 project with the 
#' given grant number
#' @param doi Gets the publications with the given DOIs
#' @param publication_id Gets the publication with the given openaire 
#' identifier, if any.
#' @param from_date Gets the publications whose date of acceptance is greater 
#' than or equal the given date. Allowed values: date formatted as YYYY-MM-DD.
#' @param to_date Gets the publications whose date of acceptance is less than 
#' or equal the given date. Allowed values: date formatted as YYYY-MM-DD.
#' @param title Publication title
#' @param author Search for publications by authors
#' @param raw (logical) return raw text or not. Default: `FALSE`
#' @inheritParams roa_datasets
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
#'
#' @examples \dontrun{
#' # Search for FP7 grant-supported publications
#' my_pubs <- roa_pubs(fp7 = "283595")
#' # Show how many of them are Open Access
#' table(my_pubs$Access)
#' 
#' # publication id
#' # roa_pubs(publication_id = )
#' 
#' # dataset id
#' # roa_pubs(dataset_id = )
#' 
#' # Search by doi
#' roa_pubs(doi = "10.1051/0004-6361/201220935")
#' 
#' # provider id
#' # roa_pubs(provider_id = )
#' 
#' # project id
#' # roa_pubs(project_id = )
#' 
#' # has_project boolean
#' roa_pubs(has_project = FALSE, size = 10)
#' roa_pubs(has_project = TRUE, size = 10)
#' 
#' # publication id
#' # roa_pubs(publication_id = )
#'
#' 
#' # curl options
#' x <- roa_pubs(doi = "10.1051/0004-6361/201220935", verbose = TRUE)
#' }
roa_pubs <- function(fp7 = NULL, publication_id = NULL, dataset_id = NULL, 
  doi = NULL, provider_id = NULL, project_id = NULL, has_project = NULL, 
  oa = NULL, title = NULL, author = NULL, from_date = NULL, 
  to_date = NULL, size = 1000, sort_by = NULL, sort_order = NULL, 
  format = "tsv", raw = FALSE, ...) {

  check_format(format)
  if (!is.null(sort_order)) {
    if (!is.null(sort_by)) {
      sort_by <- paste(sort_by, sort_order, sep = ",")
    }
  }
  args <- comp(list(
    FP7ProjectID = fp7, openaireDatasetID = dataset_id,
    openairePublicationID = publication_id,
    doi = doi, openaireProviderID = provider_id,
    openaireProjectID = project_id, title = title,
    author = author, hasProject = has_project,
    OA = oa, fromDateAccepted = from_date,
    toDateAccepted = to_date, size = size, sortBy = sort_by,
    format = format
  ))
  assert_args(args)
  out <- tt_GET(path = "search/publications", query = args, ...)
  tt_parse(out, format, raw)
}
