#' Major-Minor Consonance-Dissonance
#'
#' A model of consonance perception based on the fundamental cycles of complex space and time signals.
#'
#' @param x Chord to analyze, which is parsed using
#'   \code{hrep::sparse_fr_spectrum}. For more details, see
#'   \href{https://github.com/pmcharrison/hrep/blob/master/R/sparse-fr-spectrum.R}{hrep::sparse_fr_spectrum documentation}.
#' @param beat_pass_filter Specifies which bands of beats to include: low, high, all, or none.
#'   \describe{
#'     @eval paste0(
#'       "\item{\\code{", BEAT_PASS_FILTER$LOW, "}}{Passes beat tones lower than the lowest stimulus tone.}\n",
#'       "\item{\\code{", BEAT_PASS_FILTER$HIGH, "}}{Passes beat tones higher than the lowest stimulus tone.}\n",
#'       "\item{\\code{", BEAT_PASS_FILTER$ALL, "}}{Passes all beat tones.}\n",
#'       "\item{\\code{", BEAT_PASS_FILTER$NONE, "}}{Passes none of the beat tones.}\n"
#'     )
#'   }
#' @param sfoae_num_harmonics Number of harmonics to include for the stimulus-frequency otoacoustic emission.
#' @param space_uncertainty Optional space uncertainty value for finding rational fractions.
#' @param time_uncertainty Optional time uncertainty value for finding rational fractions.
#' @param integer_harmonics_tolerance Optional tolerance for harmonics to deviate from perfect integers.
#' @param metadata User-provided list of metadata that accompanies each call. Useful for analysis and plots.
#' @param verbose Determines the amount of data to return from chord evaluation. Options are:
#'   \describe{
#'     \item{\code{TRUE}}{Returns all available evaluation data.}
#'     \item{\code{FALSE}}{Returns only essential data: major/minor classification, consonance/dissonance, and metadata.}
#'   }
#' @param ... Additional parameters for \code{hrep::sparse_fr_spectrum}.
#'
#' @return Major-Minor (majorness), Consonance-Dissonance (dissonance), and metadata, with additional
#'   information if \code{verbose = TRUE}.
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(
    x,
    beat_pass_filter            = BEAT_PASS_FILTER$LOW,
    sfoae_num_harmonics         = SFOAE_NUM_HARMONICS,
    space_uncertainty           = UNCERTAINTY_LIMIT,
    time_uncertainty            = UNCERTAINTY_LIMIT,
    integer_harmonics_tolerance = INTEGER_HARMONICS_TOLERANCE,
    metadata                    = NA,
    verbose                     = FALSE,
    ...
) {

  x %>%
    # App Domain
    parse_input(...) %>%
    # Physical Domain
    generate_stimulus() %>%
    generate_beats(beat_pass_filter) %>%
    generate_cochlea_emissions(sfoae_num_harmonics) %>%
    # Frequency Domain
    compute_fundamental_wavenumber(
      space_uncertainty,
      integer_harmonics_tolerance
    ) %>%
    compute_fundamental_frequency(
      time_uncertainty,
      integer_harmonics_tolerance
    ) %>%
    # Psychophysical Domain
    compute_harmony_perception() %>%
    # App Domain
    format_output(metadata, verbose)

}

#' Generate the stimulus tones as frequency and wavelength spectra
#'
#' @param x A sparse frequency spectrum from \code{hrep}, representing the
#' frequency content of the stimulus tones.
#'
#' @return The frequency and wavelength spectra for the stimulus tones.
#'
#' @rdname generate_stimulus
#' @export
generate_stimulus <- function(
    x
) {

  frequency_spectrum  = tibble::tibble(
    frequency     = x %>% hrep::freq(),
    amplitude     = x %>% hrep::amp()
  )

  wavelength_spectrum = tibble::tibble(
    wavelength    = C_SOUND / frequency_spectrum$frequency,
    amplitude     = frequency_spectrum$amplitude
  )

  # Store the values
  tibble::tibble_row(
    frequency_spectrum  = list(frequency_spectrum),
    wavelength_spectrum = list(wavelength_spectrum),
    source_spectrum     = list(x),
    speed_of_sound      = C_SOUND
  )

}

