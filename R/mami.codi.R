#' Major-Minor Consonance-Dissonance
#'
#' A spatiotemporal periodicity model of consonance perception.
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param amplitude An optional minimum amplitude for deciding which partials to include.
#' @param temporal_standard_deviation An optional temporal standard_deviation value for finding rational fractions.
#' @param spatial_standard_deviation  An optional spatial standard_deviation value for finding rational fractions.
#' @param harmonics_deviation An optional deviation value for approximating least common multiples.
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
    minimum_amplitude           = MINIMUM_AMPLITUDE,
    temporal_standard_deviation = STANDARD_DEVIATION,
    spatial_standard_deviation  = STANDARD_DEVIATION,
    harmonics_deviation         = HARMONICS_DEVIATION,
    metadata                    = NA,
    verbose                     = FALSE,
    ...
) {

  parse_input(x, ...) %>%
    compute_cyclicity(minimum_amplitude,
                      temporal_standard_deviation,
                      spatial_standard_deviation,
                      harmonics_deviation) %>%
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

compute_cyclicity = function(x, minimum_amplitude, temporal_standard_deviation, spatial_standard_deviation, harmonics_deviation) {

  f = x$spectrum[[1]] %>% dplyr::filter(.data$y>minimum_amplitude) %>% hrep::freq()
  P = 1 / f
  l = C_SOUND * P
  k = 1 / l

  x %>% dplyr::mutate(

    cycles(f/min(f), RATIO$DEN, temporal_standard_deviation, harmonics_deviation, 'temporal'),
    cycles(l/min(l), RATIO$DEN, spatial_standard_deviation,  harmonics_deviation, 'spatial'),

    temporal_dissonance   = log2(.data$temporal_cycles),
    spatial_dissonance    = log2(.data$spatial_cycles),

    dissonance             = .data$spatial_dissonance + .data$temporal_dissonance,
    majorness              = .data$spatial_dissonance - .data$temporal_dissonance,

    polar_dissonance       = sqrt((.data$spatial_dissonance)^2 + (.data$temporal_dissonance)^2),
    polar_majorness        = atan2(.data$temporal_dissonance, .data$spatial_dissonance),

    fundamental_frequency  = min(f) / .data$temporal_cycles,
    fundamental_wavenumber = min(k) / .data$spatial_cycles,

    # Store the metadata
    frequencies            = list(f),
    periods                = list(P),
    wavenumbers            = list(k),
    wavelengths            = list(l),
    speed_of_sound         = C_SOUND,
    minimum_amplitude,
    temporal_standard_deviation,
    spatial_standard_deviation,
    harmonics_deviation

  )

}

#' Approximate Number of Cycles of Complex Wave
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
#' @param lcm_of Use the numerator or denominator to find cycle length
#' @param standard_deviation Precision for creating rational fractions
#' @param harmonics_deviation Deviation for approximating least common multiples
#' @param label A custom label for the output usually 'spatial' or 'temporal'
#'
#' @return Estimate the number of cycles using approximate least common denominator of the rational numbers
#'
#' @rdname cycles
#' @export
cycles <- function(x, lcm_of, standard_deviation, harmonics_deviation, label) {
  fractions = approximate_rational_fractions(x, standard_deviation, harmonics_deviation)

  if (any(fractions$num == 0) || any(fractions$den == 0)) {
    stop(sprintf("Error: A numerator or denominator was 0. This should never happen.\n x: %s \n nums: %s \n dens: %s \n std: %f \n hdev: %f",
                 paste(x, collapse = ", "),
                 paste(fractions$num, collapse = ", "),
                 paste(fractions$den, collapse = ", "),
                 standard_deviation,
                 harmonics_deviation))
  }

  t = tibble::tibble_row(
    cycles = if (lcm_of == RATIO$DEN) {
      lcm_integers(fractions$den)
    } else if (lcm_of == RATIO$NUM) {
      lcm_integers(fractions$num)
    } else {
      NA
    },
    fractions = list(fractions)
  ) %>% dplyr::rename_with(~ paste0(label, '_' , .))
  t
}
lcm_integers <- function(x) Reduce(gmp::lcm.bigz, x) %>% as.numeric()
RATIO <- list(NUM = 1, DEN = 2)

format_output <- function(x, metadata, verbose) {
  x <- x %>% tibble::add_column(
    metadata=list(metadata)
  )

  if (verbose) {
    x
  } else {
    x %>%
      dplyr::select('majorness',
                    'dissonance',
                    'metadata')
  }
}

# Constants

#' Default Rational Fraction Precision
#'
#' Default standard_deviation for converting floating point numbers to rational fractions
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

C_SOUND = 1 # m/s arbitrary, disappears in the ratios
