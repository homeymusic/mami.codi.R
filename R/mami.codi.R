#' Major-Minor Consonance-Dissonance
#'
#' A model of consonance perception based on space and time cycles.
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param include_beats Beats
#' @param sfoae_num_harmonics Stimulus Frequency Otoacoustic Emissions
#' @param minimum_amplitude An optional minimum amplitude for deciding which partials to include.
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
    sfoae_num_harmonics      = 0,
    include_beats            = F,
    minimum_amplitude        = MINIMUM_AMPLITUDE,
    time_standard_deviation  = STANDARD_DEVIATION,
    space_standard_deviation = STANDARD_DEVIATION,
    harmonics_deviation      = HARMONICS_DEVIATION,
    metadata                 = NA,
    verbose                  = FALSE,
    ...
) {

  parse_input(x, ...) %>%
    stimulus(
      sfoae_num_harmonics,
      include_beats
    ) %>%
    space_time_cycles(
      minimum_amplitude,
      time_standard_deviation,
      space_standard_deviation,
      harmonics_deviation
    ) %>%
    format_output(metadata, verbose)

}

#' Generate the stimulus wave patterns in terms of frequency spectrum and wavelength spectrum
#'
#' @param x A sparse frequency spectrum
#' @param include_beats Whether to include beats in the wavelength spectrum
#'
#' @return Frequency spectrum, wavelength spectrum and wavelength beats spectrum
#'
#' @rdname stimulus
#' @export
stimulus <- function(x, sfoae_num_harmonics=0, include_beats=F) {

  if (sfoae_num_harmonics > 0) {

    sfoae = hrep::sparse_fr_spectrum(
      hrep::freq_to_midi(x %>% hrep::freq() %>% min()),
      num_harmonics = sfoae_num_harmonics
    )

    sfoae_spectrum = tibble::tibble(
      frequency = sfoae %>% hrep::freq(),
      amplitude = sfoae %>% hrep::amp()
    )

  } else {

    sfoae_spectrum = tibble::tibble(
      frequency = numeric(0),
      amplitude = numeric(0)
    )

  }

  frequency_spectrum = tibble::tibble(
    frequency = c(x %>% hrep::freq(), sfoae_spectrum$frequency),
    amplitude = c(x %>% hrep::amp(),  sfoae_spectrum$amplitude)
  ) %>% dplyr::distinct()

  wavelength_spectrum = tibble::tibble(
    wavelength = C_SOUND / frequency_spectrum$frequency,
    amplitude  = frequency_spectrum$amplitude
  )

  if (include_beats) {

    beats_spectrum = calculate_beats(
      wavelength = wavelength_spectrum$wavelength,
      amplitude = wavelength_spectrum$amplitude
    )

    wavelength_spectrum = dplyr::bind_rows(
      wavelength_spectrum, beats_spectrum
    )

  } else {

    beats_spectrum = tibble::tibble(
      wavelength = numeric(0),
      amplitude = numeric(0)
    )

  }

  tibble::tibble_row(
    frequency_spectrum  = list(frequency_spectrum),
    wavelength_spectrum = list(wavelength_spectrum),
    beating             = log2(1+sum(beats_spectrum$wavelength, na.rm = TRUE)),
    sfoae_spectrum      = list(sfoae_spectrum),
    beats_spectrum      = list(beats_spectrum),
    source_spectrum     = list(x)
  )

}

#' Compute the cycle lengths from space and time signals
#'
#' @param x Stimulus encoded as frequency and wavelength spectra
#' @param minimum_amplitude Ignore all frequencies below this threshold
#' @param time_standard_deviation Uncertainty for creating rational fractions
#' @param space_standard_deviation Uncertainty for creating rational fractions
#' @param harmonics_deviation Error allowance for harmonics not being perfect integers
#'
#' @return Estimate the cycle length of time and space signals
#'
#' @rdname space_time_cycles
#' @export
space_time_cycles = function(x,
                             minimum_amplitude,
                             time_standard_deviation, space_standard_deviation,
                             harmonics_deviation) {
  f = (x$frequency_spectrum[[1]] %>%
         dplyr::filter(.data$amplitude>minimum_amplitude))$frequency
  l = (x$wavelength_spectrum[[1]] %>%
         dplyr::filter(.data$amplitude>minimum_amplitude))$wavelength

  P = 1 / f
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
    wavelengths            = list(l),
    periods                = list(P),
    wavenumbers            = list(k),
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
