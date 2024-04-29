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
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @return Major-Minor and Consonance-Dissonance plus additional information
#' if verbose=TRUE
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(x, metadata=NA, verbose=FALSE,...) {

  parse_input(x, ...)              %>%
    listen_for_pseudo_octave       %>%
    duplex                         %>%
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
    potential_highest_fundamentals = f %>% find_highest_fundamental()

    estimated_pseudo_octave = (potential_highest_fundamentals %>%
                                 dplyr::count(.data$pseudo_octave, name='harmonic_number',sort=TRUE) %>%
                                 dplyr::slice(1))$pseudo_octave

    f0 =  potential_highest_fundamentals %>%
      dplyr::filter(dplyr::near(pseudo_octave, estimated_pseudo_octave), evaluation_freq == highest_freq) %>%
      dplyr::arrange(dplyr::desc(harmonic_number))

    # remove candidates that are an octave below other candidates
    i <- 1
    candidate_to_remove = c()
    while (i<=nrow(f0)){
      # TODO: find a tidyr way to do this loop
      j <- 1
      while (j<=nrow(f0)){
        if (f0[i,]$harmonic_number == 2 * f0[j,]$harmonic_number) {
          candidate_to_remove = append(candidate_to_remove, i)
        }
        j <- j+1
      }
      i <- i+1
    }
    if (length(candidate_to_remove) > 0) {
      f0 <- f0[-candidate_to_remove,]
    }

    f0 = f0[1,]

    x %>% dplyr::mutate(
      pseudo_octave        = f0$pseudo_octave,
    )
  } else if (length(f) > 1) {
    x %>% dplyr::mutate(
      pseudo_octave        = compute_pseudo_octave(max(f), min(f), 2),
    )
  } else {
    x %>% dplyr::mutate(
      pseudo_octave        = 1.0,
    )
  }
}

duplex <- function(x) {

  f = x$frequencies[[1]]
  λ = x$wavelengths[[1]]

  x %>% dplyr::mutate(

    # estimate the frequency cycle
    estimate_cycle(f,
                   min(f),
                   1,
                   x$pseudo_octave,
                   TOLERANCE) %>%
      dplyr::rename_with(~ paste0(.,'_frequency')),

    # estimate the wavelength cycle
    estimate_cycle(λ,
                   min(λ),
                   1 / round(max(λ) / min(λ)),
                   x$pseudo_octave,
                   TOLERANCE) %>%
      dplyr::rename_with(~ paste0(.,'_wavelength'))

  )

}


estimate_cycle <- function(x, reference, harmonic_number, pseudo_octave, tolerance) {

    r = ratios(x, reference, harmonic_number, pseudo_octave, tolerance)

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
      'if so the ZARLINO constant is too low',
      'dissonance_freq',x$dissonance_frequency,
      'dissonance_wavelength',x$dissonance_wavelength,
      'chord', x$frequencies
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

SPEED_OF_SOUND = 343 # m/S
TOLERANCE      = 0.019
ZARLINO        = 100 / sqrt(2)     # Z
MIN_AMPLITUDE  = 1/12
PI_4           = pi / 4
R_PI_4         = matrix(c(
  cos(PI_4), sin(PI_4),
  -sin(PI_4), cos(PI_4)
), nrow = 2, ncol = 2, byrow = TRUE)
