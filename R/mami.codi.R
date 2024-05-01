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
#' TRUE is all and FALSE is just major-minor and consonance-dissonance
#' @param tolerance An optional tolerance value for creating rational fractions
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @return Major-Minor and Consonance-Dissonance plus additional information
#' if verbose=TRUE
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(x, metadata=NA, verbose=FALSE, tolerance=TOLERANCE, ...) {

  parse_input(x, ...)              %>%
    listen_for_pseudo_octave       %>%
    duplex(tolerance)              %>%
    flip                           %>%
    rotate                         %>%
    format_output(metadata, verbose)

}

parse_input <- function(x,...) {

  UseMethod('parse_input', x)

}

parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...),
              ...)

}

parse_input.sparse_fr_spectrum <- function(x, ...) {

  f = x %>% dplyr::filter(.data$y>MIN_AMPLITUDE) %>% hrep::freq()
  λ = SPEED_OF_SOUND / f

  tibble::tibble_row(
    frequencies = list(f),
    wavelengths = list(λ)
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

duplex <- function(x, tolerance) {

  f = x$frequencies[[1]]
  λ = x$wavelengths[[1]]

  extra_partials = 0
  n = x$pseudo_octave ^ log2(ceiling(2^(log(max(f) / min(f)) / log(x$pseudo_octave)))
                             + extra_partials)

  x %>% dplyr::mutate(

    # estimate the frequency cycle
    estimate_cycle(f,
                   # min(f),
                   max(f) / n, # missing lowest fundamental of the highest partial
                   x$pseudo_octave,
                   tolerance) %>%
      dplyr::rename_with(~ paste0(.,'_frequency')),

    # estimate the wavelength cycle
    estimate_cycle(λ,
                   # min(λ),
                   max(λ) / n, # highest missing partial of the lowest fundamental
                   x$pseudo_octave,
                   tolerance) %>%
      dplyr::rename_with(~ paste0(.,'_wavelength'))

  )

}

estimate_cycle <- function(x, harmonic, pseudo_octave, tolerance) {

  r = ratios(x, harmonic, pseudo_octave, tolerance)

  tibble::tibble_row(
    lcm        = lcm(r$den),
    dissonance = log2(.data$lcm),
    ratios     = list(r)
  )

}

flip <- function(x) {

  consonance_frequency  = ZARLINO - x$dissonance_frequency
  consonance_wavelength = ZARLINO - x$dissonance_wavelength

  if (consonance_frequency <= 0 | consonance_wavelength <= 0) {
    stop(paste(
      'consonance should never be less than zero',
      'if so the ZARLINO constant is too low'
    ))
  }

  x %>% dplyr::mutate(
    consonance_frequency,
    consonance_wavelength,
    .before=1
  )

}

rotate <- function(x) {
  browser
  rotated = (R_PI_4 %*% matrix(c(
    x$consonance_wavelength,
    x$consonance_frequency
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
      dplyr::select('major_minor', 'consonance_dissonance', 'metadata')
  }
}

lcm <- function(x) Reduce(numbers::LCM, x)

SPEED_OF_SOUND = 343
TOLERANCE      = 0.013
ZARLINO        = 100 / sqrt(2)
MIN_AMPLITUDE  = 1/12
PI_4           = pi / 4
R_PI_4         = matrix(c(
  cos(PI_4), sin(PI_4),
  -sin(PI_4), cos(PI_4)
), nrow = 2, ncol = 2, byrow = TRUE)
