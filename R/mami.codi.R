#' Major-Minor Consonance-Dissonance
#'
#' A spatiotemporal periodicity model of consonance perception.
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param amplitude_lower_bound An optional minimum amplitude_lower_bound for deciding which partials to include.
#' @param temporal_frequency_sd An optional temporal variance value for finding rational fractions.
#' @param spatial_frequency_sd  An optional spatial variance value for finding rational fractions.
#' @param approximate_lcm_sd An optional approximate_lcm_sd value for approximating least common multiples.
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
    amplitude_lower_bound = AMPLITUDE_LOWER_BOUND_DEFAULT,
    temporal_frequency_sd = NA,
    spatial_frequency_sd  = NA,
    approximate_lcm_sd    = APPROXIMATE_LCM_SD_DEFAULT,
    metadata              = NA,
    verbose               = FALSE,
    ...
) {

  parse_input(x, ...)                      %>%
    parse_variances(
      temporal_frequency_sd,
      spatial_frequency_sd
    )                                      %>%
    compute_consonance(
      amplitude_lower_bound,
      approximate_lcm_sd
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

parse_variances <- function(x, temporal_frequency_sd, spatial_frequency_sd) {

  if (is.na(spatial_frequency_sd)) {
    spatial_frequency_sd  = SPATIAL_FREQUENCY_SD_DEFAULT
  }

  if (is.na(temporal_frequency_sd)) {
    temporal_frequency_sd = TEMPORAL_FREQUENCY_SD_DEFAULT
  }

  x %>% dplyr::mutate(
    temporal_frequency_sd,
    spatial_frequency_sd
  )

}

compute_consonance = function(x, minimum_amplitude_lower_bound, approximate_lcm_sd) {

  f       = x$spectrum[[1]] %>% dplyr::filter(.data$y>minimum_amplitude_lower_bound) %>% hrep::freq()
  c_sound = 343 # m/s arbitrary, disappears in the ratios
  l       = c_sound / f

  w       = 2 * pi * f
  k       = 2 * pi / l

  x %>% dplyr::mutate(

    alcm(w, min(w), RATIO_TERM["DENOMINATOR"], .data$temporal_frequency_sd, approximate_lcm_sd, 'temporal'),
    temporal_dissonance   = log2(.data$temporal_alcm),

    alcm(k, max(k), RATIO_TERM["NUMERATOR"], .data$spatial_frequency_sd,  approximate_lcm_sd, 'spatial'),
    spatial_dissonance    = log2(.data$spatial_alcm),

    major_minor           = .data$spatial_dissonance - .data$temporal_dissonance,
    consonance_dissonance = .data$spatial_dissonance + .data$temporal_dissonance,

    # Store the metadata
    angular_frequencies   = list(w),
    wavenumbers           = list(k),
    speed_of_sound        = c_sound,
    w0                    = min(w) / .data$temporal_alcm,
    k0                    = max(k) * .data$spatial_alcm,
    minimum_amplitude_lower_bound,
    temporal_frequency_sd,
    spatial_frequency_sd,
    approximate_lcm_sd

  )

}

#' Approximate Least Common Multiple
#'
#' @param x Signal vector
#' @param reference Reference signal, this will be the denominator of the ratios
#' @param ratio_term Which term of the fraction to find the LCM: numerator or denominator
#' @param sd Standard deviation for each evaluated signal
#' @param approximate_lcm_sd Deviation for approximating least common multiples
#' @param label A custom label for the output usually 'spatial' or 'temporal'
#'
#' @return The approximate least common multiple
#'
#' @rdname alcm
#' @export
alcm <- function(x, reference, ratio_term, sd, approximate_lcm_sd, label) {
  fractions = approximate_rational_fractions(x, reference, sd, approximate_lcm_sd)
  tibble::tibble_row(
    alcm       = if (ratio_term == RATIO_TERM["NUMERATOR"]) lcm_integers(fractions$num) else lcm_integers(fractions$den),
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
APPROXIMATE_LCM_SD_DEFAULT = 0.11
AMPLITUDE_LOWER_BOUND_DEFAULT = 0.07
RATIO_TERM <- c("NUMERATOR" = 1, "DENOMINATOR" = 2)
SPATIAL_FREQUENCY_SD_DEFAULT  = 0.1
TEMPORAL_FREQUENCY_SD_DEFAULT = 100
