#' Make a GET request to the Radarr API
#'
#' @param path The API path, e.g. `"/api/system/status"` (default).
#'
#' @return A list.
#' @export
#'
#' @examples
#' \dontrun{
#' radarr_get()
#' }
#'
radarr_get <- function(path = "/api/system/status") {

  url <- Sys.getenv("radarr_url")
  apikey <- Sys.getenv("radarr_apikey")

  url <- modify_url(url, path = "/api/system/status")
  res <- content(GET(url, add_headers("X-Api-Key" = apikey)))

  res
}
