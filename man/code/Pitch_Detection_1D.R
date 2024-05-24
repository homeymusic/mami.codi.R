source('./man/code/utils.R')

precision       = mami.codi.R::default_precision()
num_harmonics   = 10
octave_ratio    = 1.9
amount_of_noise = 0
num_tones       = 2*amount_of_noise + num_harmonics

lo = hrep::sparse_fr_spectrum(60,
                              num_harmonics=num_harmonics,
                              octave_ratio=octave_ratio)

hi = hrep::sparse_fr_spectrum(70.9,
                              num_harmonics=num_harmonics,
                              octave_ratio=octave_ratio)

chord_spectrum = do.call(
  hrep::combine_sparse_spectra,
  list(lo, hi)
)
chord = chord_spectrum %>% mami.codi(
  precision  = precision,
  verbose = T
)

noise_spectrum = tibble::tibble(
  frequency = hrep::midi_to_freq(c(
    runif(n=amount_of_noise, min=15, max=60),
    runif(n=amount_of_noise, min=60, max=102)
  )),
  amplitude = 1
) %>% as.list() %>%  hrep::sparse_fr_spectrum()

noisy_chord_spectrum = do.call(
  hrep::combine_sparse_spectra,
  list(chord_spectrum, noise_spectrum)
)

noisy_chord = noisy_chord_spectrum %>% mami.codi(
  precision  = precision,
  verbose = T)

pause_frequency = function(spectrum, pause_index) {
  spectrum$y[pause_index] = 0
  spectrum
}

grid = tidyr::expand_grid(
  pause_index = seq_along(noisy_chord_spectrum$x)
)

mami.codi_results = grid %>% purrr::pmap_dfr(\(
  pause_index
) {
  noisy_chord_spectrum           %>%
    pause_frequency(
      pause_index
    ) %>%
    mami.codi.R::mami.codi(
      precision = precision,
      metadata  = list(
        paused_index = pause_index
      ),
      verbose=T
    )
}, .progress=TRUE)

scores = mami.codi_results %>% dplyr::rowwise() %>% dplyr::mutate(
  paused_f    = noisy_chord_spectrum$x[metadata$paused_index],
  change      = noisy_chord$consonance_dissonance - consonance_dissonance,
  noisy_codi  = noisy_chord$consonance_dissonance,
  paused_codi = consonance_dissonance,
  clean_codi  = chord$consonance_dissonance,
)  %>% dplyr::ungroup()

results = scores %>%
  dplyr::arrange(
    change,
    paused_f
  )  %>%
  dplyr::mutate(
    row_id = dplyr::row_number(),
    .before = 1
  )

results %>% dplyr::select(
  row_id,
  paused_f,
  noisy_codi,
  paused_codi,
  clean_codi,
  change
) %>% print(n=Inf)

lo$x
hi$x
