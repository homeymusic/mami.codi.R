#' Major-Minor Consonance-Dissonance
#'
#' A spatiotemporal periodicity model of consonance perception.
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param amplitude An optional minimum amplitude for deciding which partials to include.
#' @param temporal_variance An optional temporal variance value for finding rational fractions.
#' @param spatial_variance  An optional spatial variance value for finding rational fractions.
#' @param deviation An optional deviation value for approximating least common multiples.
#' @param metadata User-provided list of metadata that round trips with each call.
#' helpful for analysis and plots
#' @param verbose Determines the amount of data to return from chord evaluation
#' TRUE is all and FALSE is just major-minor, consonance-dissonance and metadata.
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @return Major-Minor, Consonance-Dissonance and metadata plus additional
#' information if verbose=TRUE
#'
#' @rdname mami.codi
#' @export
mami.codi <- function(
    x,
    amplitude         = MINIMUM_AMPLITUDE,
    temporal_variance = NA,
    spatial_variance  = NA,
    deviation         = OCTAVE_DEVIATION,
    metadata          = NA,
    verbose            = FALSE,
    ...
) {

  parse_input(x, ...)                      %>%
    parse_variances(
      temporal_variance,
      spatial_variance
    )                                      %>%
    compute_consonance(
      amplitude,
      deviation
    )                                      %>%
    format_output(metadata, verbose)

}

#' Parse Input
#'
#' Parses the chord to analyse, coerced to hrep::sparse_fr_spectrum
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to hrep::sparse_fr_spectrum
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @rdname parse_input
#' @export
parse_input <- function(x, ...) {

  UseMethod('parse_input', x)

}

#' @rdname parse_input
#' @export
parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...), ...)

}

#' @rdname parse_input
#' @export
parse_input.sparse_fr_spectrum <- function(x, ...) {

  tibble::tibble_row(
    spectrum = list(x)
  )

}

parse_variances <- function(x, temporal_variance, spatial_variance) {

  if (is.na(temporal_variance) && is.na(spatial_variance)) {
    temporal_variance = sqrt(HEISENBERG)
    spatial_variance  = sqrt(HEISENBERG)
  } else if (is.na(spatial_variance)) {
    spatial_variance  = HEISENBERG / temporal_variance
  } else if (is.na(temporal_variance)) {
    temporal_variance = HEISENBERG / spatial_variance
  }

  x %>% dplyr::mutate(
    temporal_variance,
    spatial_variance
  )

}

#' We are dealing with frequency and wavelength ratios. The speed of sound
#' constant will disappear. We could estimate the speed of sound as:
#' * room temperature air at sea level (343 m/s)
#' * the fluid of the inner ear (1,522 m/s, ocean water at room temperature)
#' * the basilar membrane (1,640 m/s, human cartilage)
#' No matter which one we pick we would get the same consonance results.
#'
#' For giggles, though, consider a speed of sound that normalizes the range of
#' the two signals:
#'
#' c_sound = max(f) * min(f)
#'
#' For a pitch with a 100Hz fundamental and 10 harmonics, our speed of sound would be:
#'
#' c_sound = 1000 * 100 -> 1e+05
#'
#' That is a fast material. The advantage, though, for our analysis is that our
#' wavelength and frequency numbers have the same range.
#'
#' frequencies: 100 200 300 400 500 600 700 800 900 1000
#' fractions f/f_min: 1/1 2/1 3/1 4/1 5/1 6/1 7/1 8/1 9/1 10/1
#' LCD: 1
#'
#' wavelengths = l = c_sound / f
#' wavelengths: 100 111.11 125.00 142.85 166.66 200.00 250.00 333.33 500.00 1000
#' fractions l/l_min: 1/1 7/6 5/4 3/2 5/3 2/1 5/2 10/3 5/1 10/1
#' LCD: 12
#'
#' The frequency and wavelength vectors have the same range 100 to 1,000 but
#' only 4 of the same values: 100, 200, 500 and 1,000. The other 6 values are
#' different. And so the pattern recognition machinery of the auditory system,
#' which we approximate with the LCD, will perceive different cycle lengths:
#' 1 cycle for frequencies but 12 cycles for wavelengths.
#'
#' Many of the wavelength ratios will look familiar to those who know their
#' just intoned music intervals. However, the familiar ratios are not for the
#' expected dyads.
#' For example, 5/4 is the major third ratio of the high fundamental frequency
#' relative to the low fundamental frequency. However, 5/4 above is
#' the ratio of the 8th harmonic's wavelength relative to the 10th harmonic's
#' wavelength. And the ratio isn't just an approximation:
#' 125.00 / 100.00 is precisely 5 / 4.
#'
#' The two cycle estimates for the same set of harmonics are different.
#' Because the wavelength values were precisely calculated from the frequency
#' values, the disparity in the two estimates isn't the result of a lack of
#' precision from the hair cells of the basilar membrane or the
#' phase-locking speed of the auditory neurons.
#'
#' Instead, the difference in cycle estimates seems be a more fundamental
#' uncertainty that is built into the conjugate relationship between frequencies
#' and wavelengths. See Gabor 1946.
#'
#' see:
#' https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6662181/#:~:text=The%20speed%20of%20sound%20in,%2Fs)%20for%20image%20reconstruction.
#' https://itis.swiss/virtual-population/tissue-properties/database/acoustic-properties/speed-of-sound/
#' https://www.engineeringtoolbox.com/sound-speed-water-d_598.html
#' https://www.engineeringtoolbox.com/air-speed-sound-d_603.html
#'
compute_consonance = function(x, minimum_amplitude, octave_deviation) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>minimum_amplitude) %>% hrep::freq()
  c_sound = 343 # m/s
  l       = c_sound / f

  x %>% dplyr::mutate(

    alcd(f/min(f), temporal_variance, octave_deviation, 'temporal'),
    alcd(l/min(l), spatial_variance,  octave_deviation, 'spatial'),

    f0                    = min(f) / .data$temporal_alcd,
    l0                    = max(l) * .data$spatial_alcd,

    temporal_consonance   = 50 - log2(.data$temporal_alcd),
    spatial_consonance    = 50 - log2(.data$spatial_alcd),

    consonance_dissonance = .data$temporal_consonance + .data$spatial_consonance,
    major_minor           = .data$temporal_consonance - .data$spatial_consonance,

    frequencies           = list(f),
    wavelengths           = list(l),
    temporal_Sz           = log2(.data$temporal_alcd),
    spatial_Sz            = log2(.data$spatial_alcd),
    speed_of_sound        = c_sound,
    minimum_amplitude,
    temporal_variance,
    spatial_variance,
    octave_deviation

  )

}

