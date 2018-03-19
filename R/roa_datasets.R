#' Search datasets
#'
#' OpenAIRE is collecting the metadata of research datasets
#' that are related to an open access publication in OpenAIRE or linked
#' to a funding stream
#'
#' @export
#' @param fp7 (character/numeric) Search for dataset associated to a FP7 
#' project with the given grant number
#' @param dataset_id Gets the dataset with the given openaire identifier,
#' if any
#' @param doi (character) Gets the publications with the given DOIs, if any
#' @param provider_id (character) Search for datasets by openaire data provider 
#' identifier. Alternatevely, it is possible to repeat the parameter for each 
#' provider id. In both cases, provider identifiers will form a query with OR 
#' semantics.
#' @param project_id (character) Search for publications by openaire project 
#' identifier. Alternatevely, it is possible to repeat the parameter for each 
#' provider id. In both cases, provider identifiers will form a query with OR 
#' semantics.
#' @param has_project (logical) If hasProject is true gets the datasets that 
#' have a link to a project. If hasProject is false gets the datasets with no 
#' links to projects.
#' @param oa (logical) Open access or not.
#' @param title (character) Publication title
#' @param author (character) Search for dataset by authors
#' @param from_date (character) Gets the dataset whose date of acceptance is
#' greater than or equal the given date. Allowed values: date formatted as 
#' YYYY-MM-DD.
#' @param to_date (character) Gets the dataset whose date of acceptance is 
#' less than or equal the given date. Allowed values: date formatted as 
#' YYYY-MM-DD.
#' @param sort_by (character) sort field, one of dateofcollection, 
#' resultstoragedate, resultembargoenddate, resultembargoendyear, 
#' resultdateofacceptance, resultacceptanceyear
#' @template common
#'
#' @references OpenAIRE API docs <http://api.openaire.eu/>
#'
#' @examples \dontrun{
#' # Search for FP7 grant-supported datasets
#' roa_datasets(fp7 = "247153", size = 10)
#'
#' # different formats
#' roa_datasets(title = "methane", size = 3, format = "json")
#' roa_datasets(title = "methane", size = 3, format = "tsv")
#' roa_datasets(title = "methane", size = 3, format = "csv")
#' roa_datasets(title = "methane", size = 3, format = "xml")
#' 
#' # sorting
#' roa_datasets(sort_by = "dateofcollection", sort_order = "descending", 
#'   size = 3)
#' # vs
#' roa_datasets(sort_by = "dateofcollection", sort_order = "ascending", 
#'   size = 3)
#'
#' # curl options
#' res <- roa_datasets(fp7 = "247153", size = 3, verbose = TRUE)
#' }
roa_datasets <- function(fp7 = NULL, dataset_id = NULL, doi = NULL,
  provider_id = NULL, project_id = NULL, has_project = NULL, oa = NULL,
  title = NULL, author = NULL, from_date = NULL, to_date = NULL, 
  model = NULL, fp7_scientific_area = NULL, has_ec_funding = NULL, 
  has_wt_funding = NULL, funder = NULL, funding_stream = NULL, 
  keywords = NULL, sort_by = NULL, sort_order = NULL, 
  size = 1000, page = NULL, format = "tsv", ...) {

  check_format(format)
  if (!is.null(sort_order)) {
    if (!is.null(sort_by)) {
      sort_by <- paste(sort_by, sort_order, sep = ",")
    }
  }
  assert_arg(model, "character")
  if (is.character(model)) if (model == "sygma") format <- "xml"
  args <- comp(list(
    FP7ProjectID = fp7, openaireDatasetID = dataset_id,
    doi = doi, openaireProviderID = provider_id,
    openaireProjectID = project_id, title = title,
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
  out <- tt_GET(path = "search/datasets", query = args, ...)
  tt_parse(out, format, xml_content)
}
