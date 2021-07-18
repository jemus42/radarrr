#' Get history
#'
#' @param page 1-index page.
#' @param pageSize Number of items per page.
#'
#' @return a [tibble][tibble::tibble-package] with `page` rows and 6 columns.
#' @export
#'
#' @examples
#' \dontrun{
#' history <- get_history()
#' }
get_history <- function(page = 1, pageSize = 10) {
  res <- radarr_get("/api/v3/history", page = page, pageSize = pageSize)

  res <- tibble::as_tibble(res)
  res$records <- tibble::as_tibble(res$records)
  res$records$quality <- tibble::as_tibble(res$records$quality)
  res$records$quality$quality <- tibble::as_tibble(res$records$quality$quality)
  res$records$quality$revision <- tibble::as_tibble(res$records$quality$revision)

  res$records$data <- tibble::as_tibble(res$records$data)
  res$records$movie <- tibble::as_tibble(res$records$movie)
  res$records$movie$ratings <- tibble::as_tibble(res$records$movie$ratings)

  res

}
