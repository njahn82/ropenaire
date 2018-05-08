#' @param size (integer) number of records
#' @param page (integer) page number of the search results
#' @param sort_order (character) sort order. one of ascending or descending. 
#' optional
#' @param model (character) The data model of the response. Options: 
#' "openaire" or "sygma". Model "sygma" is a simplified version of the 
#' "openaire" model. For sygma, only the xml format is available. See 
#' the relative XML schema 
#' (<https://www.openaire.eu/schema/sygma/oaf_sygma_v2.1.xsd>). 
#' Default: "openaire". Unfortunately, passing "model=openaire" leads to
#' no results AFAICT, so this parameter is left as `NULL` for now.
#' If you pass `model=sygma` we force `format=xml` (see above)
#' @param fp7_scientific_area (character) Search for FP7 entities by 
#' scientific area
#' @param has_ec_funding (logical) If `TRUE` gets the entities funded by the 
#' EC. If `FALSE` gets the entities related to projects not funded by the EC.
#' @param has_wt_funding (logical) If `TRUE` gets the entities funded by 
#' Wellcome Trust. The results are the same as those obtained with 
#' `funder="wt"`. If `FALSE` gets the entities related to projects not 
#' funded by Wellcome Trust.
#' @param funder (character) Search for entities by funder. One of WT, EC, 
#' ARC, ANDS, NSF, FCT, NHMRC
#' @param funding_stream (character) xx
#' @param keywords (character) vector of keywords
#' @param format (character) format to return, one of json, xml, csv 
#' or tsv (default)
#' @param ... curl options passed on to [crul::HttpClient]