#' Generate beat tones as a wavelength spectrum (only, not frequency spectrum)
#' and apply a pass filter (low, high, all, or none) relative to the lowest tone
#' in the stimulus.
#'
#' @param x Wavelength and frequency spectra representing the stimulus tones.
#' @param beat_pass_filter Specifies which bands of beat tones to include. Options are:
#'   \describe{
#'     @eval paste0(
#'       "\n  \\item{\\code{", BEAT_PASS_FILTER$LOW, "}}{Passes beat tones lower than the lowest stimulus tone.}",
#'       "\n  \\item{\\code{", BEAT_PASS_FILTER$HIGH, "}}{Passes beat tones higher than the lowest stimulus tone.}",
#'       "\n  \\item{\\code{", BEAT_PASS_FILTER$ALL, "}}{Passes all beat tones.}",
#'       "\n  \\item{\\code{", BEAT_PASS_FILTER$NONE, "}}{Passes none of the beat tones.}"
#'     )
#'   }
#'
#' @return The wavelength spectrum of the selected beat tones.
#'
#' @rdname generate_beats
#' @export
generate_beats <- function(
    x, beat_pass_filter
) {

  all_beats_spectrum = compute_beats(
    wavelength = x$wavelength_spectrum[[1]]$wavelength,
    amplitude  = x$wavelength_spectrum[[1]]$amplitude
  )

  max_stimulus_wavelength = x$wavelength_spectrum[[1]]$wavelength %>% max()

  low_beats_spectrum = all_beats_spectrum %>%
    dplyr::filter(wavelength > (max_stimulus_wavelength + FLOATING_POINT_TOLERANCE))

  high_beats_spectrum = all_beats_spectrum %>%
    dplyr::filter(wavelength < (max_stimulus_wavelength - FLOATING_POINT_TOLERANCE))

  if (beat_pass_filter == BEAT_PASS_FILTER$LOW) {
    filtered_beats_spectrum = low_beats_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$HIGH) {
    filtered_beats_spectrum = high_beats_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$ALL) {
    filtered_beats_spectrum = all_beats_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$NONE) {
    filtered_beats_spectrum = empty_spectrum()
  }

  x$wavelength_spectrum = list(dplyr::bind_rows(
    x$wavelength_spectrum, filtered_beats_spectrum
  ))

  # Store the values
  x %>% dplyr::mutate(
    filtered_beats_spectrum = list(filtered_beats_spectrum),
    all_beats_spectrum      = list(all_beats_spectrum),
    low_beats_spectrum      = list(low_beats_spectrum),
    high_beats_spectrum     = list(high_beats_spectrum),
    max_stimulus_wavelength
  )

}

#' Generate tones emitted from the cochlea in response to frequency stimulation
#'
#' @param x Wavelength and frequency spectra representing the stimulus and beat tones.
#' @param sfoae_num_harmonics Number of harmonics emitted from the cochlea via SFOAE.
#'
#' @return Combined frequency and wavelength spectra for the stimulus, beat tones, and tones generated by the SFOAE.
#'
#' @rdname generate_cochlea_emissions
#' @export
generate_cochlea_emissions <- function(
    x, sfoae_num_harmonics
) {

  if (sfoae_num_harmonics > 0) {

    cochlea_sparse_fr_spectrum = hrep::sparse_fr_spectrum(
      hrep::freq_to_midi(x$source_spectrum[[1]] %>% hrep::freq() %>% min()),
      num_harmonics = sfoae_num_harmonics
    )

    cochlea_frequency_spectrum = tibble::tibble(
      frequency = cochlea_sparse_fr_spectrum %>% hrep::freq(),
      amplitude = cochlea_sparse_fr_spectrum %>% hrep::amp()
    )

    x$frequency_spectrum = list(dplyr::bind_rows(
      x$frequency_spectrum, cochlea_frequency_spectrum
    ))

    cochlea_wavelength_spectrum = tibble::tibble(
      wavelength = x$speed_of_sound / cochlea_frequency_spectrum$frequency,
      amplitude  = cochlea_sparse_fr_spectrum %>% hrep::amp()
    )

    x$wavelength_spectrum = list(dplyr::bind_rows(
      x$wavelength_spectrum, cochlea_wavelength_spectrum
    ))

  } else {

    cochlea_frequency_spectrum  = empty_spectrum()
    cochlea_wavelength_spectrum = empty_spectrum()

  }

  # Store the values
  x %>% dplyr::mutate(
    cochlea_wavelength_spectrum = list(cochlea_wavelength_spectrum),
    cochlea_frequency_spectrum  = list(cochlea_frequency_spectrum),
    sfoae_num_harmonics
  )

}

#' Compute the fundamental wavenumber of the complex waveform.
#'
#' Computes the fundamental wavenumber from a wavelength spectrum that
#' includes stimulus, beat, and cochlear emission tones.
#'
#' @param x Wavelength spectrum that include stimulus, beat, and cochlear emission tones.
#' @param space_uncertainty Uncertainty factor applied when creating rational approximations for spatial wavelength.
#' @param integer_harmonics_tolerance Allowable deviation for harmonics that are not perfect integers.
#'
#' @return Fundamental wavenumber of a complex waveform.
#'
#' @rdname compute_fundamental_wavenumber
#' @export
compute_fundamental_wavenumber <- function(
    x,
    space_uncertainty,
    integer_harmonics_tolerance
) {

  l = x$wavelength_spectrum[[1]]$wavelength

  k = 1 / l

  x %>% dplyr::mutate(

    compute_fundamental_cycle(
      l/min(l),
      DIMENSION$SPACE,
      space_uncertainty,
      integer_harmonics_tolerance
    ),

    fundamental_wavenumber = min(k) / .data$space_cycles,

    # Store the values
    wavelengths            = list(l),
    wavenumbers            = list(k),
    space_uncertainty,
    integer_harmonics_tolerance
  )

}

