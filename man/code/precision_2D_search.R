search_label       = 'Compressed'
precisions         = c(1:9 %o% 10^(-3:-1))
temporal_precision = precisions
spatial_precision  = precisions
# temporal_precision = seq(from=0.005, to=0.007, by=0.0001)
# spatial_precision  = seq(from=0.008, to=0.01,  by=0.0001)

tonic_midi         = 60
num_harmonics      = 10
octave_ratio       = 2.0
roll_off           = 3

source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='f0_fmin')

library(mami.codi.R)
devtools::load_all(".")

if (search_label == 'Stretched') {
  octave_ratio  = 2.1
} else if (search_label == 'Compressed') {
  octave_ratio  = 1.9
} else if (search_label == 'Pure') {
  num_harmonics = 1
}

print(search_label)
print(paste('octave_ratio:',octave_ratio))
print(paste('num_harmonics:',num_harmonics))
print(paste('roll_off:',roll_off))

rds = paste0('../data/precision_2D_',
             search_label,
             '.rds')
prepare(rds)

behavior.rds = paste0('../data/',
                      search_label,
                      '.rds')
behavior = readRDS(behavior.rds)

intervals = tonic_midi + behavior$profile$interval
index = seq_along(intervals)

grid = tidyr::expand_grid(
  index,
  temporal_precision  = temporal_precision,
  spatial_precision = spatial_precision
)

print(grid)

plan(multisession, workers=parallelly::availableCores())

data = grid %>% furrr::future_pmap_dfr(\(
  index,
  temporal_precision,
  spatial_precision
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
  } else if (search_label == '5PartialsNo3') {
    bass_f0 <- hrep::midi_to_freq(tonic_midi)
    bass <- tibble::tibble(
      frequency = bass_f0 * 1:5,
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    upper_f0 <- hrep::midi_to_freq(intervals[index])
    upper <- tibble::tibble(
      frequency = upper_f0 * 1:5,
      amplitude = c(1, 1, 0, 1, 1)
    ) %>% as.list() %>%  hrep::sparse_fr_spectrum()

    chord = do.call(hrep::combine_sparse_spectra, list(bass,upper))

  } else {
    chord = hrep::sparse_fr_spectrum(c(tonic_midi, intervals[index]),
                                     num_harmonics = num_harmonics,
                                     roll_off_dB   = roll_off,
                                     octave_ratio  = octave_ratio
    )
  }


  mami.codi.R::mami.codi(
    chord,
    temporal_precision  = temporal_precision,
    spatial_precision = spatial_precision,
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