#' Approximate Least Common Denominator
#'
#' See the articles below for previous work on approximate GCD / LCM
#'
#' "Pitch extraction from corrupted harmonics of the power spectrum"
#' II. APPROXIMATE GCD ALGORITHM
#' APPENDIX B: APPROXIMATE GCD ALGORITHM
#' Sreenivas and Rao (1978)
#'
#' "An Efficient Technique for Modeling and Synthesis of Automotive Engine Sounds"
#' IV. EXTRACTION OF DETERMINISTIC COMPONENTS USING AN SDFT
#' Amman and Das (2001)
#'
#' "A Practical Fundamental Frequency Extraction Algorithm
#' for Motion Parameters Estimation of Moving Targets"
#' Huang et al. (2014)
#' III. EXTRACTION OF A FUNDAMENTAL FREQUENCY
#' A. Extraction of the Initial Pitch Using the AGCD Method
#'
#'
#' @param x Vector of rational numbers
#' @param variance Precision for creating rational fractions
#' @param octave_deviation Deviation for approximating least common multiples
#' @param label A custom label for the output usually 'spatial' or 'temporal'
#'
#' @return The approximate least common denominator of the rational numbers
#'
#' @rdname alcd
#' @export
alcd <- function(x, variance, octave_deviation, label) {
  fractions = approximate_rational_fractions(x, variance, octave_deviation)
  tibble::tibble_row(
    alcd       = lcm_integers(fractions$den),
    fractions  = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(label, '_' , .))
}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()

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
                    'metadata')
  }
}

# Constants

#' Default Rational Fraction Precision
#'
#' Default variance for converting floating point numbers to rational fractions
#'
#' See Heisenberg's uncertainty paper, translated into English by John Archibald
#' Wheeler and Hubert Zurek, in Quantum Theory and Measurement, Wheeler and Zurek,
#' eds. (Princeton: Princeton Univ. Press, 1983), pp. 62-84.
#'
#' See Gabor, "Theory of Communication" 1946.
#'
#' See "Uncertainty Principle Inequalities and Spectrum Estimation"
#' in "Recent Advances in Fourier Analysis and Its Applications"
#' Benedetto (1989)
#' 5. Spectrum Estimation and the Viener-Vintner Theorem
#'
#' "Aspects of Gabor analysis on locally compact abelian groups"
#' Karlheinz Grochenig (1998)
#' 6.3 Uncertainty Principles and Lieb's inequalities
#' Equation (6.3.1)
#'
#' "There are various formulations of this statement [CP84, DS89, Fef83, Pri83],
#' some of which generalize to LCA groups [PS88, Smi]."
#'
#' CP84  M. G. Cowling and J. F. Price. Bandwidth versus time concentration:
#' the Heisenberg-Pauli-Weyl inequality. SIAM J. Math., 15:151 - 165, 1984.
#'
#' DS89 D. L. Donoho and P. B. Stark. Uncertainty principles and signal recovery.
#' SIAM J. Appl. Math., 49:906 - 931, 1989.
#'
#' Fef83 C.L. Fefferman. The uncertainty principle. Bull. Amer. Math. Soc.
#' (N.S.), 9(2), 1983.
#'
#' Pri83 J. F. Price. Inequalities and local uncertainty principles.
#' J. Math. Phys., 24:1711 - 1714, 1983.
#'
#' PS88 J.F. Price and A. Sitaram. Local uncertainty inequalities for locally
#' compact groups. Trans. Amer. Math. Soc., 308(1):105- 114, 1988
#'
#'
#' @rdname default_variance
#' @export
default_variance <- function() { DEFAULT_VARIANCE }
HEISENBERG = 1 / (16 * pi ^2)
DEFAULT_VARIANCE = sqrt(HEISENBERG)

#' Default Approximate Least Common Multiple Deviation
#'
#' Default octave_deviation for approximating the Least Common Multiple (LCM)
#'
#''
#' @rdname default_octave_deviation
#' @export
default_octave_deviation <- function() { OCTAVE_DEVIATION }
OCTAVE_DEVIATION = 0.11

#' Default Minimum Amplitude
#'
#' Default minimum amplitude for deciding which tones are evaluated
#'
#''
#' @rdname default_octave_deviation
#' @export
default_octave_deviation <- function() { MINIMUM_AMPLITUDE }
MINIMUM_AMPLITUDE = 0.07
