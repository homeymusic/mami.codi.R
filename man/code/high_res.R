source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

library(mami.codi.R)
devtools::load_all(".")

output.rds = '../data/high_res.rds'
prepare(output.rds)

tonic = 60

macro_chords = tibble::tibble(
  pitches =  seq(0,15,1/30000) %>%
    lapply(\(i) list(c(tonic,tonic+i)))
)
macro_index = seq_along(macro_chords$pitches)

num_harmonics = 10
octave_ratio  = 2.0
scale = 'macro'
grid_10 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  scale
)
grid = dplyr::bind_rows(grid_10)

plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(index, num_harmonics, octave_ratio,
                                           scale) {

  if (scale == 'macro') {
    study_chords = macro_chords
  }
  study_chord = hrep::sparse_fr_spectrum(study_chords$pitches[index][[1]][[1]],
                                         num_harmonics = num_harmonics,
                                         octave_ratio  = octave_ratio)


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

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(output,output.rds)
