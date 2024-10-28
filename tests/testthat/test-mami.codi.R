test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$time_cycles, 1)
  expect_equal(P1$space_cycles, 1)
  expect_equal(P1$time_dissonance, 0)
  expect_equal(P1$space_dissonance, 0)
})
test_that('P1 with 3 harmonics fundamental frequency and fundamental wavenumber have different cycles',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T)
  C4_frequency = hrep::midi_to_freq(60)
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  expected_time_cycles = 1
  expect_equal(P1_3$time_cycles, expected_time_cycles)
  expect_equal(P1_3$fundamental_frequency, C4_frequency / expected_time_cycles)

  expected_space_cycles = 2
  expect_equal(P1_3$space_cycles, expected_space_cycles)
  expect_equal(P1_3$fundamental_wavenumber, C4_wavenumber / expected_space_cycles)

  expect_false(expected_time_cycles == expected_space_cycles)
})
test_that('Major-minor tonality of octave complements',{
  num_harmonics = 2

  ## Consonant Intervals

  # m3 & M6
  expected_magnitude = 2.0 # log2(4)
  dyad = c(60,63,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,69,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)

  # M3 & m6
  expected_magnitude = 1.0 # log2(2)
  dyad = c(60,64,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,68,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)

  ## Perfect Intervals

  # P4 & P5
  expected_magnitude = 0.5849625 # log2(1.5)
  dyad = c(60,65,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,67,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)

  # P1 & P8
  expected_magnitude = 0.0 # log2(1)
  dyad = c(60,60,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,72,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)

  ## Dissonant Intervals

  # M2 & m7 (traditional major-minor tonality is reversed)
  expected_magnitude = 2.3219281 # log2(5)
  dyad = c(60,62,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,70,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)

  # m2 & M7 (traditional major-minor tonality is reversed)
  expected_magnitude = 1.0 # log2(2)
  dyad = c(60,61,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,71,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)

  # tt with itself
  expected_magnitude = 0.0 # log2(1)
  dyad = c(60,66,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,66,72) %>% mami.codi(num_harmonics=2)
  expect_equal(dyad$majorness, expected_magnitude)

})
test_that('beat spectrum looks interesting',{
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(60) + f_beat)

  num_harmonics = 2
  C4_beats = c(C4_midi, C4_beat_midi) %>%
    mami.codi(include_beats=T,
              num_harmonics=num_harmonics,
              verbose=T)

  expect_equal(C4_beats$frequency_spectrum[[1]]$frequency,
               c(hrep::midi_to_freq(C4_midi), hrep::midi_to_freq(C4_beat_midi),
                 2 * hrep::midi_to_freq(C4_midi),
                 2 * hrep::midi_to_freq(C4_beat_midi)))

  expect_equal(C4_beats$frequency_spectrum[[1]]$amplitude, c(1, 1, 0.89, 0.89),
               tolerance=0.1)

  expect_equal(C4_beats$beats_spectrum[[1]]$wavelength,
               c(49.00),
               tolerance=0.1)

  expect_equal(C4_beats$beats_spectrum[[1]]$amplitude,
               c(4.00),
               tolerance=0.1)
})
test_that('beats work', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(60) + f_beat)
  num_harmonics = 2

  C4_beats = c(C4_midi, C4_beat_midi) %>%
    mami.codi(include_beats=T, num_harmonics=num_harmonics, verbose=T)

  f_expected <- c(261.62, 268.62, 523.25, 537.25)
  l_expected <- c(0.63, 0.65, 1.27, 1.31, 49.00)

  expect_equal(C4_beats$frequencies[[1]], f_expected, tolerance=0.1)
  expect_equal(C4_beats$wavelengths[[1]], l_expected, tolerance=0.001)
})
test_that('stimulus works', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(60) + f_beat)
  num_harmonics = 1
  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C4_beat_midi), num_harmonics = num_harmonics)

  # no beats stimulus
  no_beats_stimulus = stimulus(spectrum, include_beats=F)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$amplitude,
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$wavelength,
               c(1.31, 1.27),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$amplitude,
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$wavelength,
               numeric(0),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$amplitude,
               numeric(0),
               tolerance=0.1)

  # beats stimulus
  beats_stimulus = stimulus(spectrum, include_beats=T,
                            minimum_beat_wavelength=MINIMUM_BEAT_WAVELENGTH)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$amplitude,
               c(1,1),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$wavelength,
               c(49),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$amplitude,
               c(4),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$wavelength,
               c(1.31, 1.27, 49),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$amplitude,
               c(1,1,4),
               tolerance=0.1)
})
