#' Major-Minor Consonance-Dissonance
#'
#' A model of consonance perception based on space and time cycles.
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param amplitude An optional minimum amplitude for deciding which partials to include.
#' @param time_standard_deviation An optional time standard_deviation value for finding rational fractions.
#' @param space_standard_deviation  An optional space standard_deviation value for finding rational fractions.
#' @param harmonics_deviation An optional deviation value that allows for harmonics to be not perfect integers.
#' @param metadata User-provided list of metadata that round trips with each call.
#' helpful for analysis and plots
#' @param verbose Determines the amount of data to return from chord evaluation
#' TRUE is all and FALSE is just major-minor, consonance-dissonance and metadata.
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @return Major-Minor (majorness), Consonance-Dissonance (dissonance) and metadata plus additional
#' information if verbose=TRUE
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(
    x,
    minimum_amplitude        = MINIMUM_AMPLITUDE,
    time_standard_deviation  = STANDARD_DEVIATION,
    space_standard_deviation = STANDARD_DEVIATION,
    harmonics_deviation      = HARMONICS_DEVIATION,
    metadata                 = NA,
    verbose                  = FALSE,
    ...
) {

  parse_input(x, ...) %>%
    stimulus() %>%
    space_time_cycles(minimum_amplitude,
                      time_standard_deviation,
                      space_standard_deviation,
                      harmonics_deviation) %>%
    format_output(metadata, verbose)

}


#' Create the stimulus
#'
#' @param x Vector of frequencies and amplitudes
#'
#' @return The stimulus
#'
#' @rdname stimulus
#' @export
stimulus = function(x) {

  f_a_beats = tidyr::expand_grid(s_1 = x$spectrum[[1]], s_2 = x$spectrum[[1]]) %>%
    dplyr::filter(s_1$x < s_2$x) %>%  # Filter to avoid duplicate pairs and self-pairing
    dplyr::mutate(frequency = abs(s_1$x - s_2$x)) %>%
    dplyr::mutate(amplitude = (s_1$y + s_2$y)^2)

  spectrum_beats = hrep::sparse_fr_spectrum(list(
    frequency = c(f_a_beats$frequency),
    amplitude = c(f_a_beats$amplitude)
  ))

  spectrum_combined = hrep::combine_sparse_spectra(
    hrep::sparse_fr_spectrum(
      list(
        frequency = c(x$spectrum[[1]]$x, spectrum_beats$x),
        amplitude = c(x$spectrum[[1]]$y, spectrum_beats$y)
      )
    )
  )

  x %>% dplyr::mutate(
    spectrum_beats = list(spectrum_beats),
    spectrum_combined = list(spectrum_combined)
  )

}

#' Compute the cycle lengths from space and time signals
#'
#' @param x Vector of frequencies and amplitudes
#' @param minimum_amplitude Ignore all frequencies below this threshold
#' @param time_standard_deviation Uncertainty for creating rational fractions
#' @param space_standard_deviation Uncertainty for creating rational fractions
#' @param harmonics_deviation Error allowance for harmonics not being perfect integers
#'
#' @return Estimate the cycle length of time and space signals
#'
#' @rdname space_time_cycles
#' @export
space_time_cycles = function(x, minimum_amplitude,
                             time_standard_deviation, space_standard_deviation,
                             harmonics_deviation) {

  f = x$spectrum[[1]] %>% dplyr::filter(.data$y>minimum_amplitude) %>% hrep::freq()
  P = 1 / f
  l = C_SOUND * P
  k = 1 / l

  x %>% dplyr::mutate(

    cycles(f/min(f), time_standard_deviation, harmonics_deviation, 'time'),
    cycles(l/min(l), space_standard_deviation,  harmonics_deviation, 'space'),

    time_dissonance        = log2(.data$time_cycles),
    space_dissonance       = log2(.data$space_cycles),

    dissonance             = .data$space_dissonance + .data$time_dissonance,
    majorness              = .data$space_dissonance - .data$time_dissonance,

    polar_dissonance       = sqrt((.data$space_dissonance)^2 + (.data$time_dissonance)^2),
    polar_majorness        = atan2(.data$time_dissonance, .data$space_dissonance),

    fundamental_frequency  = min(f) / .data$time_cycles,
    fundamental_wavenumber = min(k) / .data$space_cycles,

    # Store the metadata
    frequencies            = list(f),
    periods                = list(P),
    wavenumbers            = list(k),
    wavelengths            = list(l),
    speed_of_sound         = C_SOUND,
    minimum_amplitude,
    time_standard_deviation,
    space_standard_deviation,
    harmonics_deviation

  )

}

#' Approximate Number of Cycles of a Complex Wave
#'
#' @param x Vector of rational numbers
#' @param standard_deviation Precision for creating rational fractions
#' @param harmonics_deviation Deviation for approximating least common multiples
#' @param label A custom label for the output usually 'space' or 'time'
#'
#' @return Estimate the number of cycles using approximate least common denominator of the rational numbers
#'
#' @rdname cycles
#' @export
cycles <- function(x, standard_deviation, harmonics_deviation, label) {
  fractions = approximate_rational_fractions(x, standard_deviation, harmonics_deviation)

  t = tibble::tibble_row(
    cycles = lcm_integers(fractions$den),
    fractions = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(label, '_' , .))
  t
}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

# Constants

#' Default Standard Deviation
#'
#' Default standard_deviation for converting floating point numbers to rational fractions
#'
#'
#' @rdname default_standard_deviation
#' @export
default_standard_deviation <- function() { STANDARD_DEVIATION }
STANDARD_DEVIATION = 1 / (4 * pi)

#' Default Approximate Least Common Multiple Deviation
#'
#' Default harmonics_deviation for approximating the Least Common Multiple (LCM)
#'
#''
#' @rdname default_harmonics_deviation
#' @export
default_harmonics_deviation <- function() { HARMONICS_DEVIATION }
HARMONICS_DEVIATION = 0.11

#' Default Minimum Amplitude
#'
#' Default minimum amplitude for deciding which tones are evaluated
#'
#''
#' @rdname default_minimum_amplitude
#' @export
default_minimum_amplitude <- function() { MINIMUM_AMPLITUDE }
MINIMUM_AMPLITUDE = 0.07

C_SOUND = 343 # m/s arbitrary, disappears in the ratios
