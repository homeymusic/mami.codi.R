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

  parse_input(x, ...)                       %>%
    listen_for_min_amplitude(min_amplitude) %>%
    listen_for_pseudo_octave()              %>%
    estimate_cycles(
      frequency_tolerance,
      wavelength_tolerance
    )                                       %>%
    rotate()                                %>%
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

listen_for_min_amplitude = function(x, min_amplitude) {

  f = x$spectrum[[1]] %>% dplyr::filter(.data$y>min_amplitude) %>% hrep::freq()
  s = max(f) / max(1/f)
  λ = s / f

  x %>% dplyr::mutate(
    frequencies = list(f),
    wavelengths = list(λ),
    speed_of_sound = s,
    min_amplitude
  )

}

listen_for_pseudo_octave = function(x) {

  f = x$frequencies[[1]]

  if (length(f) > 2) {
    x %>% dplyr::mutate(
      pseudo_octave = (f %>% listen_for_highest_fundamental() %>%
                         dplyr::count(.data$pseudo_octave, sort=TRUE) %>%
                         dplyr::slice(1))$pseudo_octave
    )
  } else {
    x %>% dplyr::mutate(
      pseudo_octave = 2.0
    )
  }

}

estimate_cycles <- function(
    x,
    frequency_tolerance,
    wavelength_tolerance
) {

  f = x$frequencies[[1]]
  λ = x$wavelengths[[1]]

  x %>% dplyr::mutate(
    # estimate the frequency cycle
    estimate_cycle(f,
                   x$pseudo_octave,
                   frequency_tolerance) %>%
      dplyr::rename_with(~ paste0('frequency_',.)),

    # estimate the wavelength cycle
    estimate_cycle(λ,
                   x$pseudo_octave,
                   wavelength_tolerance) %>%
      dplyr::rename_with(~ paste0('wavelength_',.)),

    frequency_tolerance,
    wavelength_tolerance

  )

}

estimate_cycle <- function(x, pseudo_octave, tolerance) {

  r = ratios(x, pseudo_octave, tolerance)

  tibble::tibble_row(
    lcd        = lcm(r$den),
    dissonance = log2(.data$lcd),
    consonance = flip(.data$dissonance),
    ratios     = list(r)
  )

}

flip <- function(x) {
  consonance = ZARLINO - x
  if (is.na(consonance) | consonance < SMALLEST_POSSIBLE) {
    SMALLEST_POSSIBLE
  } else {
    consonance
  }
}

rotate <- function(x) {
  browser
  rotated = (R_PI_4 %*% matrix(c(
    x$wavelength_consonance,
    x$frequency_consonance
  ))) %>% as.vector %>% zapsmall

  x %>% dplyr::mutate(
    consonance_dissonance = rotated[1],
    major_minor           = rotated[2],
    .before=1
  )

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

WAVELENGTH_TOLERANCE = 9e-02
FREQUENCY_TOLERANCE  = 9e-02

WAVELENGTH_MICRO_TOLERANCE = 0.0003
FREQUENCY_MICRO_TOLERANCE  = WAVELENGTH_MICRO_TOLERANCE / 2

MIN_AMPLITUDE  = 0.03

SPEED_OF_SOUND = 343

ZARLINO        = 100 / sqrt(2)

SMALLEST_POSSIBLE = .Machine$double.xmin

PI_4           = pi / 4
R_PI_4         = matrix(c(
  cos(PI_4), sin(PI_4),
  -sin(PI_4), cos(PI_4)
), nrow = 2, ncol = 2, byrow = TRUE)


R_PI_2         = matrix(c(
   0, 1,
  -1, 0
), nrow = 2, ncol = 2, byrow = TRUE)

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
