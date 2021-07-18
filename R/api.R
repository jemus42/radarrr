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

  url <- modify_url(url, path = path, query = list(...))

  res <- GET(url, add_headers("X-Api-Key" = apikey))
  res <- content(res, "text", encoding = "UTF-8")
  jsonlite::fromJSON(res)

}
