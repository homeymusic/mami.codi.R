source('./man/code/utils.R')
devtools::install_github('git@github.com:homeymusic/mami.codi.R')

spatial_tolerance  = 0.05
temporal_tolerance = 0.05
tonic_midi = 60
num_harmonics = 10
amount_of_noise = 2
num_tones= 3*amount_of_noise + num_harmonics

chord = c(tonic_midi) %>% mami.codi(
  spatial_tolerance  = spatial_tolerance,
  temporal_tolerance = temporal_tolerance,
  num_harmonics      = num_harmonics, verbose = T)
chord_spectrum = chord$spectrum[[1]]

noise_spectrum = tibble::tibble(
  frequency = hrep::midi_to_freq(c(
    runif(n=amount_of_noise, min=0, max=60),
    runif(n=amount_of_noise, min=60, max=102),
    runif(n=amount_of_noise, min=102, max=127)
  )),
  amplitude = 1
) %>% as.list() %>%  hrep::sparse_fr_spectrum()

noisy_chord_spectrum = do.call(
  hrep::combine_sparse_spectra,
  list(chord_spectrum, noise_spectrum)
)

noisy_chord = noisy_chord_spectrum %>% mami.codi(
  spatial_tolerance  = spatial_tolerance,
  temporal_tolerance = temporal_tolerance,
  verbose = T)

pause_frequencies = function(spectrum, pause_index_1, pause_index_2, pause_index_3) {
  spectrum$y[pause_index_1] = 0
  spectrum$y[pause_index_2] = 0
  spectrum$y[pause_index_3] = 0
  spectrum
}

pause_frequency = function(spectrum, pause_index) {
  spectrum$y[pause_index] = 0
  spectrum
}

grid = tidyr::expand_grid(
  pause_index_1 = seq_along(noisy_chord_spectrum$x),
  pause_index_2 = seq_along(noisy_chord_spectrum$x),
  pause_index_3 = seq_along(noisy_chord_spectrum$x),
)

plan(multisession, workers=parallelly::availableCores())

data = grid %>% furrr::future_pmap_dfr(\(
  pause_index_1,
  pause_index_2,
  pause_index_3
) {
  noisy_chord_spectrum           %>%
    pause_frequencies(
      pause_index_1,
      pause_index_2,
      pause_index_3
    ) %>%
    mami.codi.R::mami.codi(
      metadata = list(
        paused_index_1 = pause_index_1,
        paused_index_2 = pause_index_2,
        paused_index_3 = pause_index_3
      ),
      verbose=T
    )
}, .progress=TRUE, .options = furrr::furrr_options(seed = T))

scores = mami.codi_results %>% dplyr::rowwise() %>% dplyr::mutate(
        paused_f_1  = noisy_chord_spectrum$x[metadata$paused_index_1],
        paused_f_2  = noisy_chord_spectrum$x[metadata$paused_index_2],
        paused_f_3  = noisy_chord_spectrum$x[metadata$paused_index_3],
        change      = abs(consonance_dissonance - noisy_chord$consonance_dissonance),
        noisy_codi  = noisy_chord$consonance_dissonance,
        paused_codi = consonance_dissonance,
        clean_codi  = chord$consonance_dissonance,
)  %>% dplyr::ungroup()

results = scores %>%
  dplyr::arrange(
    change,
    paused_f_1,
    paused_f_2,
    paused_f_3
  )  %>%
  dplyr::mutate(
    row_id = dplyr::row_number(),
    .before = 1
  )

results %>% dplyr::select(
  row_id,
  paused_f_1,
  paused_f_2,
  noisy_codi,
  paused_codi,
  change,
  clean_codi
) %>% print(n=Inf)

results %>%
  dplyr::group_by(paused_f_1) %>%
  dplyr::summarize(change = sum(change)) %>%
  dplyr::arrange(change) %>%
  dplyr::select(
  paused_f_1,
  change
) %>% print(n=Inf)

chord$spectrum[[1]]$x
