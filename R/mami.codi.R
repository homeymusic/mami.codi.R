#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param min_amplitude An optional minimum amplitude for deciding which signals to include
#' @param spatial_precision An optional precision value for creating rational fractions for spatial signals
#' @param temporal_precision An optional precision value for creating rational fractions for temporal signals
#' @param metadata User-provided list of metadata that roundtrips with each call.
#' helpful for analysis and plots
#' @param verbose Determines the amount of data to return from chord evaluation
#' TRUE is all and FALSE is just major-minor, consonance-dissonance, precision and metadata.
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
    spatial_precision  = RATIONAL_FRACTION_PRECISION,
    temporal_precision = RATIONAL_FRACTION_PRECISION,
    metadata           = NA,
    verbose            = FALSE,
    ...
) {

  parse_input(x, ...)                                                        %>%
    compute_consonance(min_amplitude, spatial_precision, temporal_precision) %>%
    format_output(metadata, verbose)

}
MIN_AMPLITUDE = 0.00
RATIONAL_FRACTION_PRECISION = 0.02

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

compute_consonance = function(x, min_amplitude, spatial_precision, temporal_precision) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>min_amplitude) %>% hrep::freq()
  P       = 1 / f
  c_sound = max(P) / max(1/P)
  l       = c_sound / P

  x %>% dplyr::mutate(
    gcd(P/min(P), temporal_precision) %>% dplyr::rename_with(~ paste0('temporal_',.)),
    temporal_consonance   = .data$temporal_gcd / 2,
    gcd(l/min(l), spatial_precision) %>% dplyr::rename_with(~ paste0('spatial_',.)),
    spatial_consonance    = .data$spatial_gcd  / 2,
    consonance_dissonance = .data$temporal_consonance + .data$spatial_consonance,
    major_minor           = .data$temporal_consonance - .data$spatial_consonance,
    frequencies           = list(f),
    periods               = list(P),
    wavelengths           = list(l),
    speed_of_sound        = c_sound,
    min_amplitude,
    spatial_precision,
    temporal_precision
  )

}

gcd <- function(x, precision) {
  fractions = rational_fractions(x, precision)
  tibble::tibble_row(
    gcd_num   = gcd_integers(fractions$num),
    lcm_den   = lcm_integers(fractions$den),
    gcd       = gcd_num / lcm_den,
    fractions = list(fractions)
  )
}

gcd_integers <- function(x) Reduce(gmp::gcd.bigz, x) %>% as.numeric()
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

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
                    'spatial_precision',
                    'temporal_precision',
                    'min_amplitude',
                    'metadata')
  }
}
