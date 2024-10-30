run_trials <- function(search_label, sfoae_num_harmonics) {
  devtools::load_all(".")
  source('./man/code/utils.R')

  library(mami.codi.R)

  num_harmonics = 10
  octave_ratio  = 2.0
  roll_off      = 3

  if (search_label == 'Stretched') {
    octave_ratio  = 2.1
  } else if (search_label == 'Compressed') {
    octave_ratio  = 1.9
  } else if (search_label == 'Pure') {
    num_harmonics = 1
  } else if (search_label == '5Partials') {
    num_harmonics = 5
  }

  print(search_label)
  print(paste('sfoae_num_harmonics:',sfoae_num_harmonics))
  print(paste('octave_ratio:',octave_ratio))
  print(paste('num_harmonics:',num_harmonics))
  print(paste('roll_off:',roll_off))

  output_rds = paste0('./man/data/output/sfoae_num_harmonics_',
               search_label,
               '.rds')
  prepare(output_rds)

  behavior.rds = paste0('./man/data/input/',
                        search_label,
                        '.rds')
  behavior = readRDS(behavior.rds)

  interval = behavior$profile$interval

  grid = tidyr::expand_grid(
    interval,
    sfoae_num_harmonics = sfoae_num_harmonics
  )

  print(grid)

  plan(multisession, workers=parallelly::availableCores())

  data = grid %>% furrr::future_pmap_dfr(\(
    interval,
    sfoae_num_harmonics
  ) {

    if (search_label=='Bonang') {

      bass_f0 <- hrep::midi_to_freq(0)
      bass <- tibble::tibble(
        frequency = bass_f0 * 1:4,
        amplitude = 1
      ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

      upper_f0 <- hrep::midi_to_freq(interval)
      upper <- tibble::tibble(
        frequency = upper_f0 * c(1, 1.52, 3.46, 3.92),
        amplitude = 1
      ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

      chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))

    } else if (search_label == '5PartialsNo3') {
      bass_f0 <- hrep::midi_to_freq(0)
      bass <- tibble::tibble(
        frequency = bass_f0 * 1:5,
        amplitude = c(1, 1, 0, 1, 1)
      ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

      upper_f0 <- hrep::midi_to_freq(interval)
      upper <- tibble::tibble(
        frequency = upper_f0 * 1:5,
        amplitude = c(1, 1, 0, 1, 1)
      ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

      chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))
    } else {
      chord = hrep::sparse_fr_spectrum(c(0, interval),
                                       num_harmonics = num_harmonics,
                                       roll_off_dB   = roll_off,
                                       octave_ratio  = octave_ratio
      )
    }


    mami.codi.R::mami.codi(
      chord,
      sfoae_num_harmonics   = sfoae_num_harmonics,
      metadata              = list(
        octave_ratio        = octave_ratio,
        num_harmonics       = num_harmonics,
        roll_off_dB         = roll_off,
        semitone            = interval
      ),
      verbose=T
    )
  }, .progress=TRUE, .options = furrr::furrr_options(seed = T))

  saveRDS(data,output_rds)
}
