#' Get Radarr's System Status
#'
#' @inheritParams get_movies
#'
#' @return A `list`
#' @export
#' @import httr
#' @examples
#' \dontrun{
#' system_status()
#' }
system_status <- function(url = Sys.getenv("radarr_url"),
                          apikey = Sys.getenv("radarr_apikey")) {

  url = paste0(url, "/api/system/status")
  url <- parse_url(url)
  res <- content(GET(url, add_headers("X-Api-Key" = apikey)))

  res
}
