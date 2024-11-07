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
#' @param cochlear_amplifier_num_harmonics Number of harmonics to include for the stimulus-frequency otoacoustic emission.
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
    beat_pass_filter                 = DEFAULT_BEAT_PASS_FILTER,
    cochlear_amplifier_num_harmonics = COCHLEAR_AMPLIFIER_NUM_HARMONICS,
    space_uncertainty                = UNCERTAINTY_LIMIT,
    time_uncertainty                 = UNCERTAINTY_LIMIT,
    integer_harmonics_tolerance      = INTEGER_HARMONICS_TOLERANCE,
    metadata                         = NA,
    verbose                          = FALSE,
    ...
) {

  x %>%
    # R Data Marshaling Domain
    parse_input(...) %>%
    # Physical Domain
    generate_stimulus() %>%
    generate_air_beats(
      beat_pass_filter
    ) %>%
    generate_cochlear_amplifications(
      cochlear_amplifier_num_harmonics,
      space_uncertainty
    ) %>%
    generate_cochlear_beats(
      beat_pass_filter
    ) %>%
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
    compute_beats_perception()   %>%
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

  stimulus_frequency_spectrum  = frequency_spectrum_from_sparse_fr_spectrum(x)

  stimulus_wavelength_spectrum = wavelength_spectrum_from_sparse_fr_spectrum(x)

  # Store the values
  tibble::tibble_row(
    stimulus_frequency_spectrum  = list(stimulus_frequency_spectrum),
    stimulus_wavelength_spectrum = list(stimulus_wavelength_spectrum),
    source_spectrum              = list(x)
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
#' @rdname generate_air_beats
#' @export
generate_air_beats <- function(
    x, beat_pass_filter
) {

  air_beats_wavelength_spectrum = compute_beats(
    wavelength = x$stimulus_wavelength_spectrum[[1]]$wavelength,
    amplitude  = x$stimulus_wavelength_spectrum[[1]]$amplitude
  ) %>% filter_spectrum_in_range(DIMENSION$SPACE)

  max_stimulus_wavelength = x$stimulus_wavelength_spectrum[[1]]$wavelength %>% max()

  low_air_beats_wavelength_spectrum = air_beats_wavelength_spectrum %>%
    dplyr::filter(wavelength >= max_stimulus_wavelength)

  high_air_beats_wavelength_spectrum = air_beats_wavelength_spectrum %>%
    dplyr::filter(wavelength < max_stimulus_wavelength)

  if (beat_pass_filter == BEAT_PASS_FILTER$LOW) {
    filtered_air_beats_wavelength_spectrum = low_air_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$HIGH) {
    filtered_air_beats_wavelength_spectrum = high_air_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$ALL) {
    filtered_air_beats_wavelength_spectrum = air_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$NONE) {
    filtered_air_beats_wavelength_spectrum = empty_wavelength_spectrum()
  }

  # Store the values
  x %>% dplyr::mutate(
    filtered_air_beats_wavelength_spectrum = list(filtered_air_beats_wavelength_spectrum),
    air_beats_wavelength_spectrum          = list(air_beats_wavelength_spectrum),
    low_air_beats_wavelength_spectrum      = list(low_air_beats_wavelength_spectrum),
    high_air_beats_wavelength_spectrum     = list(high_air_beats_wavelength_spectrum),
    beat_pass_filter,
    max_stimulus_wavelength
  )

}

# TODO: does cochlear amplification respond to wavelengths stimulus? or frequencies stimulus?
# Right now I am assuming frequency. but if the cochlear amplification starts with OHC which has
# spatial extent then it should probably be wavelength sensitive, which means beats
# which means the missing fundamental would create an emission response.

#' Generate tones emitted from the cochlea in response to frequency stimulation
#'
#' @param x Wavelength and frequency spectra representing the stimulus and beat tones.
#' @param cochlear_amplifier_num_harmonics Number of harmonics emitted from the cochlea via cochlear amplification.
#'
#' @return Combined frequency and wavelength spectra for the stimulus, beat tones, and tones generated by the cochlear amplification.
#'
#' @rdname generate_cochlear_amplifications
#' @export
generate_cochlear_amplifications <- function(
    x, cochlear_amplifier_num_harmonics, space_uncertainty
) {

  if (cochlear_amplifier_num_harmonics > 0) {

    stimulus_and_air_beats_wavelength_spectrum = combine_spectra(
      x$stimulus_wavelength_spectrum[[1]],
      x$filtered_air_beats_wavelength_spectrum[[1]],
      reference = x$stimulus_wavelength_spectrum[[1]]$wavelength %>% min(),
      uncertainty = space_uncertainty
    )

    cochlear_amplifications_wavelength_spectrum = expand_harmonics(
      stimulus_and_air_beats_wavelength_spectrum,
      num_harmonics = cochlear_amplifier_num_harmonics,
      roll_off_dB   = 29 # dB
      # Among distortion components, the second harmonic is
      # the largest (47), attaining levels as high as 3.5%
      # (or 29 dB) referred to the fundamental component (43).
      # ["Mechanics of the Mammalian Cochlea", Robles and Ruggero, 2001]
    )

    cochlear_amplifications_frequency_spectrum  = frequency_spectrum_from_wavelength_spectrum(
      cochlear_amplifications_wavelength_spectrum
    )

  } else {

    cochlear_amplifications_frequency_spectrum  = x$stimulus_frequency_spectrum[[1]]
    cochlear_amplifications_wavelength_spectrum = x$stimulus_wavelength_spectrum[[1]]

  }

  # Store the values
  x %>% dplyr::mutate(
    cochlear_amplifications_wavelength_spectrum = list(cochlear_amplifications_wavelength_spectrum),
    cochlear_amplifications_frequency_spectrum  = list(cochlear_amplifications_frequency_spectrum),
    cochlear_amplifier_num_harmonics
  )

}

#' @rdname generate_cochlear_beats
#' @export
generate_cochlear_beats <- function(
    x, beat_pass_filter
) {

  cochlear_beats_wavelength_spectrum = compute_beats(
    wavelength = x$cochlear_amplifications_wavelength_spectrum[[1]]$wavelength,
    amplitude  = x$cochlear_amplifications_wavelength_spectrum[[1]]$amplitude
  ) %>% filter_spectrum_in_range(DIMENSION$SPACE)

  max_cochlear_amplifications_wavelength = x$cochlear_amplifications_wavelength_spectrum[[1]]$wavelength %>% max()

  low_cochlear_beats_wavelength_spectrum = cochlear_beats_wavelength_spectrum %>%
    dplyr::filter(wavelength >= max_cochlear_amplifications_wavelength)

  high_cochlear_beats_wavelength_spectrum = cochlear_beats_wavelength_spectrum %>%
    dplyr::filter(wavelength < max_cochlear_amplifications_wavelength)

  if (beat_pass_filter == BEAT_PASS_FILTER$LOW) {
    filtered_cochlear_beats_wavelength_spectrum = low_cochlear_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$HIGH) {
    filtered_cochlear_beats_wavelength_spectrum = high_cochlear_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$ALL) {
    filtered_cochlear_beats_wavelength_spectrum = cochlear_beats_wavelength_spectrum
  } else if (beat_pass_filter == BEAT_PASS_FILTER$NONE) {
    filtered_cochlear_beats_wavelength_spectrum = x$cochlear_amplifications_wavelength_spectrum[[1]]
  }

  # Store the values
  x %>% dplyr::mutate(
    filtered_cochlear_beats_wavelength_spectrum = list(filtered_cochlear_beats_wavelength_spectrum),
    cochlear_beats_wavelength_spectrum          = list(cochlear_beats_wavelength_spectrum),
    low_cochlear_beats_wavelength_spectrum      = list(low_cochlear_beats_wavelength_spectrum),
    high_cochlear_beats_wavelength_spectrum     = list(high_cochlear_beats_wavelength_spectrum),
    max_cochlear_amplifications_wavelength
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

  wavelength_spectrum = combine_spectra(
    x$cochlear_amplifications_wavelength_spectrum[[1]],
    x$filtered_cochlear_beats_wavelength_spectrum[[1]],
    reference = x$stimulus_wavelength_spectrum[[1]]$wavelength %>% min(),
    uncertainty = space_uncertainty
  )

  l = wavelength_spectrum$wavelength

  k = 1 / l

  x %>% dplyr::mutate(

    compute_fundamental_cycle(
      l/min(l),
      DIMENSION$SPACE,
      space_uncertainty,
      integer_harmonics_tolerance,
      paste("l:", toString(l), "min(l):", min(l))
    ),

    fundamental_wavenumber = min(k) / .data$space_cycles,

    # Store the values
    wavelength_spectrum    = list(wavelength_spectrum),
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

  frequency_spectrum = combine_spectra(
    x$cochlear_amplifications_frequency_spectrum[[1]],
    reference = x$stimulus_frequency_spectrum[[1]]$frequency %>% min(),
    uncertainty = time_uncertainty
  )

  f = frequency_spectrum$frequency

  P = 1 / f

  x %>% dplyr::mutate(

    compute_fundamental_cycle(
      f/min(f),
      DIMENSION$TIME,
      time_uncertainty,
      integer_harmonics_tolerance,
      paste("f:", toString(f), "min(f):", min(f))
    ),

    fundamental_frequency  = min(f) / .data$time_cycles,

    # Store the values
    frequency_spectrum     = list(frequency_spectrum),
    frequencies            = list(f),
    periods                = list(P),
    time_uncertainty

  )

}

#' Compute the cycle length of a complex wave
#'
#' @param x Spectrum components without amplitude representing a complex waveform
#' @param dimension Space or time, used to label the output
#' @param uncertainty Precision for creating rational approximations
#' @param integer_harmonics_tolerance Allowable toleance for approximating least common multiples (LCM).
#'
#' @return Estimated cycle length of the complex waveform.
#'
#' @rdname compute_fundamental_cycle
#' @export
compute_fundamental_cycle <- function(x, dimension, uncertainty,
                                      integer_harmonics_tolerance,
                                      metadata) {


  print(dimension)
  print(length(x))
  print(x)

  fractions = approximate_rational_fractions(x, uncertainty,
                                             integer_harmonics_tolerance,
                                             metadata)

  t = tibble::tibble_row(
    cycles = lcm_integers(fractions$den),
    fractions = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(dimension, '_' , .))
  t

}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

#' Compute harmony perception from cycle lengths
#'
#' Computes harmony perception based on cycle lengths from the spatial
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

#' Compute beating perception from beat spectrum
#'
#' Calculates a psychophysical measure of beating perception derived from the
#' beat spectrum, interpreting beat frequencies and amplitudes in a perceptual context.
#'
#' @param x The beat spectrum, containing frequency and amplitude information for beats derived from the stimulus.
#'
#' @return Psychophysical measure of beating perception.
#'
#' @rdname compute_beats_perception
#' @export
compute_beats_perception <- function(x) {

  low_beating  = beating(x$low_cochlear_beats_wavelength_spectrum[[1]])
  high_beating = beating(x$high_cochlear_beats_wavelength_spectrum[[1]])
  all_beating  = beating(x$cochlear_beats_wavelength_spectrum[[1]])

  if (x$beat_pass_filter == BEAT_PASS_FILTER$LOW) {
    beating = low_beating
  } else if (x$beat_pass_filter == BEAT_PASS_FILTER$HIGH) {
    beating = high_beating
  } else if (x$beat_pass_filter == BEAT_PASS_FILTER$ALL) {
    beating = all_beating
  } else  {
    beating = 0
  }

  x %>% dplyr::mutate(
    beating,
    low_beating,
    high_beating,
    all_beating
  )

}

beating <- function(
    x
) {
  if (nrow(x) > 0) {
    log2(1+sum(x$amplitude ^ 2 * x$wavelength, na.rm = TRUE))
  } else {
    0
  }
}

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

#' Default cochlear amplification number of harmonics
#'
#' Default number of harmonics emitting by the cochlea
#'
#''
#' @rdname default_cochlear_amplifier_num_harmonics
#' @export
default_cochlear_amplifier_num_harmonics <- function() { COCHLEAR_AMPLIFIER_NUM_HARMONICS }
COCHLEAR_AMPLIFIER_NUM_HARMONICS = 2

#' Default beat pass filter
#'
#' Default beat pass filter for determining which beat tones pass into the model
#'
#''
#' @rdname default_beat_pass_filter
#' @export
default_beat_pass_filter <- function() { DEFAULT_BEAT_PASS_FILTER }
BEAT_PASS_FILTER <- list(
  ALL  = 'all',
  HIGH = 'high',
  LOW  = 'low',
  NONE = 'none'
)
DEFAULT_BEAT_PASS_FILTER = BEAT_PASS_FILTER$LOW

DIMENSION <- list(
  SPACE = 'space',
  TIME  = 'time'
)

MAX_FREQUENCY = hrep::midi_to_freq(127 + 24)
MIN_FREQUENCY = 1

MAX_WAVELENGTH = C_SOUND / MIN_FREQUENCY
MIN_WAVELENGTH = C_SOUND / MAX_FREQUENCY
