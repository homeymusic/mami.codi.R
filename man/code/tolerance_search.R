search_label = 'Harmonic'
if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # tolerances   = 10^-(1:10)
  tolerances   = c(1:9 %o% 10^(-6:-4))
} else {
  from_tol     = 0.1
  to_tol       = 0.2
  by_tol       = 0.01
  tolerances = seq(from=from_tol, to=to_tol, by=by_tol)
}

tonic_midi   = 60

source('./utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R', ref='bm_ratios')

library(mami.codi.R)
devtools::load_all(".")

P8 <- c(tonic_midi,72) %>% mami.codi.R::mami.codi(verbose=T)
if (P8$frequency_tolerance == mami.codi.R::default_tolerance('macro')) {
  print("Seems to be the correct version mami.codi.R")
} else {
  stop("This is not the expected version of mami.codi.R")
}

num_harmonics = 10
octave_ratio  = 2.0
roll_off      = 3

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

grid = tidyr::expand_grid(
  index,
  frequency_tolerance  = tolerances,
  wavelength_tolerance = tolerances
)

print(grid)

plan(multisession, workers=parallelly::availableCores())

data = grid %>% furrr::future_pmap_dfr(\(
  index,
  frequency_tolerance,
  wavelength_tolerance
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
    frequency_tolerance  = frequency_tolerance,
    wavelength_tolerance = wavelength_tolerance,
    metadata       = list(
      octave_ratio   = octave_ratio,
      num_harmonics  = num_harmonics,
      roll_off_dB    = roll_off,
      semitone       = intervals[index] - tonic_midi
    ),
    verbose=T
  )
}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

saveRDS(data,rds)
