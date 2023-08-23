#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
#' hrep::sparse_fr_spectrum
#' @param tonic Tonic pitch specified in MIDI, coerced to
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
mami.codi <- function(x, tonic=NULL, metadata=NA, verbose=FALSE,...) {

  parse_input(x, tonic, ...) %>%
    detect_tonic_pitch %>%
    select_ref_pitches  %>%
    duplex             %>%
    flip               %>%
    rotate             %>%
    format_output(metadata, verbose)

}

parse_input <- function(x, tonic=NULL,...) {

  UseMethod('parse_input', x)

}

parse_input.default <- function(x, tonic=NULL, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...),
              tonic = if (!is.null(tonic)) hrep::sparse_fr_spectrum(tonic,...) else NULL,
              ...)

}

parse_input.sparse_fr_spectrum <- function(x, tonic=NULL, ...) {

  tibble::tibble_row(
    chord = list(x),
    tonic = list(tonic)
  )

}

# TODO: clearly separate concept of tonic from root concept
# tonic is the tonal center of a broader context and must be passed in explicitly
# set root to the tonic if it is passed otherwise it must be found in the chord
detect_tonic_pitch <- function(x) {

  c_freqs   = x$chord[[1]] %>% dplyr::filter(.data$y>MIN_AMPLITUDE) %>%
    hrep::freq()

  if (!is.null(x$tonic[[1]])) {
    t_freqs = x$tonic[[1]] %>% dplyr::filter(.data$y>MIN_AMPLITUDE) %>%
      hrep::freq()
    tonic_pitch = listen_for_harmonics(t_freqs)
  } else {
    tonic_pitch = listen_for_harmonics(c_freqs)
    t_freqs = tonic_pitch$freq
    tonic   = tibble::tibble(frequency = t_freqs, amplitude = 1) %>%
      as.list %>% hrep::sparse_fr_spectrum()
    x$tonic = list(tonic)
  }

  a_freqs   = c(t_freqs,c_freqs)

  x %>% dplyr::mutate(
    chord_freqs   = list(c_freqs),
    tonic_freqs   = list(t_freqs),
    all_freqs     = list(a_freqs),
    pseudo_octave = tonic_pitch$pseudo_octave %>% max
  )

}

select_ref_pitches <- function(x) {
  x %>% dplyr::mutate(
    distance_below_tonic     = distance(min(x$all_freqs[[1]]),
                                       min(x$tonic_freqs[[1]]),
                                       x$pseudo_octave),
    distance_above_tonic     = distance(max(x$all_freqs[[1]]),
                                       min(x$tonic_freqs[[1]]),
                                       x$pseudo_octave),
    distance_tonic_harmonics = distance(max(x$tonic_freqs[[1]]),
                                        min(x$tonic_freqs[[1]]),
                                        x$pseudo_octave),
    reference_register_low   = floor(min(.data$distance_below_tonic, -BUFFER)),
    reference_register_high  = ceiling(max(.data$distance_above_tonic,
                                           +BUFFER + .data$distance_tonic_harmonics)),
    calibration_register_low = floor(-BUFFER),
    calibration_register_high = ceiling(.data$distance_tonic_harmonics + BUFFER),
    reference_freq_low        = transpose_freqs(min(x$tonic_freqs[[1]]),
                                              .data$reference_register_low,
                                              x$pseudo_octave),
    reference_freq_high       = transpose_freqs(min(x$tonic_freqs[[1]]),
                                              .data$reference_register_high,
                                              x$pseudo_octave)
  )

}

duplex <- function(x) {

  tol_win = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE, x$pseudo_octave),
                semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE, x$pseudo_octave))

  x %>% dplyr::mutate(
    estimate_cycle(x$chord_freqs[[1]], x$reference_freq_low,  tol_win,
                x$pseudo_octave, FREQUENCY, 2^(abs(x$reference_register_low -
                                                     x$calibration_register_low))) %>%
      dplyr::rename_with(~ paste0(.,'_low')),
    estimate_cycle(x$chord_freqs[[1]], x$reference_freq_high, tol_win,
                x$pseudo_octave, PERIOD, 2^(x$reference_register_high -
                                              x$calibration_register_high)) %>%
      dplyr::rename_with(~ paste0(.,'_high')),
    tolerance_window = list(tol_win)
  )

}

