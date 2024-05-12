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
    min_amplitude        = MIN_AMPLITUDE,
    frequency_tolerance  = FREQUENCY_TOLERANCE,
    wavelength_tolerance = WAVELENGTH_TOLERANCE,
    metadata             = NA,
    verbose              = FALSE,
    ...
) {

  parse_input(x, ...)               %>%
    analyze_spectrum(min_amplitude) %>%
    process_pitch()                 %>%
    predict_consonance(
      frequency_tolerance,
      wavelength_tolerance
    )                               %>%
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

process_pitch = function(x) {

  f = x$frequencies[[1]]

  if (length(f) > 2) {

    analyzed_harmonics = f %>% analyze_harmonics()

    candidate_pseudo_octave = (analyzed_harmonics %>%
                                 dplyr::count(.data$pseudo_octave, sort=TRUE) %>%
                                 dplyr::slice(1))$pseudo_octave

    candidate_highest_fundamentals = analyzed_harmonics %>%
      dplyr::filter(dplyr::near(pseudo_octave, candidate_pseudo_octave), evaluation_freq == highest_freq) %>%
      dplyr::arrange(dplyr::desc(harmonic_number))

    highest_fundamental_frequency = candidate_highest_fundamentals[1,]$reference_freq

    highest_fundamental_frequency_partials = c(highest_fundamental_frequency,(analyzed_harmonics %>%
      dplyr::filter(
        .data$reference_freq == highest_fundamental_frequency &
          .data$pseudo_octave == candidate_pseudo_octave
      ))$evaluation_freq)

    c_sound = max(highest_fundamental_frequency_partials) / max(1/highest_fundamental_frequency_partials)

    highest_fundamental_wavelength = c_sound / highest_fundamental_frequency

    highest_fundamental_wavelength_partials = c_sound / highest_fundamental_frequency_partials

    x %>% dplyr::mutate(
      highest_fundamental_frequency,
      highest_fundamental_wavelength,
      highest_fundamental_frequency_partials = list(highest_fundamental_frequency_partials),
      highest_fundamental_wavelength_partials = list(highest_fundamental_wavelength_partials),
      num_harmonics = candidate_highest_fundamentals[1,]$harmonic_number,
      pseudo_octave = candidate_pseudo_octave
    )

  } else {

    c_sound = max(f) / max(1/f)
    highest_fundamental_frequency = max(f)
    highest_fundamental_wavelength = c_sound / highest_fundamental_frequency

    x %>% dplyr::mutate(
      highest_fundamental_frequency,
      highest_fundamental_wavelength,
      highest_fundamental_frequency_partials = list(highest_fundamental_frequency),
      highest_fundamental_wavelength_partials = list(highest_fundamental_wavelength),
      num_harmonics = 1,
      pseudo_octave = 2.0
    )

  }

}

predict_consonance <- function(
    x,
    frequency_tolerance,
    wavelength_tolerance
) {

  f = x$frequencies[[1]]
  l = x$wavelengths[[1]]

  x <- x %>% dplyr::mutate(
    # estimate the frequency cycle
    estimate_cycle(f,
                   x$pseudo_octave,
                   frequency_tolerance) %>%
      dplyr::rename_with(~ paste0('frequency_',.)),

    # estimate the wavelength cycle
    estimate_cycle(l,
                   x$pseudo_octave,
                   wavelength_tolerance) %>%
      dplyr::rename_with(~ paste0('wavelength_',.)),

    consonance_dissonance =
      .data$frequency_consonance + .data$wavelength_consonance,

    major_minor =
      .data$frequency_consonance - .data$wavelength_consonance,

    frequency_tolerance,

    wavelength_tolerance

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
      dplyr::select('major_minor', 'consonance_dissonance',
                    'frequency_tolerance', 'wavelength_tolerance',
                    'min_amplitude',
                    'metadata')
  }
}

lcm <- function(x) Reduce(numbers::LCM, x)

WAVELENGTH_TOLERANCE = 0.08
FREQUENCY_TOLERANCE  = 0.08

WAVELENGTH_MICRO_TOLERANCE = 0.0003
FREQUENCY_MICRO_TOLERANCE  = WAVELENGTH_MICRO_TOLERANCE / 2

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
  if (dimension == 'frequency') {
    if (scale == 'macro') {
      FREQUENCY_TOLERANCE
    } else if (scale == 'micro') {
      FREQUENCY_MICRO_TOLERANCE
    } else {
      stop("no default tolerance for selection")
    }
  } else if (dimension == 'wavelength') {
    if (scale == 'macro') {
      WAVELENGTH_TOLERANCE
    } else if (scale == 'micro') {
      WAVELENGTH_MICRO_TOLERANCE
    } else {
      stop("no default tolerance for selection")
    }
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
