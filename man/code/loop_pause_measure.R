wavelength_tolerance = default_tolerance('wavelength', 'macro') / 100
frequency_tolerance =  wavelength_tolerance / 2

chord = c(60) %>% mami.codi(      frequency_tolerance = frequency_tolerance,
                                  wavelength_tolerance = wavelength_tolerance,
                                  num_harmonics = 10, verbose = T)
chord_spectrum = chord$spectrum[[1]]

amount_of_noise = 2
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
  frequency_tolerance = frequency_tolerance,
  wavelength_tolerance = wavelength_tolerance,
  verbose = T)

pause_frequency = function(spectrum, index) {
  spectrum$y[index] = 0
  spectrum
}

looped_paused = noisy_chord_spectrum$x %>% purrr::imap_dfr(\(frequency, index) {
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
  dplyr::arrange(total_distance, paused_frequency) %>%
  dplyr::select(paused_frequency, total_distance, codi_distance, mami_distance, consonance_dissonance, major_minor)

print(results, n=50)

chord_spectrum$x
