TOLERANCE         = 0.063
MIN_AMPLITUDE     = 0.00
SPEED_OF_SOUND    = 343
ZARLINO           = 50
SMALLEST_POSSIBLE = .Machine$double.xmin

#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param metadata User-provided list of metadata that roundtrips with each call.
#' helpful for analysis and plots
#' @param verbose Determines the amount of data to return from chord evaluation
#' TRUE is all and FALSE is just major-minor, consonance-dissonance, tolerance and metadata.
#' @param spatial_tolerance An optional tolerance value for creating rational fractions for spatial signals
#' @param temporal_tolerance An optional tolerance value for creating rational fractions for temporal signals
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
    spatial_tolerance  = TOLERANCE,
    temporal_tolerance = TOLERANCE,
    metadata           = NA,
    verbose            = FALSE,
    ...
) {

  parse_input(x, ...)                %>%
    compute_wavelengths(min_amplitude)  %>%
    estimate_periodicities(
      spatial_tolerance,
      temporal_tolerance
    )                                %>%
    format_output(metadata, verbose)

}

#' Default Tolerance
#'
#' Default tolerance discovered by comparison with large-scale behavioral results
#'
#' @return Tolerance value
#'
#' @rdname default_tolerance
#' @export
default_tolerance <- function() {
  TOLERANCE
}

parse_input <- function(x, ...) {

  UseMethod('parse_input', x)

}

parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...), ...)

}

parse_input.sparse_fr_spectrum <- function(x, ...) {

  tibble::tibble_row(
    spectrum    = list(x)
  )

}

compute_wavelengths = function(x, min_amplitude) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>min_amplitude) %>% hrep::freq()
  c_sound = max(f) / max(1/f)
  l       = c_sound / f

  x %>% dplyr::mutate(
    frequencies    = list(f),
    wavelengths    = list(l),
    speed_of_sound = c_sound,
    min_amplitude
  )

}

estimate_periodicities <- function(
    x,
    spatial_tolerance,
    temporal_tolerance
) {

  f = x$frequencies[[1]]
  l = x$wavelengths[[1]]

  x <- x %>% dplyr::mutate(
    # estimate the spatial cycle
    estimate_periodicity(l,
                   spatial_tolerance) %>%
      dplyr::rename_with(~ paste0('spatial_',.)),

    # estimate the temporal cycle
    estimate_periodicity(f,
                   temporal_tolerance) %>%
      dplyr::rename_with(~ paste0('temporal_',.)),

    consonance_dissonance =
      .data$temporal_consonance + .data$spatial_consonance,

    major_minor =
      .data$temporal_consonance - .data$spatial_consonance,

    spatial_tolerance,
    temporal_tolerance

  )

}

estimate_periodicity <- function(x, tolerance, pitch) {
  r = ratios(x, tolerance)

  tibble::tibble_row(
    lcd        = lcm(r$den),
    dissonance = log2(.data$lcd),
    consonance = flip(.data$dissonance),
    ratios     = list(r)
  )

}

flip <- function(x) {
  flipped = ZARLINO - x
  if (is.na(flipped) | flipped < SMALLEST_POSSIBLE) {
    SMALLEST_POSSIBLE
  } else {
    flipped
  }
}

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

lcm <- function(x) Reduce(numbers::LCM, x)
