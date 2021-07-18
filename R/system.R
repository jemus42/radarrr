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
  radarr_get("/api/v3/system/status")
}

#' Get failed health checks
#'
#' @return a tibble.
#' @export
#'
#' @examples
#' \dontrun{
#' health()
#' }
health <- function() {
  radarr_get("/api/v3/health") %>%
    as_tibble()
}

#' Get recent updates
#'
#' @return a tibble.
#' @export
#'
#' @examples
#' \dontrun{
#' update()
#' }
update <- function() {
  radarr_get("/api/v3/update") %>%
    as_tibble()
}

#' Get root folders
#'
#' @return a tibble.
#' @export
#'
#' @examples
#' \dontrun{
#' root_folder()
#' }
root_folder <- function() {
  res <- radarr_get("/api/v3/rootfolder") %>%
    as_tibble()

  if (requireNamespace("tidyr", quietly = TRUE)) {
    res <- tidyr::unchop(res, unmappedFolders)
  }

  res
}
