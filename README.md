
<!-- README.md is generated from README.Rmd. Please edit that file -->

# radarrr

The goal of `radarrr` is to get movies out of
[Radarr](https://github.com/Radarr/Radarr).

At this point, the package only provides one function: `get_movies`,
which returns a `tibble` of all the movies Radarr knows about. Nothing
less, nothing more, because that’s the only thing I’m really interested
in with the Radarr API.

## Installation

``` r
remotes::install_github("jemus42/radarrr")
```

To use it, it’s easiest to supply your API credentials via
`~/.Renviron`, like so:

``` sh
# radarr
radarr_url=http://radarr.mydomain.tld
radarr_apikey=thisisanalphanumericstring
```
