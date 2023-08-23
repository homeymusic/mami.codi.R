source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

library(mami.codi.R)
devtools::load_all(".")

delete_3rd_partial = F
num_harmonics = 10
search_label  = 'P8'
octave_ratio  = 2.0

print(search_label)
if (delete_3rd_partial) {
  print(paste('!!! WARNING: DELETING 3rd PARTIAL:',delete_3rd_partial,'!!!'))
} else {
  print(paste('delete 3rd partial?',delete_3rd_partial))
}
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

tolerances = 1:48

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
    tolerance_semitone_ratio = tolerance,
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
