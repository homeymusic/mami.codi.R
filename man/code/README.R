github_result = devtools::install('/Users/homeymusic/Documents/git/homeymusic/mami.codi.R')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

source('./man/code/utils.R')

library(mami.codi.R)
devtools::load_all(".")

output.rds = './man/data/output/readme.rds'
prepare(output.rds)

experiment.rds = './man/data/input/Pure.rds'
grid_1 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=1,
  octave_ratio=2.0,
  timbre = 'Pure'
)

experiment.rds = './man/data/input/Bonang.rds'
grid_Bonang = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=4,
  octave_ratio=2,
  timbre = 'Bonang'
)

experiment.rds = './man/data/input/5Partials.rds'
grid_5 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=5,
  octave_ratio=2.0,
  timbre='5Partials'
)

experiment.rds = './man/data/input/5PartialsNo3.rds'
grid_5PartialsNo3 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=5,
  octave_ratio=2.0,
  timbre = '5PartialsNo3'
)

experiment.rds = './man/data/input/Harmonic.rds'
grid_10 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre='Harmonic'
)

experiment.rds = './man/data/input/Stretched.rds'
grid_10_stretched = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics = 10,
  octave_ratio = 2.1,
  timbre = 'Stretched'
)

experiment.rds = './man/data/input/Compressed.rds'
grid_10_compressed = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=1.9,
  timbre = 'Compressed'
)

experiment.rds = './man/data/input/M3.rds'
grid_M3 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'M3'
)

experiment.rds = './man/data/input/M6.rds'
grid_M6 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'M6'
)

experiment.rds = './man/data/input/P8.rds'
grid_P8 = tidyr::expand_grid(
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'P8'
)

grid = dplyr::bind_rows(grid_1,
                        grid_Bonang,
                        grid_5,grid_5PartialsNo3,
                        grid_10,grid_10_stretched,grid_10_compressed,
                        grid_M3,grid_M6,grid_P8)


plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(interval,
                                           num_harmonics,
                                           octave_ratio,
                                           timbre) {

  if (timbre == 'Bonang') {
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

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))
  } else if (timbre == '5PartialsNo3') {
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

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))
  } else {
    study_chord = c(0, interval) %>% hrep::sparse_fr_spectrum(
      num_harmonics = num_harmonics,
      octave_ratio  = octave_ratio,
      roll_off_dB   = 3.0
    )
  }

  mami.codi.R::mami.codi(study_chord,
                         metadata = list(
                           num_harmonics       = num_harmonics,
                           octave_ratio        = octave_ratio,
                           semitone            = interval,
                           timbre              = timbre
                         ),
                         verbose=TRUE)

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))
saveRDS(output,output.rds)
