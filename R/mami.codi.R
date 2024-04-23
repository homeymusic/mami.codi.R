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

  f = x %>% dplyr::filter(.data$y>MIN_AMPLITUDE) %>% hrep::freq()
  λ = SPEED_OF_SOUND / f

  tibble::tibble_row(
    frequencies = list(f),
    wavelengths = list(λ)
  )

}

# TODO: write a test for c(60,60+4*12) %>% mami.codi(verbose=T, num_harmonics=11)
# the function is hearing 15 instead of 11 harmonics
listen_for_highest_fundamental = function(x) {

  f = x$frequencies[[1]]

  if (length(f) > 2) {
    potential_highest_fundamentals = f %>% find_highest_fundamental()

    estimated_pseudo_octave = (potential_highest_fundamentals %>%
                                 dplyr::count(.data$pseudo_octave, name='harmonic_number',sort=TRUE) %>%
                                 dplyr::slice(1))$pseudo_octave

    f0 =  potential_highest_fundamentals %>%
      dplyr::filter(dplyr::near(pseudo_octave, estimated_pseudo_octave), evaluation_freq == highest_freq) %>%
      dplyr::arrange(dplyr::desc(harmonic_number))

    # remove candidates that are an octave below other candidates
    i <- 1
    candidate_to_remove = c()
    while (i<=nrow(f0)){
      # TODO: find a tidyr way to do this loop
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

    tol_win = c(semitone_ratio(-RATIO_TOLERANCE, f0$pseudo_octave),
                semitone_ratio(+RATIO_TOLERANCE, f0$pseudo_octave))

    potential_lowest_harmonics = min(f) * f0$pseudo_octave ^ 0:(f0$harmonic_number)
    lowest_harmonics = (get_harmonics_in_chord(f, potential_lowest_harmonics, tol_win))$harmonics
    potential_highest_harmonics = f0$reference_freq * f0$pseudo_octave ^ 0:(f0$harmonic_number)
    highest_harmonics = (get_harmonics_in_chord(f, potential_highest_harmonics, tol_win))$harmonics

    x %>% dplyr::mutate(
      lowest_f0            = min(f),
      lowest_f0_harmonics  = list(lowest_harmonics),
      highest_f0           = f0$reference_freq,
      lowest_f0_harmonics  = list(highest_harmonics),
      pseudo_octave        = f0$pseudo_octave,
      num_harmonics        = f0$harmonic_number-1,
      fundamentals_span    = estimate_span(f0$reference_freq, min(f), f0$pseudo_octave),
      chord_span           = estimate_span(max(f), min(f), f0$pseudo_octave)
    )
  } else {
    stop("not ready for 2 or fewer frequencies")
  }
}

duplex <- function(x) {

  f = x$frequencies[[1]]

  harmonic_number = 2^(x$fundamentals_span) * (x$num_harmonics + 1)

  x %>% dplyr::mutate(

    # estimate the frequency cycle
    estimate_cycle(f, x$lowest_f0, harmonic_number, FREQ, x$pseudo_octave) %>%
      dplyr::rename_with(~ paste0(.,'_frequency')),

    # estimate the wavelength cycle
    # estimate_cycle(f, max(f), harmonic_number, WAVELENGTH, x$pseudo_octave) %>%
    #   dplyr::rename_with(~ paste0(.,'_wavelength')),
    # estimate_cycle(f, transpose_freqs(x$highest_f0, x$chord_span, x$pseudo_octave) , harmonic_number, WAVELENGTH, x$pseudo_octave) %>%
    #   dplyr::rename_with(~ paste0(.,'_wavelength')),
    estimate_cycle(f, x$highest_f0, harmonic_number, WAVELENGTH, x$pseudo_octave) %>%
      dplyr::rename_with(~ paste0(.,'_wavelength')),

  )

}

estimate_cycle <- function(x, reference, ref_harmonic_number, type, pseudo_octave) {

  tol_win = c(semitone_ratio(-RATIO_TOLERANCE, pseudo_octave),
    semitone_ratio(+RATIO_TOLERANCE, pseudo_octave))

  ref_harmonic_number = 1 / ref_harmonic_number

  if (length(x) > 2) {
    r = ratios(x, reference, tol_win, pseudo_octave, ref_harmonic_number)

    tibble::tibble_row(
      lcm        = lcm(if (type) {r$den} else {r$den}),
      dissonance = log2(.data$lcm),
      ratios     = list(r),
      tolerance_window = list(tol_win)
    )
  } else {
    stop("not ready for less than 2 frequencies")
  }

}

flip <- function(x) {

  consonance_frequency  = ZARLINO - x$dissonance_frequency
  consonance_wavelength = ZARLINO - x$dissonance_wavelength

  duplexed_lowest_f0 <- x %>% dplyr::mutate(chord_freqs = x$lowest_f0_harmonics) %>% duplex
  # consonance_frequency  = ZARLINO - x$dissonance_frequency  + duplexed_lowest_f0$dissonance_frequency
  # consonance_wavelength = ZARLINO - x$dissonance_wavelength + duplexed_lowest_f0$dissonance_wavelength


    if (consonance_frequency <= 0 | consonance_wavelength <= 0) {
    stop(paste(
      'consonance should never be less than zero',
      'if so the ZARLINO constant is too low',
      'dissonance_freq',x$dissonance_frequency,
      'dissonance_wavelength',x$dissonance_wavelength,
      'chord', x$frequencies
    ))
  }

  x %>% dplyr::mutate(
    consonance_frequency,
    consonance_wavelength,
    lowest_f0_dissonance = sqrt(duplexed_lowest_f0$dissonance_frequency^2 +
                                  duplexed_lowest_f0$dissonance_wavelength^2),
    .before=1
  )

}

rotate <- function(x) {
  browser
  rotated = (R_PI_4 %*% matrix(c(
    x$consonance_wavelength,
    x$consonance_frequency
  ))) %>% as.vector %>% zapsmall
  # )) - matrix(c(x$lowest_f0_dissonance,0))) %>% as.vector %>% zapsmall

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
    x %>%
      dplyr::select('major_minor', 'consonance_dissonance',
                    'frequencies', 'wavelengths', 'metadata')
  }
}

lcm <- function(x) Reduce(numbers::LCM, x)

semitone_ratio <- function(x, pseudo_octave, steps=TRICIA) {
  pseudo_octave^(x*steps)
}

estimate_span <- function(x, y, pseudo_octave) {
  ceiling(log((x/y)%>%zapsmall(24),pseudo_octave))
}

transpose_freqs <- function(x, register, pseudo_octave) {
  x * pseudo_octave ^ register
}

# it's convenient for us to think in base 10 so we have cents ...
CENTS                      = 12 ^ -1 * 10 ^ -2 # friendly mix of base 12 and base 10

# ... but search results of param space have been compelling with pure base 12
TRICIA                     = 12 ^ -3           # pure base 12

# default tolerance_semitone_ratio is based on fit to experimental results
RATIO_TOLERANCE  = 6            # tricia

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

FREQ = F
WAVELENGTH = T
