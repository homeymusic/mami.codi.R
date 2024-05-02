source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R', ref="framed_no_octave_factor")

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(60,72) %>% mami.codi.R::mami.codi(verbose=T)
if (dplyr::near(max(P8$wavelengths[[1]]),  343 / hrep::midi_to_freq(60))) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

output.rds = '../data/timbre_paper.rds'
prepare(output.rds)

tonic = 60

macro_experiment.rds = '../data/Pure.rds'
macro_chords = tibble::tibble(
  pitches =  readRDS(macro_experiment.rds)$profile$interval %>%
    lapply(\(i) list(c(tonic,tonic+i)))
)
macro_index = seq_along(macro_chords$pitches)

num_harmonics = 1
octave_ratio  = 2.0
scale = 'macro'
grid_1 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  scale
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

num_harmonics = 10
octave_ratio  = c(2.0)

experiment.rds = '../data/M3.rds'
intervals = 60 + readRDS(experiment.rds)$profile$interval
M3_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(M3_chords$pitches)
grid_M3 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'M3'
)

experiment.rds = '../data/M6.rds'
intervals = 60 + readRDS(experiment.rds)$profile$interval
M6_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(M6_chords$pitches)
grid_M6 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'M6'
)

experiment.rds = '../data/P8.rds'
intervals = 60 + readRDS(experiment.rds)$profile$interval
P8_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(P8_chords$pitches)
grid_P8 = tidyr::expand_grid(
  index,
  num_harmonics,
  octave_ratio,
  scale = 'P8'
)

intervals = tonic + seq(0, 15 , 1/4000)
hi_res_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(hi_res_chords$pitches)

grid_hi_res_5 = tidyr::expand_grid(
  index,
  num_harmonics=5,
  octave_ratio,
  scale = 'hi_res'
)

experiment.rds = '../data/Bonang.rds'
intervals = 60 + readRDS(experiment.rds)$profile$interval
Bonang_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(Bonang_chords$pitches)
grid_Bonang = tidyr::expand_grid(
  index,
  num_harmonics=4,
  octave_ratio=2, # the bass is harmonic
  scale = 'Bonang'
)

experiment.rds = '../data/5PartialsNo3.rds'
intervals = 60 + readRDS(experiment.rds)$profile$interval
FivePartialsNo3_chords = tibble::tibble(
  pitches = intervals %>% lapply(\(i) list(c(tonic,i)))
)
index = seq_along(FivePartialsNo3_chords$pitches)
grid_5PartialsNo3 = tidyr::expand_grid(
  index,
  num_harmonics=5,
  octave_ratio=2, # the bass is harmonic
  scale = '5PartialsNo3'
)

grid = dplyr::bind_rows(grid_1,grid_5,grid_10,grid_M3,grid_M6,
                        grid_P8,grid_hi_res_5,
                        grid_Bonang,grid_5PartialsNo3)

plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(index, num_harmonics, octave_ratio,
                                           scale) {

  if (scale == 'Bonang') {
    study_chords = Bonang_chords

    tonic_f0 <- hrep::midi_to_freq(study_chords$pitches[index][[1]][[1]][1])
    tonic_df <- tibble::tibble(
      frequency = tonic_f0 * 1:4,
      amplitude = 1
    )

    upper_f0 <- hrep::midi_to_freq(study_chords$pitches[index][[1]][[1]][2])
    chord_df <- tibble::tibble(
      frequency = c(upper_f0 * c(1, 1.52, 3.46, 3.92),
                    tonic_df$frequency) %>% unique %>% sort,
      amplitude = 1
    )

    study_chord = chord_df %>% as.list() %>% hrep::sparse_fr_spectrum()

  } else {
    if (scale == 'macro' | scale == '5PartialsNo3') {
      study_chords = macro_chords
    } else if (scale == 'M3') {
      study_chords = M3_chords
    } else if (scale == 'M6') {
      study_chords = M6_chords
    } else if (scale == 'P8') {
      study_chords = P8_chords
    } else if (scale == 'hi_res') {
      study_chords = hi_res_chords
    }
    study_chord = hrep::sparse_fr_spectrum(study_chords$pitches[index][[1]][[1]],
                                           num_harmonics = num_harmonics,
                                           octave_ratio  = octave_ratio)

    if (scale == '5PartialsNo3') {
      if (length(study_chord$y)==5) {
        study_chord$y[3] = 0
      } else if (length(study_chord$y)==10) {
        study_chord$y[c(5,6)] = 0
      } else {
        stop('only dyads are supported for deleted harmonics.')
      }
    }
  }

  if (scale=='M3' || scale=='M6' || scale=='P8') {
    mami.codi.R::mami.codi(study_chord,
                           tolerance=0.0,
                           metadata = list(
                             tolerance=0.0002,
                             num_harmonics = num_harmonics,
                             octave_ratio  = octave_ratio,
                             semitone      = study_chords$pitches[index][[1]][[1]][2] - tonic,
                             scale         = scale
                           ),
                           num_harmonics=num_harmonics,
                           octave_ratio=octave_ratio,
                           verbose=TRUE)

  } else {
    mami.codi.R::mami.codi(study_chord,
                           metadata = list(
                             num_harmonics = num_harmonics,
                             octave_ratio  = octave_ratio,
                             semitone      = study_chords$pitches[index][[1]][[1]][2] - tonic,
                             scale         = scale
                           ),
                           num_harmonics=num_harmonics,
                           octave_ratio=octave_ratio,
                           verbose=TRUE)

  }

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(output,output.rds)
