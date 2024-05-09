chord = c(60) %>% mami.codi(num_harmonics = 10, verbose = T)
chord_spectrum = chord$spectrum[[1]]

amount_of_noise = 5
noise_spectrum = tibble::tibble(
  frequency = c(
    runif(n=amount_of_noise, min=30, max=60),
    runif(n=amount_of_noise, min=60, max=102),
    runif(n=amount_of_noise, min=102, max=127)
  ),
  amplitude = 1
) %>% as.list() %>%  hrep::sparse_fr_spectrum()

first_missing_fundamental  = noisy_chord_spectrum$x / 2
second_missing_fundamental = noisy_chord_spectrum$x / 4
missing_fundamentals_spectrum = tibble::tibble(
  frequency = c(first_missing_fundamental[first_missing_fundamental>10],
                second_missing_fundamental[second_missing_fundamental>10]),
  amplitude = 1
) %>% as.list() %>%  hrep::sparse_fr_spectrum()

noisy_chord_spectrum = do.call(
  hrep::combine_sparse_spectra,
  # list(chord_spectrum, noise_spectrum, missing_fundamentals_spectrum)
  list(chord_spectrum, noise_spectrum)
)

noisy_chord = noisy_chord_spectrum %>% mami.codi(verbose = T)

pause_frequency = function(spectrum, index) {
  spectrum$y[index] = 0
  spectrum
}

looped_paused = noisy_chord_spectrum$x %>% purrr::imap_dfr(\(frequency, index) {
  wavelength_tolerance = default_tolerance('wavelength', 'M3M6') / 10
  frequency_tolerance =  wavelength_tolerance / 2
  # wavelength_tolerance = default_tolerance('wavelength', 'macro')
  # frequency_tolerance =  wavelength_tolerance / 2
  noisy_chord_spectrum %>%
    pause_frequency(index) %>%
    mami.codi(
      frequency_tolerance = frequency_tolerance,
      wavelength_tolerance = wavelength_tolerance,
      metadata = list(
        paused_frequency = frequency
      ),
      verbose=T
    )
}) %>% dplyr::rowwise() %>% dplyr::mutate(
  paused_frequency = metadata$paused_frequency,
  total_distance  = sqrt((noisy_chord$consonance_dissonance-consonance_dissonance)^2 +
                           (noisy_chord$major_minor-major_minor)^2),
  codi_distance  = abs(noisy_chord$consonance_dissonance-consonance_dissonance),
  mami_distance  = abs(noisy_chord$major_minor-major_minor)
)

chord %>% dplyr::select(consonance_dissonance, major_minor)
noisy_chord %>% dplyr::select(consonance_dissonance, major_minor)

results = looped_paused %>%
  dplyr::arrange(dplyr::desc(total_distance)) %>%
  dplyr::select(paused_frequency, total_distance, codi_distance, mami_distance, consonance_dissonance, major_minor)

print(results, n=50)

chord_spectrum$x
