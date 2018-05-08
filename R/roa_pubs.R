#' Search FP7 publications
#'
#' @export
#' @param fp7 (character) Search for publications associated to a FP7 project 
#' with the given grant number
#' @param publication_id (character) Gets the publication with the given 
#' openaire identifier, if any.
#' @param doi (character) Gets the publications with the given DOIs
#' @param provider_id (character) Search for datasets by openaire data provider
#' identifier. Alternatevely, it is possible to repeat the parameter for each 
#' provider id. In both cases, provider identifiers will form a query with OR 
#' semantics.
#' @param openaire_project_id (character) Search for publications by openaire project 
#' identifier. Alternatevely, it is possible to repeat the parameter for each 
#' provider id. In both cases, provider identifiers will form a query with OR 
#' semantics.
#' @param project_id (character) The given grant identifier of the project.
#' @param has_project (logical) If hasProject is true gets the datasets that 
#' have a link to a project. If hasProject is false gets the datasets with no 
#' links to projects.
#' @param oa (logical) Open access or not.
#' @param from_date (character) Gets the publications whose date of acceptance 
#' is greater than or equal the given date. Allowed values: date formatted as 
#' YYYY-MM-DD.
#' @param to_date (character) Gets the publications whose date of acceptance 
#' is less than or equal the given date. Allowed values: date formatted as 
#' YYYY-MM-DD.
#' @param title (character) Publication title
#' @param author (character) Search for publications by authors
#' @param sort_by (character) sort field, one of dateofcollection, 
#' resultstoragedate, resultstoragedate, resultembargoenddate, 
#' resultembargoendyear, resultdateofacceptance, resultacceptanceyear
#' @param raw (logical) return raw text or not. Default: `FALSE`
#' @template common
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
#'
#' @examples \dontrun{
#' # Search for FP7 grant-supported publications
#' my_pubs <- roa_pubs(fp7 = "283595")
#' # Show how many of them are Open Access
#' table(my_pubs$Access)
#' 
#' # Search by doi
#' roa_pubs(doi = "10.1051/0004-6361/201220935")
#' 
#' # has_project boolean
#' roa_pubs(has_project = FALSE, size = 10)
#' roa_pubs(has_project = TRUE, size = 10)
#' 
#' # curl options
#' x <- roa_pubs(doi = "10.1051/0004-6361/201220935", verbose = TRUE)
#' }
roa_pubs <- function(fp7 = NULL, publication_id = NULL, doi = NULL, 
  provider_id = NULL, project_id = NULL, openaire_project_id = NULL, 
  has_project = NULL, oa = NULL, title = NULL, author = NULL, 
  from_date = NULL,  to_date = NULL, model = NULL, fp7_scientific_area = NULL, 
  has_ec_funding = NULL, has_wt_funding = NULL, funder = NULL, 
  funding_stream = NULL, keywords = NULL, size = 1000, page = 1, 
  sort_by = NULL, sort_order = NULL, 
  format = "tsv", raw = FALSE, ...) {

  check_format(format)
  if (!is.null(sort_order)) {
    if (!is.null(sort_by)) {
      sort_by <- paste(sort_by, sort_order, sep = ",")
    }
  }
  assert_arg(model, "character")
  if (is.character(model)) if (model == "sygma") format <- "xml"
  args <- comp(list(
    FP7ProjectID = fp7, openairePublicationID = publication_id,
    doi = doi, openaireProviderID = provider_id,
    projectID = project_id, openaireProjectID = openaire_project_id, 
    title = title,
    author = author, hasProject = has_project,
    OA = oa, fromDateAccepted = from_date,
    toDateAccepted = to_date, model = model,
    FP7scientificArea = fp7_scientific_area, 
    hasECFunding = has_ec_funding,
    hasWTFunding = has_wt_funding, funder = funder, 
    fundingStream = funding_stream, keywords = keywords, 
    size = size, page = page, sortBy = sort_by, format = format
  ))
  assert_args(args)
  out <- tt_GET(path = "search/publications", query = args, ...)
  tt_parse(out, format, xml_content, raw)
}
