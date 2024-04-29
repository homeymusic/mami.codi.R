source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R', ref="wavelength_vs_frequency")

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(60,72) %>% mami.codi.R::mami.codi(verbose=T)
if (dplyr::near(max(P8$wavelengths[[1]]),  343 / hrep::midi_to_freq(60))) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

output.rds = '../data/roll_off_timbre_paper.rds'
prepare(output.rds)

tonic = 60

macro_experiment.rds = '../data/Pure.rds'
macro_chords = tibble::tibble(
  pitches =  readRDS(macro_experiment.rds)$profile$interval %>%
    lapply(\(i) list(c(tonic,tonic+i)))
)
macro_index = seq_along(macro_chords$pitches)

num_harmonics = 10
octave_ratio  = 2.0
roll_off=c(2,7,12)
grid_10 = tidyr::expand_grid(
  index=macro_index,
  num_harmonics,
  octave_ratio,
  roll_off
)

grid = dplyr::bind_rows(grid_10)

plan(multisession, workers=parallelly::availableCores())

output = grid %>% furrr::future_pmap_dfr(\(index, num_harmonics, octave_ratio,
                                           roll_off) {

  study_chords = macro_chords
  study_chord = hrep::sparse_fr_spectrum(study_chords$pitches[index][[1]][[1]],
                                         num_harmonics = num_harmonics,
                                         octave_ratio  = octave_ratio,
                                         roll_off_dB      = roll_off)

  mami.codi.R::mami.codi(study_chord,
                         metadata = list(
                           num_harmonics = num_harmonics,
                           octave_ratio  = octave_ratio,
                           semitone      = study_chords$pitches[index][[1]][[1]][2] - tonic,
                           roll_off      = roll_off
                         ),
                         num_harmonics=num_harmonics,
                         octave_ratio=octave_ratio,
                         verbose=TRUE)

}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(output,output.rds)
