source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='major_minor_tuning')

library(mami.codi.R)
devtools::load_all(".")

tonic_midi = 60

P8 <- c(tonic_midi,72) %>% mami.codi.R::mami.codi(verbose=T)
if (P8$tolerance == mami.codi.R::default_tolerance('macro')) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

output.rds = '../data/framed_dyads.rds'
prepare(output.rds)


macro_experiment.rds = '../data/Pure.rds'
macro_intervals = tonic_midi + readRDS(macro_experiment.rds)$profile$interval
macro_index = seq_along(macro_intervals)

num_harmonics = 1
octave_ratio  = 2.0
roll_off      = 3
scale = 'macro'
grid_1 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  scale = 'Pure'
)

num_harmonics = 5
octave_ratio  = 2.0
grid_5 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  scale
)

num_harmonics = 10
octave_ratio  = c(1.9,2.0,2.1)
grid_10 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  scale
)

grid_Bonang = tidyr::expand_grid(
  index=macro_index,
  num_harmonics=4,
  octave_ratio=2, # the bass is harmonic
  scale = 'Bonang'
)

grid_5PartialsNo3 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics=5,
  octave_ratio=2,
  scale = '5PartialsNo3'
)

num_harmonics = 10
octave_ratio  = c(2.0)
experiment.rds = '../data/M3.rds'
M3_intervals = tonic_midi + readRDS(experiment.rds)$profile$interval
index = seq_along(M3_intervals)
grid_M3 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'M3'
)

experiment.rds = '../data/M6.rds'
M6_intervals = tonic_midi + readRDS(experiment.rds)$profile$interval
index = seq_along(M6_intervals)
grid_M6 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'M6'
)

experiment.rds = '../data/P8.rds'
P8_intervals = tonic_midi + readRDS(experiment.rds)$profile$interval
index = seq_along(P8_intervals)
grid_P8 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'P8'
)

grid = dplyr::bind_rows(grid_1,grid_5,grid_10,grid_M3,grid_M6,
                        grid_P8,
                        grid_Bonang,grid_5PartialsNo3)


plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(index, num_harmonics, octave_ratio,
                                           scale) {

  octave_midi = hrep::freq_to_midi(octave_ratio * hrep::midi_to_freq(tonic_midi))

  if (scale == 'M3') {
    study_intervals = M3_intervals
  } else if (scale == 'M6') {
    study_intervals = M6_intervals
  } else if (scale == 'P8') {
    study_intervals = P8_intervals
  } else {
    study_intervals = macro_intervals
  }

  if (scale == 'Bonang') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass <- tibble::tibble(
      frequency = bass_f0 * c(1:4),
      amplitude = 1
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    upper_f0 <- hrep::midi_to_freq(study_intervals[index])
    upper <- tibble::tibble(
      frequency = upper_f0 * c(1, 1.52, 3.46, 3.92),
      amplitude = 1
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    octave_f0 <- hrep::midi_to_freq(octave_midi)
    octave <- tibble::tibble(
      frequency = octave_f0 * c(1:4),
      amplitude = 1
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper,octave))
  } else if (scale == '5PartialsNo3') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass <- tibble::tibble(
      frequency = bass_f0 * c(1:5),
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    upper_f0 <- hrep::midi_to_freq(study_intervals[index])
    upper <- tibble::tibble(
      frequency = upper_f0 * 1:5,
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    octave_f0 <- hrep::midi_to_freq(octave_midi)
    octave <- tibble::tibble(
      frequency = octave_f0 * c(1:5),
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    study_chord = do.call(hrep::combine_sparse_spectra, list(bass,upper,octave))
  } else {
    study_chord = c(tonic_midi, study_intervals[index], octave_midi) %>% hrep::sparse_fr_spectrum(
      num_harmonics = num_harmonics,
      octave_ratio  = octave_ratio,
      roll_off_dB   = roll_off
    )
  }

  if (scale=='M3' || scale=='M6' || scale=='P8') {
    spatial_tolerance  = mami.codi.R::default_tolerance('spatial','micro')
    temporal_tolerance = mami.codi.R::default_tolerance('temporal', 'micro')
  } else {
    spatial_tolerance  = mami.codi.R::default_tolerance('spatial','macro')
    temporal_tolerance = mami.codi.R::default_tolerance('temporal', 'macro')
  }

  mami.codi.R::mami.codi(study_chord,
                         spatial_tolerance=spatial_tolerance,
                         temporal_tolerance=temporal_tolerance,
                         metadata  = list(
                           num_harmonics = num_harmonics,
                           octave_ratio  = octave_ratio,
                           semitone      = study_intervals[index] - tonic_midi,
                           scale         = scale
                         ),
                         verbose=TRUE)

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))
saveRDS(output,output.rds)
