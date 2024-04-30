search_label  = 'P8'

source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(60,72) %>% mami.codi.R::mami.codi(verbose=T)
if (dplyr::near(max(P8$wavelengths[[1]]),  343 / hrep::midi_to_freq(60))) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

delete_3rd_partial = F
num_harmonics = 10
octave_ratio  = 2.0

if (search_label == 'Stretched') {
  octave_ratio  = 2.1
} else if (search_label == 'Compressed') {
  octave_ratio  = 1.9
}

if (delete_3rd_partial) {
  print(paste('!!! WARNING: DELETING 3rd PARTIAL:',delete_3rd_partial,'!!!'))
} else {
  print(paste('delete 3rd partial?',delete_3rd_partial))
}
print(search_label)
print(paste('octave_ratio:',octave_ratio))
print(paste('num_harmonics:',num_harmonics))

rds = paste0('../data/tolerance_',
             search_label,
             '.rds')
prepare(rds)

behavior.rds = paste0('../data/',
                      search_label,
                      '.rds')
behavior = readRDS(behavior.rds)

tonic_midi = 60
chords = tibble::tibble(
  pitches = behavior$profile$interval %>% lapply(\(i) list(c(tonic_midi,tonic_midi+i)))
)
index = seq_along(chords$pitches)

tolerances = seq(from=0.001, to=0.1, by=0.001)

grid = tidyr::expand_grid(
  index,
  tolerance  = tolerances
)

print(grid)

plan(multisession, workers=parallelly::availableCores())

data = grid %>% furrr::future_pmap_dfr(\(
  index,
  tolerance
) {

  chord = hrep::sparse_fr_spectrum(chords$pitches[index][[1]][[1]],
                                   num_harmonics = num_harmonics,
                                   octave_ratio  = octave_ratio)

  if (delete_3rd_partial) {
    if (length(chord$y)==num_harmonics) {
      chord$y[3] = 0
    } else if (length(chord$y)== 2*num_harmonics) {
      chord$y[c(5,6)] = 0
    } else {
      stop('only dyads are supported for deleted harmonics.')
    }
  }

  mami.codi.R::mami.codi(
    chord,
    tolerance=tolerance,
    metadata  = list(
      tolerance=tolerance,
      octave_ratio=octave_ratio,
      num_harmonics  = num_harmonics,
      semitone = chords$pitches[index][[1]][[1]][2] - tonic_midi
    ),
    verbose=F
  )
}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(data,rds)
