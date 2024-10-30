#' Major-Minor Consonance-Dissonance
#'
#' A model of consonance perception based on space and time cycles.
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param include_beats Beats
#' @param sfoae_num_harmonics Stimulus Frequency Otoacoustic Emissions
#' @param minimum_amplitude An optional minimum amplitude for deciding which partials to include.
#' @param integration_time Integration time to sample the space and time signals
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
    sfoae_num_harmonics      = 5,
    include_beats            = T,
    minimum_amplitude        = MINIMUM_AMPLITUDE,
    integration_time         = INTEGRATION_TIME,
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
      integration_time,
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

    sfoae_sparse_fr_spectrum = hrep::sparse_fr_spectrum(
      hrep::freq_to_midi(x %>% hrep::freq() %>% min()),
      num_harmonics = sfoae_num_harmonics
    )

    sfoae_spectrum = tibble::tibble(
      frequency = sfoae_sparse_fr_spectrum %>% hrep::freq(),
      amplitude = sfoae_sparse_fr_spectrum %>% hrep::amp()
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

  beating =  if (nrow(beats_spectrum) > 0) {
    log2(1+sum(beats_spectrum$amplitude ^ 2 * beats_spectrum$wavelength, na.rm = TRUE))
  } else {
    0
  }

  tibble::tibble_row(
    frequency_spectrum  = list(frequency_spectrum),
    wavelength_spectrum = list(wavelength_spectrum),
    sfoae_spectrum      = list(sfoae_spectrum),
    beats_spectrum      = list(beats_spectrum),
    source_spectrum     = list(x),
    beating,
    sfoae_num_harmonics,
    include_beats
  )

}

#' Compute the cycle lengths from space and time signals
#'
#' @param x Stimulus encoded as frequency and wavelength spectra
#' @param minimum_amplitude Ignore all frequencies below this threshold
#' @param integration_time Integration time to sample the space and time signals
#' @param harmonics_deviation Error allowance for harmonics not being perfect integers
#'
#' @return Estimate the cycle length of time and space signals
#'
#' @rdname space_time_cycles
#' @export
space_time_cycles = function(x,
                             minimum_amplitude,
                             integration_time,
                             harmonics_deviation) {

  f = (x$frequency_spectrum[[1]] %>%
         dplyr::filter(.data$amplitude>minimum_amplitude))$frequency
  l = (x$wavelength_spectrum[[1]] %>%
         dplyr::filter(.data$amplitude>minimum_amplitude))$wavelength

  P = 1 / f
  k = 1 / l

  x %>% dplyr::mutate(

    cycles(f/min(f), DIMENSION$TIME,  integration_time, harmonics_deviation),
    cycles(l/min(l), DIMENSION$SPACE, integration_time, harmonics_deviation),

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
    integration_time,
    harmonics_deviation

  )

}

#' Approximate Number of Cycles of a Complex Wave
#'
#' @param x Vector of rational numbers
#' @param dimension Space or time dimension
#' @param integration_time Integration time to sample the space or time signal
#' @param harmonics_deviation Deviation for approximating least common multiples
#'
#' @return Estimate the number of cycles using approximate least common denominator of the rational numbers
#'
#' @rdname cycles
#' @export
cycles <- function(x, dimension, integration_time, harmonics_deviation) {

  uncertainty = uncertainty(dimension, integration_time)

  fractions = approximate_rational_fractions(x, uncertainty, harmonics_deviation)

  t = tibble::tibble_row(
    cycles = lcm_integers(fractions$den),
    fractions = list(fractions),
    uncertainty
  ) %>% dplyr::rename_with(~ paste0(dimension, '_' , .))
  t
}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

#' Uncertainty
#'
#' The uncertainty product of the given dimension is used to convert
#' floating-point numbers to rational fractions.
#'
#' @param dimension Space or time dimension
#' @param integration_time Integration time to sample the space or time signal
#'
#' @rdname uncertainty
#' @export
uncertainty <- function(dimension, integration_time) {

  if (integration_time < 0) {
    stop('Integration time must be greater than zero.')
  }

  if (dimension == DIMENSION$TIME) {
    UNCERTAINTY_LIMIT
  } else if (dimension == DIMENSION$SPACE) {
    (integration_time / INTEGRATION_TIME) * UNCERTAINTY_LIMIT
  } else {
    stop("Invalid dimension")
  }
}


#' Integration Time
#'
#' Given an uncertainty returns an integration time.
#'
#' @param dimension Space or time dimension
#' @param uncertainty Uncertainty product
#'
#' @rdname integration_time
#' @export
integration_time <- function(dimension, uncertainty) {

  if (uncertainty < 0) {
    stop('Uncertainty must be greater than zero.')
  }

  if (dimension == DIMENSION$TIME) {
    INTEGRATION_TIME
  } else if (dimension == DIMENSION$SPACE) {
    (uncertainty * INTEGRATION_TIME) / UNCERTAINTY_LIMIT
  } else {
    stop("Invalid dimension")
  }
}



# Constants

#' Uncertainty Limit
#'
#' The limit of the uncertainty product for space-wavenumber or time-frequency
#'
#'
#' @rdname uncertainty_limit
#' @export
uncertainty_limit <- function() { UNCERTAINTY_LIMIT }
UNCERTAINTY_LIMIT = 1 / (4 * pi)

#' Default Integration Time
#'
#' Default integration time for sampling the space and time signals
#'
#'
#' @rdname default_integration_time
#' @export
default_integration_time <- function() { INTEGRATION_TIME }
INTEGRATION_TIME = 1

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

DIMENSION <- list(
  SPACE = "space",
  TIME = "time"
)
