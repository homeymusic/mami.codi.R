search_label = 'Harmonic'
devtools::load_all(".")
if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # tolerances   = 10^-(1:10)
  tolerances   = c(1 %o% 10^(-8:-1), default_tolerance('macro')) %>% sort()
} else {

  # Detailed
  # from_tol     = 0.01
  # to_tol       = 0.1
  # by_tol       = 0.001
  # tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  # Orders of Magnitude
  # tolerances   = c(1:9 %o% 10^(-2:-2)) %>% rev()
  # spatial_tolerance  = tolerances
  # temporal_tolerance = tolerances

  # Zoomed in Harmonic
  # space 0.056 to 0.072
  spatial_tolerance  = seq(from=0.02, to=0.07, by=0.005)
  # time 0.068 to 0.093
  temporal_tolerance = seq(from=0.02, to=0.07, by=0.005)

  # for Bonang time  0.02 to 0.05
  # for Bonang space 0.02 to 0.07

  # for Harmonic time > 0.05
}

tonic_midi         = 60
octave_ratio       = 2.0
roll_off           = 3

source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='major_minor_tuning')

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(tonic_midi,72) %>% mami.codi.R::mami.codi(verbose=T)
if (P8$temporal_tolerance == mami.codi.R::default_tolerance('temporal','macro')) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}


print(search_label)
print(paste('octave_ratio:',octave_ratio))
print(paste('roll_off:',roll_off))

rds = paste0('../data/tolerance_2D_',
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
  temporal_tolerance = temporal_tolerance,
  spatial_tolerance  = spatial_tolerance
)

print(grid)

plan(multisession, workers=parallelly::availableCores())


if (search_label == 'Stretched') {
  octave_ratio  = 2.1
  global_num_harmonics = 10
} else if (search_label == 'Compressed') {
  octave_ratio  = 1.9
  global_num_harmonics = 10
} else if (search_label == 'Pure') {
  global_num_harmonics = 1
} else if (search_label=='5Partials') {
  global_num_harmonics = 5
} else {
  global_num_harmonics = 10
}
print(paste('num_harmonics:',global_num_harmonics))

data = grid %>% furrr::future_pmap_dfr(\(
  index,
  temporal_tolerance,
  spatial_tolerance
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
                                     num_harmonics = global_num_harmonics,
                                     roll_off_dB   = roll_off,
                                     octave_ratio  = octave_ratio
    )
  }

  mami.codi.R::mami.codi(
    chord,
    temporal_tolerance  = temporal_tolerance,
    spatial_tolerance = spatial_tolerance,
    metadata       = list(
      octave_ratio   = octave_ratio,
      num_harmonics  = global_num_harmonics,
      roll_off_dB    = roll_off,
      semitone       = intervals[index] - tonic_midi
    ),
    verbose=F
  )
}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(data,rds)
