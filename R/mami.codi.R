#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param minimum_amplitude An optional minimum amplitude for deciding which signals to include
#' @param precision An optional precision value for creating rational fractions
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
    minimum_amplitude = MINIMUM_AMPLITUDE,
    precision         = RATIONAL_FRACTION_PRECISION,
    metadata          = NA,
    verbose           = FALSE,
    ...
) {

  parse_input(x, ...)                                %>%
    compute_consonance(minimum_amplitude, precision) %>%
    format_output(metadata, verbose)

}

#' Default Precision
#'
#' Default precision for converting floating point numbers to rational fractions
#'
#''
#' @rdname default_precision
#' @export
default_precision <- function() { RATIONAL_FRACTION_PRECISION }
RATIONAL_FRACTION_PRECISION = 0.075

#' Default Minimum Amplitude
#'
#' Default minimum amplitude for deciding which tones are evaluated
#'
#''
#' @rdname default_minimum_amplitude
#' @export
default_minimum_amplitude <- function() { MINIMUM_AMPLITUDE }
MINIMUM_AMPLITUDE = 0.00

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

compute_consonance = function(x, minimum_amplitude, precision) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>minimum_amplitude) %>% hrep::freq()
  c_sound = max(f) / max(1/f)
  l       = c_sound / f

  x %>% dplyr::mutate(

    gcd( f / min(f), precision ) %>% dplyr::rename_with(~ paste0('temporal_',.)),
    temporal_consonance   = .data$temporal_gcd / 2,

    gcd( l / min(l), precision ) %>% dplyr::rename_with(~ paste0('spatial_',.)),
    spatial_consonance    = .data$spatial_gcd  / 2,

    consonance_dissonance = .data$temporal_consonance + .data$spatial_consonance,
    major_minor           = .data$temporal_consonance - .data$spatial_consonance,

    frequencies           = list(f),
    wavelengths           = list(l),
    speed_of_sound        = c_sound,
    minimum_amplitude,
    precision
  )

}

#' Greatest Common Divisor of Rational Numbers
#'
#'
#' See equation 15 in "Non-Integer Arrays for Array Signal Processing"
#' by Kulkarni and Vaidyanathan (2022)
#'
#' @param x Vector of rational numbers
#' @param precision Precision value for creating rational fractions
#'
#' @return The greatest common divisor of the rational numbers
#'
#' @rdname gcd
#' @export
gcd <- function(x, precision) {
  fractions = rational_fractions(x, precision)
  tibble::tibble_row(
    gcd_num   = gcd_integers(fractions$num),
    lcm_den   = lcm_integers(fractions$den),
    gcd       = .data$gcd_num / log2(.data$lcm_den + 1),
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
                    'metadata')
  }
}
