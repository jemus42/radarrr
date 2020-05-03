#' Get All Radarr Movies
#'
#' @param unpack If `TRUE`(default), result is unpacked to return a flat `tibble`.
#' @param progress If `TRUE` (default) and `unpack == TRUE`,
#' displays a progress bar via [dplyr::progress_estimated] during unpacking.
#' @return a [tibble][tibble::tibble-package]
#' @export
#' @import httr
#' @importFrom purrr map_df
#' @importFrom dplyr progress_estimated
#' @source https://github.com/Radarr/Radarr/wiki/API:Movie
#' @examples
#' \dontrun{
#' movies <- get_movies()
#' }
get_movies <- function(unpack = TRUE, progress = TRUE) {

  res <- radarr_get("/api/movie")

  if (unpack) {
    if (progress) {
      pb <- progress_estimated(length(res), min_time = 0)
    } else {
      pb <- NULL
    }

    map_df(res, extract_movie, .pb = pb)
  } else {
    res
  }
}

#' @keywords internal
#' @importFrom tibble tibble
#' @importFrom purrr pluck
#' @importFrom lubridate ymd_hms
extract_movie <- function(movie, .pb = NULL) {
  if ((!is.null(.pb)) && inherits(.pb, "Progress") && (.pb$i < .pb$n)) .pb$tick()$print()

  tibble(
    title = movie$title,
    sortTitle = movie$sortTitle,
    sizeOnDisk = movie$sizeOnDisk,
    status = movie$status,
    inCinemas = pluck(movie, "inCinemas", .default = NA),
    physicalRelease = pluck(movie, "movie$physicalRelease", .default = NA),
    physicialReleaseNote = pluck(movie, "physicalReleaseNote", .default = NA),
    downloaded = movie$downloaded,
    year = movie$year,
    hasFile = movie$hasFile,
    studio = pluck(movie, "studio", .default = NA),
    profileId = movie$profileId,
    pathState = movie$pathState,
    isAvailable = movie$isAvailable,
    folderName = pluck(movie, "folderName", .default = NA),
    runtime = movie$runtime,
    cleanTitle = movie$cleanTitle,
    imdbId = pluck(movie, "imdbId", .default = NA),
    tmdbId = pluck(movie, "tmdbId", .default = NA),
    added = ymd_hms(movie$added),
    file_movieId = pluck(movie, "movieFile", "movieId", .default = NA),
    file_relativePath = pluck(movie, "movieFile", "relativePath", .default = NA),
    file_size = pluck(movie, "movieFile", "size", .default = NA),
    file_dateAdded = ymd_hms(pluck(movie, "movieFile", "dateAdded", .default = NA)),
    file_releaseGroup = pluck(movie, "movieFile", "releaseGroup", .default = NA),
    file_quality = pluck(movie, "movieFile", "quality", "quality", "name", .default = NA),
    mediainfo_videoCodec = pluck(movie, "movieFile", "mediaInfo", "videoCodec", .default = NA),
    mediainfo_videoBitrate = pluck(movie, "movieFile", "mediaInfo", "videoBitrate", .default = NA),
    mediainfo_videoBitDepth = pluck(movie, "movieFile", "mediaInfo", "videoBitDepth", .default = NA),
    mediainfo_width = pluck(movie, "movieFile", "mediaInfo", "width", .default = NA),
    mediainfo_height = pluck(movie, "movieFile", "mediaInfo", "height", .default = NA),
    mediainfo_audioFormat = pluck(movie, "movieFile", "mediaInfo", "audioFormat", .default = NA),
    mediainfo_audioBitrate = pluck(movie, "movieFile", "mediaInfo", "audioBitrate", .default = NA),
    mediainfo_runtime = pluck(movie, "movieFile", "mediaInfo", "runTime", .default = NA),
    mediainfo_audioStreamCount = pluck(movie, "movieFile", "mediaInfo", "audioStreamCount", .default = NA),
    medainfo_audioChannels = pluck(movie, "movieFile", "mediaInfo", "audioChannels", .default = NA),
    mediainfo_audioLanguages = paste0(pluck(movie, "movieFile", "mediaInfo", "audioLanguages", .default = NA))
  )
}
