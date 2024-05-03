search_label = 'Stretched'
from_tol     = 0.001
to_tol       = 0.1
by_tol       = 0.001
tonic_midi   = 60

source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(tonic_midi,72) %>% mami.codi.R::mami.codi(verbose=T)
if (dplyr::near(max(P8$wavelengths[[1]]),  SPEED_OF_SOUND / hrep::midi_to_freq(60))) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

delete_3rd_partial = F
num_harmonics      = 10
octave_ratio       = 2.0
roll_off           = 3

if (search_label == 'Stretched') {
  octave_ratio  = 2.1
} else if (search_label == 'Compressed') {
  octave_ratio  = 1.9
} else if (search_label == 'Pure') {
  num_harmonics = 1
}

if (delete_3rd_partial) {
  print(paste('!!! WARNING: DELETING 3rd PARTIAL:',delete_3rd_partial,'!!!'))
} else {
  print(paste('delete 3rd partial?',delete_3rd_partial))
}
print(search_label)
print(paste('octave_ratio:',octave_ratio))
print(paste('num_harmonics:',num_harmonics))
print(paste('roll_off:',roll_off))

rds = paste0('../data/tolerance_',
             search_label,
             '.rds')
prepare(rds)

behavior.rds = paste0('../data/',
                      search_label,
                      '.rds')
behavior = readRDS(behavior.rds)

intervals = tonic_midi + behavior$profile$interval
index = seq_along(intervals)

tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

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
  if (search_label=='Bonang') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass_df <- tibble::tibble(
      frequency = bass_f0 * 1:4,
      amplitude = 1
    )
    upper_f0 <- hrep::midi_to_freq(intervals[index])
    chord_df <- tibble::tibble(
      frequency = c(upper_f0 * c(1, 1.52, 3.46, 3.92),
                    bass_df$frequency) %>% unique %>% sort,
      amplitude = 1
    )
    chord = chord_df %>% as.list() %>% hrep::sparse_fr_spectrum()
  } else {
    chord = hrep::sparse_fr_spectrum(c(tonic_midi, intervals[index]),
                                     num_harmonics = num_harmonics,
                                     roll_off_dB   = roll_off,
                                     octave_ratio  = octave_ratio
                                     )
  }

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
    tolerance      = tolerance,
    metadata       = list(
      octave_ratio   = octave_ratio,
      num_harmonics  = num_harmonics,
      roll_off_dB    = roll_off,
      semitone       = intervals[index] - tonic_midi
    ),
    verbose=F
  )
}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(data,rds)