#' Compute the fundamental temporal frequency of a complex waveform.
#'
#' Computes the fundamental temporal frequency from a frequency spectrum that
#' includes stimulus, beat, and cochlear emission tones.
#'
#' @param x Wavelength spectrum that include stimulus, beat, and cochlear emission tones.
#' @param time_uncertainty Uncertainty factor applied when creating rational approximations for temporal frequency.
#' @param integer_harmonics_tolerance Allowable deviation for harmonics that are not perfect integers.
#'
#' @return Fundamental temporal frequency of a complex waveform.
#'
#' @rdname compute_fundamental_frequency
#' @export
compute_fundamental_frequency <- function(
    x,
    time_uncertainty,
    integer_harmonics_tolerance
) {

  f = x$frequency_spectrum[[1]]$frequency

  P = 1 / f

  x %>% dplyr::mutate(

    compute_fundamental_cycle(
      f/min(f),
      DIMENSION$TIME,
      time_uncertainty,
      integer_harmonics_tolerance
    ),

    fundamental_frequency  = min(f) / .data$time_cycles,

    # Store the values
    frequencies            = list(f),
    periods                = list(P),
    time_uncertainty

  )

}

#' Compute the cycle length of a complex wave
#'
#' @param x Spectrum representing a complex waveform
#' @param dimension Space or time, used to label the output
#' @param uncertainty Precision for creating rational approximations
#' @param integer_harmonics_tolerance Allowable toleance for approximating least common multiples (LCM).
#'
#' @return Estimated cycle length of the complex waveform.
#'
#' @rdname compute_fundamental_cycle
#' @export
compute_fundamental_cycle <- function(x, dimension, uncertainty, integer_harmonics_tolerance) {

  fractions = approximate_rational_fractions(x, uncertainty, integer_harmonics_tolerance)

  t = tibble::tibble_row(
    cycles = lcm_integers(fractions$den),
    fractions = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(dimension, '_' , .))
  t

}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

#' Compute harmony perception from cycle lengths
#'
#' Computes harmony perception metrics based on cycle lengths from the spatial
#' and temporal frequency domains, converting them into psychophysical measures
#' of dissonance perception. The sum of wavelength dissonance and frequency
#' dissonance provides an overall sense of dissonance, while the difference
#' indicates major-minor tonality.
#'
#' @param x Cycle lengths for the fundamental frequency and fundamental wavelength.
#'
#' @return Overall dissonance and major-minor tonality perception.
#'
#' @rdname compute_harmony_perception
#' @export
compute_harmony_perception <- function(x) {

  x %>% dplyr::mutate(

    time_dissonance  = log2(.data$time_cycles),
    space_dissonance = log2(.data$space_cycles),

    dissonance       = .data$space_dissonance + .data$time_dissonance,
    majorness        = .data$space_dissonance - .data$time_dissonance

  )

}

# low_beating      =  if (nrow(unlist(.data$low_beats_spectrum)) > 0) {
#   log2(1+sum(unlist(.data$low_beats_spectrum$amplitude ^ 2 * beats_spectrum$wavelength, na.rm = TRUE))
# } else {
#   0
# }
#

# Constants

#' Uncertainty limit
#'
#' Uncertainty limit for the uncertainty products of
#' time, frequency or space, wavelength
#'
#'
#' @rdname uncertainty_limit
#' @export
uncertainty_limit <- function() { UNCERTAINTY_LIMIT }
UNCERTAINTY_LIMIT = 1 / (4 * pi)

#' Default integer harmonic tolerance
#'
#' Tolerance for the case when harmonics are not perfect integers
#' useful for approximating the Least Common Multiple (LCM) and
#' to determine the pseudo octave in the case of stretched timbre
#'
#''
#' @rdname default_integer_harmonics_tolerance
#' @export
default_integer_harmonics_tolerance <- function() { INTEGER_HARMONICS_TOLERANCE }
INTEGER_HARMONICS_TOLERANCE = 0.11

#' Speed of Sound
#'
#' Default minimum amplitude for deciding which tones are evaluated
#'
#''
#' @rdname speed_of_sound
#' @export
speed_of_sound <- function() { C_SOUND }
C_SOUND = 343 # m/s arbitrary, disappears in the ratios

#' Default SFOAE number of harmonics
#'
#' Default number of harmonics emitting by the cochlea
#'
#''
#' @rdname default_sfoae_num_harmonics
#' @export
default_sfoae_num_harmonics <- function() { SFOAE_NUM_HARMONICS }
SFOAE_NUM_HARMONICS = 5


#' Default beat pass filter
#'
#' Default beat pass filter for determining which beat tones pass into the model
#'
#''
#' @rdname default_beat_pass_filter
#' @export
default_beat_pass_filter <- function() { BEAT_PASS_FILTER$LOW }
BEAT_PASS_FILTER <- list(
  ALL  = 'all',
  HIGH = 'high',
  LOW  = 'low',
  NONE = 'none'
)

DIMENSION <- list(
  SPACE = 'space',
  TIME  = 'time'
)

#' Helper function to create an empty spectrum
empty_spectrum <- function() {
  tibble::tibble(
    wavelength = numeric(),
    amplitude  = numeric()
  )
}

FLOATING_POINT_TOLERANCE <- 1e-6
