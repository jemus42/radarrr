#' Get Radarr's System Status
#'
#' @return A `list`
#' @export
#' @source https://github.com/Radarr/Radarr/wiki/API:System-Status
#' @examples
#' \dontrun{
#' system_status()
#' }
system_status <- function() {
  radarr_get("/api/system/status")
}