flip <- function(x) {

  duplexed_tonic <- x %>% dplyr::mutate(chord_freqs = x$tonic_freqs) %>% duplex

  consonance_low  = ZARLINO - x$dissonance_low  + duplexed_tonic$dissonance_low
  consonance_high = ZARLINO - x$dissonance_high + duplexed_tonic$dissonance_high

  if (consonance_low <= 0 | consonance_high <= 0) {
    stop(paste(
      'consonance should never be less than zero',
      'if so the ZARLINO constant is too low',
      'dissonance_low',x$dissonance_low,
      'dissonance_high',x$dissonance_high,
      'chord', x$chord_freqs,
      'tonic', x$tonic_freqs,
    ))
  }

  x %>% dplyr::mutate(
    consonance_low,
    consonance_high,
    tonic_dissonance = sqrt(duplexed_tonic$dissonance_low^2 +
                              duplexed_tonic$dissonance_high^2),
    .before=1
  )

}

rotate <- function(x) {

  rotated = (R_PI_4 %*% matrix(c(
    x$consonance_high,
    x$consonance_low
  )) - matrix(c(x$tonic_dissonance,0))) %>% as.vector %>% zapsmall

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
    x %>% dplyr::select('major_minor', 'consonance_dissonance',
                        'tonic', 'chord', 'metadata')
  }
}

estimate_cycle <- function(x, reference_freq, tolerance_window, pseudo_octave,
                           ratio_type=FREQUENCY, lcm_factor) {

  r = ratios(x, reference_freq, tolerance_window, pseudo_octave, ratio_type)

  tibble::tibble_row(
    lcm        = lcm(r$den) * lcm_factor,
    dissonance = log2(.data$lcm),
    # TODO: remove period and freq and their tests for now.
    period     = as.integer(.data$lcm) / min(x),
    freq       = 1 / .data$period,
    ratios     = list(r)
  )

}

lcm <- function(x) Reduce(numbers::LCM, x)

listen_for_harmonics = function(x) {
  potential_harmonics = x %>% analyze_harmonics

  estimated_pseudo_octave = (potential_harmonics %>%
                               dplyr::count(.data$pseudo_octave, name='num_harmonics',sort=TRUE) %>%
                               dplyr::slice(1))$pseudo_octave

  root_harmonics = potential_harmonics %>%
    dplyr::filter(.data$pseudo_octave==1 |
                    dplyr::near(.data$pseudo_octave,estimated_pseudo_octave))

  if (nrow(root_harmonics)==1) {
    root_harmonics$pseudo_octave = 2.0
    root_harmonics
  } else {
    root_harmonics %>% dplyr::distinct()
  }
}

semitone_ratio <- function(x, pseudo_octave, steps=TRICIA) {
  pseudo_octave^(x*steps)
}

distance <- function(x, y, pseudo_octave) {
  log((x/y)%>%zapsmall(24),pseudo_octave)
}

transpose_freqs <- function(x, register, pseudo_octave) {
  x * pseudo_octave ^ register
}

# it's convenient for us to think in base 10 so we have cents ...
CENTS                      = 12 ^ -1 * 10 ^ -2 # friendly mix of base 12 and base 10

# ... but search results of param space have been compelling with pure base 12
TRICIA                     = 12 ^ -3           # pure base 12

# default tolerance_octave_ratio
DEFAULT_OCTAVE_TOLERANCE   = 12^3/4        # tricia

# default tolerance_semitone_ratio is based on fit to experimental results
DEFAULT_SEMITONE_TOLERANCE = (12^2)/6                # tricia

# define perfect consonance as the pure-tone unison post-pi/4 rotation
# pure tones show pure octave-complementarity so tip of the hat to Zarlino
ZARLINO                    = 100 / sqrt(2)     # Z

# once log relative cycle length becomes consonance those units will be called:
# gRameuas (g) or gRams for short :~))
# heavy, stable, high-gravity chords have higher values than
# light, passing, low-gravity chords. consonance is like mass.

DEFAULT_OCTAVE_RATIO = 2.0

PURE_TONE = tibble::tibble_row(
  pseudo_octave  = DEFAULT_OCTAVE_RATIO,
  num_harmonics  = 1,
  harmonics      = list(1)
)

MIN_AMPLITUDE = 1/12
BUFFER        = 1

PI_4 = pi / 4

R_PI_4 = matrix(c(
  cos(PI_4), sin(PI_4),
  -sin(PI_4), cos(PI_4)
), nrow = 2, ncol = 2, byrow = TRUE)

FREQUENCY=F
PERIOD=T
