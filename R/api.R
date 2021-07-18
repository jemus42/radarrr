#' Make a GET request to the Radarr API
#'
#' @param path The API path, e.g. `"/api/system/status"` (default).
#' @param ... Named arguments used as query parameters.
#'
#' @return A list.
#' @export
#' @importFrom jsonlite fromJSON
#' @examples
#' \dontrun{
#' radarr_get()
#' }
#'
radarr_get <- function(path = "/api/v3/system/status", ...) {

  url <- Sys.getenv("radarr_url")
  apikey <- Sys.getenv("radarr_apikey")

  url <- httr::modify_url(url, path = path, query = list(...))

  res <- httr::GET(url, httr::add_headers("X-Api-Key" = apikey))
  res <- httr::content(res, "text", encoding = "UTF-8")
  jsonlite::fromJSON(res)

}
