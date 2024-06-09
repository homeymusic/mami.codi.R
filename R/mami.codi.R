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
    deviation         = APPROXIMATE_LCM_DEVIATION,
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

#' About the speed of sound
#'
#' We are dealing with ratios. Mathematically the speed of sound constant will
#' disappear. We could estimate the speed of sound in:
#' * room temperature air at sea level (343 m/s)
#' * the fluid of the inner ear (1,522 m/s, ocean water at room temperature)
#' * the basilar membrane (1,640 m/s, human cartilage)
#' No matter which one we pick we would get the same mathematical results.
#'
#' Consider a speed of sound that is normalized between the two signals:
#'
#' c_sound = max(f) / max(1/f)
#'
#' For Eb5 with 10 harmonics, our speed of sound would be
#'
#' max(Eb5_f) / max(1/Eb5_f) -> 1,627,975 m / s
#'
#' That is a fast material. The advantage, though, is that our wavelength and
#' frequency numbers will be in the same range.
#'
#' Eb5_f = 622.254 1244.508 1866.762 2489.016 3111.270 3733.524 4355.778 4978.032 5600.286 6222.540
#' Eb5_l = 6222.5396 3111.2698 2074.1799 1555.6349 1244.5079 1037.0899  888.9342  777.8175  691.3933  622.2540
#'
#' We can see that the two vectors are not identical.
#'
#' The two periodicity estimates for the same set of waves will be different.
#' This is our first glimpse at the Heisenberg-Gabor uncertainty principle.
#'
#' see:
#' https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6662181/#:~:text=The%20speed%20of%20sound%20in,%2Fs)%20for%20image%20reconstruction.
#' https://itis.swiss/virtual-population/tissue-properties/database/acoustic-properties/speed-of-sound/
#' https://www.engineeringtoolbox.com/sound-speed-water-d_598.html
#' https://www.engineeringtoolbox.com/air-speed-sound-d_603.html
#' https://en.wikipedia.org/wiki/Floating-point_arithmetic
compute_consonance = function(x, amplitude,
                              deviation) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>amplitude) %>% hrep::freq()
  c_sound = 343 # m/s
  l       = c_sound / f

  x %>% dplyr::mutate(

    alcd(f, temporal_variance, deviation, 'temporal'),
    alcd(l, spatial_variance,  deviation, 'spatial'),

    temporal_consonance   = 50 - log2(.data$temporal_alcd / .data$temporal_agcn),
    spatial_consonance    = 50 - log2(.data$spatial_alcd  / .data$spatial_agcn),

    consonance_dissonance = .data$temporal_consonance + .data$spatial_consonance,

    major_minor           = .data$temporal_consonance - .data$spatial_consonance,

    frequencies           = list(f),
    wavelengths           = list(l),
    f0                    = min(f) / .data$temporal_alcd,
    l0                    = max(l) * .data$spatial_alcd,
    temporal_Sz           = log2(.data$temporal_alcd),
    spatial_Sz            = log2(.data$spatial_alcd),
    speed_of_sound        = c_sound,
    amplitude,
    temporal_variance,
    spatial_variance,
    deviation

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
#' @param deviation Deviation for approximating least common multiples
#' @param label A custom label for the output usually 'spatial' or 'temporal'
#'
#' @return The approximate least common denominator of the rational numbers
#'
#' @rdname alcd
#' @export
alcd <- function(x, variance, deviation, label) {
  fractions = approximate_rational_fractions(x, variance, deviation)
  tibble::tibble_row(
    agcn       = gcd_integers(fractions$num),
    alcd       = lcm_integers(fractions$den),
    fractions  = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(label, '_' , .))
}
gcd_integers <- function(x) Reduce(gmp::gcd.bigz, x) %>% as.numeric()
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
#' Default deviation for approximating the Least Common Multiple (LCM)
#'
#''
#' @rdname approximate_lcm_deviation
#' @export
approximate_lcm_deviation <- function() { APPROXIMATE_LCM_DEVIATION }
APPROXIMATE_LCM_DEVIATION = 0.11

#' Default Minimum Amplitude
#'
#' Default minimum amplitude for deciding which tones are evaluated
#'
#''
#' @rdname minimum_amplitude
#' @export
minimum_amplitude <- function() { MINIMUM_AMPLITUDE }
MINIMUM_AMPLITUDE = 0.07
