source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

library(mami.codi.R)
devtools::load_all(".")

tonic_midi = 60

output.rds = '../data/readme.rds'
prepare(output.rds)

default_standard_deviation = mami.codi.R::default_standard_deviation()
experiment.rds = '../data/Pure.rds'
grid_1 = tidyr::expand_grid(
  temporal_standard_deviation = 0.03,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=1,
  octave_ratio=2.0,
  timbre = 'Pure'
)

experiment.rds = '../data/Bonang.rds'
grid_Bonang = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation / 2,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=4,
  octave_ratio=2,
  timbre = 'Bonang'
)

experiment.rds = '../data/5Partials.rds'
grid_5 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=5,
  octave_ratio=2.0,
  timbre='5Partials'
)

experiment.rds = '../data/5PartialsNo3.rds'
grid_5PartialsNo3 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=5,
  octave_ratio=2.0,
  timbre = '5PartialsNo3'
)

experiment.rds = '../data/Harmonic.rds'
grid_10 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre='Harmonic'
)

experiment.rds = '../data/Stretched.rds'
grid_10_stretched = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics = 10,
  octave_ratio = 2.1,
  timbre = 'Stretched'
)

experiment.rds = '../data/Compressed.rds'
grid_10_compressed = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=1.9,
  timbre = 'Compressed'
)

experiment.rds = '../data/M3.rds'
grid_M3 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'M3'
)

experiment.rds = '../data/M6.rds'
grid_M6 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'M6'
)

experiment.rds = '../data/P8.rds'
grid_P8 = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'P8'
)

experiment.rds = '../data/P8ZoomedTemporal.rds'
grid_P8_zoomed_temporal = tidyr::expand_grid(
  temporal_standard_deviation = 5e-05,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'P8ZoomedTemporal'
)

experiment.rds = '../data/P8ZoomedSpatial.rds'
grid_P8_zoomed_spatial = tidyr::expand_grid(
  temporal_standard_deviation = default_standard_deviation() / 5e-05,
  interval = readRDS(experiment.rds)$profile$interval,
  num_harmonics=10,
  octave_ratio=2.0,
  timbre = 'P8ZoomedSpatial'
)

grid = dplyr::bind_rows(grid_1,
                        grid_Bonang,
                        grid_5,grid_5PartialsNo3,
                        grid_10,grid_10_stretched,grid_10_compressed,
                        grid_M3,grid_M6,grid_P8,
                        grid_P8_zoomed_temporal,grid_P8_zoomed_spatial
                        )


plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(temporal_standard_deviation,
                                           interval,
                                           num_harmonics,
                                           octave_ratio,
                                           timbre) {

  if (timbre == 'Bonang') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass <- tibble::tibble(
      frequency = bass_f0 * 1:4,
      amplitude = 1
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    upper_f0 <- hrep::midi_to_freq(interval + tonic_midi)
    upper <- tibble::tibble(
      frequency = upper_f0 * c(1, 1.52, 3.46, 3.92),
      amplitude = 1
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))
  } else if (timbre == '5PartialsNo3') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass <- tibble::tibble(
      frequency = bass_f0 * 1:5,
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    upper_f0 <- hrep::midi_to_freq(interval + tonic_midi)
    upper <- tibble::tibble(
      frequency = upper_f0 * 1:5,
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))
  } else {
    study_chord = c(tonic_midi, interval + tonic_midi) %>% hrep::sparse_fr_spectrum(
      num_harmonics = num_harmonics,
      octave_ratio  = octave_ratio,
      roll_off_dB   = 3.0
    )
  }

  mami.codi.R::mami.codi(study_chord,
                         temporal_standard_deviation = temporal_standard_deviation,
                         metadata = list(
                           num_harmonics = num_harmonics,
                           octave_ratio  = octave_ratio,
                           semitone      = interval,
                           timbre        = timbre
                         ),
                         verbose=TRUE)

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))
saveRDS(output,output.rds)
