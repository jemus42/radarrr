#' Get All Radarr Movies
#'
#' @param tmdbId `[NULL]` tmdb ID of the movie to get. Default gets all movies.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @importFrom dplyr mutate across
#' @importFrom lubridate ymd_hms ymd
#' @importFrom prettyunits pretty_bytes
#' @source https://radarr.video/docs/api/#/Movie/getMovie
#' @examples
#' \dontrun{
#' movies <- get_movies()
#' }
get_movies <- function(tmdbId = NULL) {

  res <- radarr_get("/api/v3/movie", tmdbId = tmdbId)
  res <- res %>%
    mutate(
      sizeOnDisk = prettyunits::pretty_bytes(.data$sizeOnDisk),
      added = lubridate::ymd(.data$added)
    ) %>%
    mutate(across(
      c("inCinemas", "physicalRelease", "digitalRelease", "added"),
      lubridate::ymd_hms
    )) %>%
    as_tibble()

  res
}
