#' Major-Minor Consonance-Dissonance
#'
#' Provides an auditory model of music perception
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to
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
mami.codi <- function(x, metadata=NA, verbose=FALSE,...) {

  parse_input(x, ...)             %>%
    listen_for_harmonics           %>%
    select_ref_freqs              %>%
    duplex                        %>%
    flip                          %>%
    rotate                        %>%
    format_output(metadata, verbose)

}

parse_input <- function(x,...) {

  UseMethod('parse_input', x)

}

parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...),
              ...)

}

parse_input.sparse_fr_spectrum <- function(x, ...) {

  tibble::tibble_row(
    chord = list(x)
  )

}

listen_for_harmonics = function(x) {
  chords = x$chord[[1]] %>% dplyr::filter(.data$y>MIN_AMPLITUDE)
  potential_harmonics =  chords %>% hrep::freq() %>% analyze_harmonics(chords %>% hrep::amp())

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

  x %>% dplyr::mutate(
    pseudo_octave       = max(root_harmonics$pseudo_octave),
    num_harmonics       = nrow(root_harmonics)
  )
}

select_ref_freqs <- function(x) {

  c_freqs   = x$chord[[1]] %>% dplyr::filter(.data$y>MIN_AMPLITUDE) %>%
    hrep::freq()

  x %>% dplyr::mutate(
    chord_freqs         = list(c_freqs),
    reference_freq_low  = min(x$chord[[1]]$x),
    reference_freq_high = max(x$chord[[1]]$x)
  )

}

duplex <- function(x) {

  tol_win = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE, x$pseudo_octave),
                semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE, x$pseudo_octave))

  x %>% dplyr::mutate(

    # estimate the frequency cycle
    estimate_cycle(x$chord_freqs[[1]], x$reference_freq_low,  tol_win,
                x$pseudo_octave, ref_harmonic_number = 0) %>%
      dplyr::rename_with(~ paste0(.,'_low')),

    # estimate the wavelength cycle
    estimate_cycle(SPEED_OF_SOUND / x$chord_freqs[[1]], SPEED_OF_SOUND / x$reference_freq_high, tol_win,
                x$pseudo_octave, ref_harmonic_number = x$num_harmonics) %>%
      dplyr::rename_with(~ paste0(.,'_high')),

    tolerance_window = list(tol_win)
  )

}

flip <- function(x) {

  consonance_low  = ZARLINO - x$dissonance_low
  consonance_high = ZARLINO - x$dissonance_high

  if (consonance_low <= 0 | consonance_high <= 0) {
    stop(paste(
      'consonance should never be less than zero',
      'if so the ZARLINO constant is too low',
      'dissonance_low',x$dissonance_low,
      'dissonance_high',x$dissonance_high,
      'chord', x$chord_freqs
    ))
  }

  x %>% dplyr::mutate(
    consonance_low,
    consonance_high,
    .before=1
  )

}

rotate <- function(x) {

  rotated = (R_PI_4 %*% matrix(c(
    x$consonance_high,
    x$consonance_low
  ))) %>% as.vector %>% zapsmall

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
                        'chord', 'metadata')
  }
}

estimate_cycle <- function(x, reference, tolerance_window, pseudo_octave, ref_harmonic_number) {

    r = ratios(x, reference, tolerance_window, pseudo_octave, ref_harmonic_number)

    tibble::tibble_row(
      lcm        = lcm(if (ref_harmonic_number == 0) r$den else r$num),
      dissonance = log2(.data$lcm),
      ratios     = list(r)
    )

}

lcm <- function(x) Reduce(numbers::LCM, x)

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
DEFAULT_SEMITONE_TOLERANCE = (12^2)/6           # tricia

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

SPEED_OF_SOUND = 343
