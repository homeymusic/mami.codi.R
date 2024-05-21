#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param min_amplitude An optional minimum amplitude for deciding which signals to include
#' @param spatial_tolerance An optional tolerance value for creating rational fractions for spatial signals
#' @param temporal_tolerance An optional tolerance value for creating rational fractions for temporal signals
#' @param metadata User-provided list of metadata that roundtrips with each call.
#' helpful for analysis and plots
#' @param verbose Determines the amount of data to return from chord evaluation
#' TRUE is all and FALSE is just major-minor, consonance-dissonance, tolerance and metadata.
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @return Major-Minor and Consonance-Dissonance plus additional information
#' if verbose=TRUE
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(
    x,
    min_amplitude      = MIN_AMPLITUDE,
    spatial_tolerance  = RATIO_TOLERANCE,
    temporal_tolerance = RATIO_TOLERANCE,
    metadata           = NA,
    verbose            = FALSE,
    ...
) {

  parse_input(x, ...)                                                        %>%
    compute_consonance(min_amplitude, spatial_tolerance, temporal_tolerance) %>%
    format_output(metadata, verbose)

}
MIN_AMPLITUDE = 0.00
RATIO_TOLERANCE = 0.0725

#' Parse Input
#'
#' Parses the chord to analyse, coerced to hrep::sparse_fr_spectrum
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to hrep::sparse_fr_spectrum
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @rdname parse_input
#' @export
parse_input <- function(x, ...) {

  UseMethod('parse_input', x)

}

#' @rdname parse_input
#' @export
parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...), ...)

}

#' @rdname parse_input
#' @export
parse_input.sparse_fr_spectrum <- function(x, ...) {

  tibble::tibble_row(
    spectrum    = list(x)
  )

}

compute_consonance = function(x, min_amplitude, spatial_tolerance, temporal_tolerance) {

  f = x$spectrum[[1]] %>%
    dplyr::filter(.data$y>min_amplitude) %>%
    hrep::freq()
  c_sound = max(f) / max(1/f)
  l = c_sound / f

  x %>% dplyr::mutate(
    estimate_periodicity(l, spatial_tolerance) %>%
      dplyr::rename_with(~ paste0('spatial_',.)),
    estimate_periodicity(f, temporal_tolerance) %>%
      dplyr::rename_with(~ paste0('temporal_',.)),
    consonance_dissonance = .data$temporal_consonance + .data$spatial_consonance,
    major_minor           = .data$temporal_consonance - .data$spatial_consonance,
    frequencies           = list(f),
    wavelengths           = list(l),
    speed_of_sound        = c_sound,
    min_amplitude,
    spatial_tolerance,
    temporal_tolerance
  )

}

estimate_periodicity <- function(x, tolerance, pitch) {
  r = ratios(x, tolerance)

  tibble::tibble_row(
    gcd_num    = gcd(r$num),
    lcm_den    = lcm(r$den),
    gcd_whole  = .data$gcd_num / .data$lcm_den,
    lcm_num    = lcm(r$num),
    gcd_den    = gcd(r$den),
    lcm_whole  = .data$lcm_num / .data$gcd_den,
    consonance = .data$gcd_whole,
    ratios     = list(r)
  )
}

gcd <- function(x) Reduce(gmp::gcd.bigz, x) %>% as.numeric()
lcm <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

format_output <- function(x, metadata, verbose) {
  x <- x %>% tibble::add_column(
    metadata=list(metadata)
  )

  if (verbose) {
    x
  } else {
    x %>%
      dplyr::select('major_minor',
                    'consonance_dissonance',
                    'spatial_tolerance',
                    'temporal_tolerance',
                    'min_amplitude',
                    'metadata')
  }
}
