run_trials <- function(search_label, amplitude_lower_bounds) {
  devtools::load_all(".")
  tonic_midi = 60
  source('./utils.R')

  library(mami.codi.R)

  num_harmonics = 10
  octave_ratio  = 2.0

  if (search_label == 'Rolloff2') {
    roll_off = 2
  } else if (search_label == 'Rolloff7') {
    roll_off = 7
  } else if (search_label == 'Rolloff12') {
    roll_off = 12
  }

  print(search_label)
  print(paste('octave_ratio:',octave_ratio))
  print(paste('num_harmonics:',num_harmonics))
  print(paste('roll_off:',roll_off))

  rds = paste0('../data/amplitude_lower_bound_',
               search_label,
               '.rds')
  prepare(rds)

  experiment.csv = paste0('../data/',
                          'roll_off_', roll_off,
                          '.csv')

  experiment = read.csv(experiment.csv) %>%
    dplyr::rename(
      consonance_dissonance = rating,
      semitone              = interval
    )

  intervals = tonic_midi + experiment$semitone

  grid = tidyr::expand_grid(
    interval  = intervals,
    amplitude_lower_bound = amplitude_lower_bounds
  )

  print(grid)

  plan(multisession, workers=parallelly::availableCores())

  data = grid %>% furrr::future_pmap_dfr(\(
    interval,
    amplitude_lower_bound
  ) {

    chord = hrep::sparse_fr_spectrum(c(tonic_midi, interval),
                                     num_harmonics = num_harmonics,
                                     roll_off_dB   = roll_off,
                                     octave_ratio  = octave_ratio
    )

    mami.codi.R::mami.codi(
      chord,
      amplitude_lower_bound        = amplitude_lower_bound,
      metadata         = list(
        octave_ratio   = octave_ratio,
        num_harmonics  = num_harmonics,
        roll_off_dB    = roll_off,
        semitone       = interval - tonic_midi
      ),
      verbose=T
    )
  }, .progress=TRUE, .options = furrr::furrr_options(seed = T))

  saveRDS(data,rds)
}
