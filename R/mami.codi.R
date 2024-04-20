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

  parse_input(x, ...)              %>%
    listen_for_highest_fundamental %>%
    select_refs               %>%
    duplex                         %>%
    flip                           %>%
    rotate                         %>%
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

listen_for_highest_fundamental = function(x) {

  chords = x$chord[[1]] %>% dplyr::filter(.data$y>MIN_AMPLITUDE)

  potential_highest_fundamentals = chords %>% hrep::freq() %>%
    find_highest_fundamental(chords %>% hrep::amp())

  estimated_pseudo_octave = (potential_highest_fundamentals %>%
                               dplyr::count(.data$pseudo_octave, name='harmonic_number',sort=TRUE) %>%
                               dplyr::slice(1))$pseudo_octave

  f0 =  potential_highest_fundamentals %>%
    dplyr::filter(dplyr::near(pseudo_octave, estimated_pseudo_octave), evaluation_freq == highest_freq) %>%
    dplyr::arrange(dplyr::desc(harmonic_number))

  # start: remove candidates that are an octave below other candidates
  # TODO: find a tidyr way to do this
  i <- 1
  candidate_to_remove = c()
  while (i<=nrow(f0)){
    j <- 1
    while (j<=nrow(f0)){
      if (f0[i,]$harmonic_number == 2 * f0[j,]$harmonic_number) {
        candidate_to_remove = append(candidate_to_remove, i)
      }
      j <- j+1
    }
    i <- i+1
  }
  if (length(candidate_to_remove) > 0) {
    f0 <- f0[-candidate_to_remove,]
  }

  f0 = f0[1,]

  x %>% dplyr::mutate(
    pseudo_octave = f0$pseudo_octave,
    num_harmonics = f0$harmonic_number-1,
    highest_f0    = f0$reference_freq
  )
}

select_refs <- function(x) {

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
      dplyr::rename_with(~ paste0(.,'_freq')),

    # estimate the wavelength cycle
    estimate_cycle(SPEED_OF_SOUND / x$chord_freqs[[1]], SPEED_OF_SOUND / x$reference_freq_high, tol_win,
                x$pseudo_octave, ref_harmonic_number = x$num_harmonics) %>%
      dplyr::rename_with(~ paste0(.,'_wavelength')),

    tolerance_window = list(tol_win)
  )

}

flip <- function(x) {

  consonance_freq       = ZARLINO - x$dissonance_freq
  consonance_wavelength = ZARLINO - x$dissonance_wavelength

  if (consonance_freq <= 0 | consonance_wavelength <= 0) {
    stop(paste(
      'consonance should never be less than zero',
      'if so the ZARLINO constant is too low',
      'dissonance_freq',x$dissonance_freq,
      'dissonance_wavelength',x$dissonance_wavelength,
      'chord', x$chord_freqs
    ))
  }

  x %>% dplyr::mutate(
    consonance_freq,
    consonance_wavelength,
    .before=1
  )

}

rotate <- function(x) {

  rotated = (R_PI_4 %*% matrix(c(
    x$consonance_wavelength,
    x$consonance_freq
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

# it's convenient for us to think in base 10 so we have cents ...
CENTS                      = 12 ^ -1 * 10 ^ -2 # friendly mix of base 12 and base 10

# ... but search results of param space have been compelling with pure base 12
TRICIA                     = 12 ^ -3           # pure base 12

# default tolerance_semitone_ratio is based on fit to experimental results
DEFAULT_SEMITONE_TOLERANCE = (12^2)/6           # tricia

# define perfect consonance as the pure-tone unison post-pi/4 rotation
# pure tones show pure octave-complementarity so tip of the hat to Zarlino
ZARLINO                    = 100 / sqrt(2)     # Z

# once log relative cycle length becomes consonance those units will be called:
# gRameuas (g) or gRams for short :~))
# heavy, stable, high-gravity chords have higher values than
# light, passing, low-gravity chords. consonance is like mass.

MIN_AMPLITUDE = 1/12

PI_4 = pi / 4

R_PI_4 = matrix(c(
  cos(PI_4), sin(PI_4),
  -sin(PI_4), cos(PI_4)
), nrow = 2, ncol = 2, byrow = TRUE)

SPEED_OF_SOUND = 343 # m/S
