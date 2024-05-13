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
#' @param tolerance An optional tolerance value for creating rational fractions
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
    spatial_tolerance  = SPATIAL_TOLERANCE,
    temporal_tolerance = TEMPORAL_TOLERANCE,
    metadata           = NA,
    verbose            = FALSE,
    ...
) {

  parse_input(x, ...)               %>%
    analyze_spectrum(min_amplitude) %>%
    process_pseudo_octave()         %>%
    predict_consonance(spatial_tolerance, temporal_tolerance)   %>%
    format_output(metadata, verbose)

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

analyze_spectrum = function(x, min_amplitude) {

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

process_pseudo_octave= function(x) {

  f = x$frequencies[[1]]

  if (length(f) > 2) {

    analyzed_harmonics = f %>% analyze_harmonics()

    candidate_pseudo_octave = (analyzed_harmonics %>%
                                 dplyr::count(.data$pseudo_octave, sort=TRUE) %>%
                                 dplyr::slice(1))$pseudo_octave

    x %>% dplyr::mutate(
      pseudo_octave = candidate_pseudo_octave
    )

  } else {

    x %>% dplyr::mutate(
      pseudo_octave = 2.0
    )

  }

}

predict_consonance <- function(
    x,
    spatial_tolerance,
    temporal_tolerance
) {

  f = x$frequencies[[1]]
  l = x$wavelengths[[1]]

  x <- x %>% dplyr::mutate(
    # estimate the temporal cycle
    estimate_cycle(f,
                   x$pseudo_octave,
                   temporal_tolerance) %>%
      dplyr::rename_with(~ paste0('temporal_',.)),

    # estimate the spatial cycle
    estimate_cycle(l,
                   x$pseudo_octave,
                   spatial_tolerance) %>%
      dplyr::rename_with(~ paste0('spatial_',.)),

    consonance_dissonance =
      .data$temporal_consonance + .data$spatial_consonance,

    major_minor =
      .data$temporal_consonance - .data$spatial_consonance,

    spatial_tolerance,
    temporal_tolerance


  )

}

estimate_cycle <- function(x, pseudo_octave, tolerance, pitch) {
  r = ratios(x, pseudo_octave, tolerance)

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

SPATIAL_TOLERANCE  = 0.05
TEMPORAL_TOLERANCE = 0.08

MICRO_TOLERANCE = 1e-04

MIN_AMPLITUDE  = 0.03

SPEED_OF_SOUND = 343

ZARLINO        = 50

SMALLEST_POSSIBLE = .Machine$double.xmin

#' Default Tolerance
#'
#'
#' @return Default tolerance
#'
#' @rdname default_tolerance
#' @export
default_tolerance <- function(dimension, scale) {
  if (dimension == 'spatial') {
    if (scale == 'macro') {
      SPATIAL_TOLERANCE
    } else if (scale == 'micro') {
      MICRO_TOLERANCE
    } else {
      stop("no default tolerance for this spatial scale")
    }
  } else if (dimension == 'temporal') {
    if (scale == 'macro') {
      TEMPORAL_TOLERANCE
    } else if (scale == 'micro') {
      MICRO_TOLERANCE
    } else {
      stop("no default tolerance for this temporal scale")
    }
  } else {
    stop("no default tolerance for this dimension")
  }
}

#' Default Minimum Amplitude
#'
#'
#' @return Default tolerance
#'
#' @rdname default_min_amplitude
#' @export
default_min_amplitude <- function() {
  MIN_AMPLITUDE
}
