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
test_that('beat spectrum looks interesting near P1',{
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

  expect_equal(C4_beats$frequency_spectrum[[1]]$amplitude %>% sort, c(0.89, 0.89,1,1),
               tolerance=0.1)

  expect_equal(C4_beats$beats_spectrum[[1]]$wavelength %>% sort,
               c(1.34, 24.50, 49.00),
               tolerance=0.1)

  expect_equal(C4_beats$beats_spectrum[[1]]$amplitude %>% sort,
               c(3.57, 3.17, 4.00) %>% sort,
               tolerance=0.1)
})
test_that('stimulus works beats near P1', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  num_harmonics = 1
  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C4_beat_midi), num_harmonics = num_harmonics)

  # no beats stimulus
  no_beats_stimulus = stimulus(spectrum, include_beats=F)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(1.31, 1.27),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$wavelength %>% sort,
               numeric(0),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$amplitude %>% sort,
               numeric(0),
               tolerance=0.1)

  # beats stimulus
  beats_stimulus = stimulus(spectrum, include_beats=T)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,1),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$wavelength %>% sort,
               c(49),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$amplitude %>% sort,
               c(4),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(1.31, 1.27, 49),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(1,1,4),
               tolerance=0.1)
})

test_that('stimulus works beats near P8 with 2 harmonics', {
  C4_midi = 60
  C5_midi = 72
  f_beat  = 7 # Hz
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)
  num_harmonics = 2

  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C5_beat_midi), num_harmonics = num_harmonics)

  # no beats stimulus
  no_beats_stimulus = stimulus(spectrum, include_beats=F)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$frequency %>% sort,
               c(261.6256, 523.2511, 530.2511, 1060.5022),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$frequency_spectrum[[1]]$amplitude %>% sort,
               c(0.89,0.89,1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(0.32, 0.64, 0.65, 1.31),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(0.89,0.89,1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$wavelength %>% sort,
               numeric(0),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$beats_spectrum[[1]]$amplitude %>% sort,
               numeric(0),
               tolerance=0.1)

  # beats stimulus
  beats_stimulus = stimulus(spectrum, include_beats=T)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$frequency %>% sort,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,0.89,1,0.89),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$wavelength  %>% sort,
               c(49.00),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$amplitude %>% sort,
               c(3.57),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(0.32, 0.64, 0.65, 1.31, 49.00) %>% sort,
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(0.89, 3.57, 1.00, 0.89, 1.00) %>% sort,
               tolerance=0.1)
})


test_that('mamai.codi works with beats near the unison', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  num_harmonics = 1

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       include_beats=T,
                       num_harmonics=num_harmonics,
                       verbose=T)

  expect_equal(P1_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(P1_beats$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,1),
               tolerance=0.1)
  expect_equal(P1_beats$beats_spectrum[[1]]$wavelength %>% sort,
               c(49),
               tolerance=0.1)
  expect_equal(P1_beats$beats_spectrum[[1]]$amplitude %>% sort,
               c(4),
               tolerance=0.1)
  expect_equal(P1_beats$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(1.31, 1.27, 49),
               tolerance=0.1)
  expect_equal(P1_beats$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(1,1,4),
               tolerance=0.1)

  expect_equal(P1_beats$time_cycles, 1)
  expect_equal(P1_beats$space_cycles, 3)
})

test_that('mamai.codi works with beats near the octave P8 with 2 harmonics', {
  C4_midi = 60
  C5_midi = 72
  f_beat  = 7 # Hz
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)
  num_harmonics = 2

  P8_beats = mami.codi(c(C4_midi, C5_beat_midi),
                       include_beats=T,
                       num_harmonics=num_harmonics,
                       verbose=T)

  expect_equal(P8_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(P8_beats$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,0.89,1,0.89),
               tolerance=0.1)
  expect_equal(P8_beats$beats_spectrum[[1]]$wavelength %>% sort,
               c(49.00),
               tolerance=0.1)
  expect_equal(P8_beats$beats_spectrum[[1]]$amplitude %>% sort,
               c(3.57),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(0.32, 0.64, 0.65, 1.31, 49.00),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(0.89, 0.89, 1.00, 1.0, 3.57) %>% sort(),
               tolerance=0.1)

  expect_equal(P8_beats$time_cycles, 1)
  expect_equal(P8_beats$space_cycles, 2)

  P8 = mami.codi(c(C4_midi, C5_midi),
                 include_beats=T,
                 num_harmonics=num_harmonics,
                 verbose=T)
  expect_equal(P8$time_cycles, 1)
  expect_equal(P8$space_cycles, 1)

})

test_that('stimulus works at octave P8 with 2 harmonics', {
  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)
  num_harmonics = 2
  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C5_beat_midi), num_harmonics = num_harmonics)

  # beats stimulus
  beats_stimulus = stimulus(spectrum, include_beats=T)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$frequency,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(beats_stimulus$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,1, 0.89, 0.89) %>% sort(),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$wavelength %>% sort,
               c(49.00),
               tolerance=0.1)
  expect_equal(beats_stimulus$beats_spectrum[[1]]$amplitude %>% sort,
               c(3.57),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(0.32, 0.64, 0.65, 1.31, 49.00),
               tolerance=0.1)
  expect_equal(beats_stimulus$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(0.89, 0.89, 1.00, 1.00, 3.57) %>% sort(),
               tolerance=0.1)
})

test_that('mami codi with beats around unison and octave', {
  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz
  num_harmonics = 2

  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)

  P1 = mami.codi(c(C4_midi),
                 include_beats=T,
                 num_harmonics = num_harmonics,
                 verbose =T)

  expect_equal(P1$time_fractions[[1]]$num %>% sort(), c(1,2))
  expect_equal(P1$time_fractions[[1]]$den %>% sort(), c(1,1))
  expect_equal(P1$space_fractions[[1]]$num %>% sort(), c(1,2))
  expect_equal(P1$space_fractions[[1]]$den %>% sort(), c(1,1))

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)

  expect_equal(P1_beats$time_fractions[[1]]$num %>% sort(), c(1,1,2,2))
  expect_equal(P1_beats$time_fractions[[1]]$den %>% sort(), c(1,1,1,1))
  expect_equal(P1_beats$space_fractions[[1]]$num  %>% sort(),
               c(1, 1, 2, 2, 13, 115, 307)
               )
  expect_equal(P1_beats$space_fractions[[1]]$den  %>% sort(),
               c(1, 1, 1, 1, 3, 4, 6)
               )

  P8_beats = mami.codi(c(C4_midi, C5_beat_midi),
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)

  expect_equal(P8_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(P8_beats$frequency_spectrum[[1]]$amplitude %>% sort,
               c(1,1, 0.89, 0.89) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$beats_spectrum[[1]]$wavelength %>% sort,
               c(49.00),
               tolerance=0.1)
  expect_equal(P8_beats$beats_spectrum[[1]]$amplitude %>% sort,
               c(3.57) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength %>% sort,
               c(0.32, 0.64, 0.65, 1.31, 49.00),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$amplitude %>% sort,
               c(0.89, 0.89, 1.00, 1.00, 3.58) %>% sort(),
               tolerance=0.1)
})
test_that('original source spectrum is available',{
  P1 = mami.codi(60, verbose=T)
  expect_equal(P1$source_spectrum[[1]] %>% nrow(), 11)
})
test_that('we can quanity the amount of beating in chord', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  num_harmonics = 1

  P1_beats = mami.codi(C4_midi,
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P1_beats$beating, 0.0, tolerance=0.1)

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P1_beats$beating, log2(4*49.0+1), tolerance=0.1)
})
test_that('Stimulus Frequency Otoacoustic Emissions',{
  sfoae_num_harmonics=0
  P1 = mami.codi(60, verbose=T, sfoae_num_harmonics = sfoae_num_harmonics, num_harmonics=1)
  expect_equal(P1$sfoae_spectrum[[1]] %>% nrow(), sfoae_num_harmonics)
  expect_equal(P1$frequencies[[1]], c(261.6), tolerance=0.1)

  sfoae_num_harmonics=2
  P1_sfoae = mami.codi(60, verbose=T, sfoae_num_harmonics = sfoae_num_harmonics, num_harmonics=1)
  expect_equal(P1_sfoae$sfoae_spectrum[[1]] %>% nrow(), sfoae_num_harmonics)
  expect_equal(P1_sfoae$frequencies[[1]] %>% length(), sfoae_num_harmonics)
  expect_equal(P1_sfoae$frequencies[[1]], c(261.6, 523.2), tolerance=0.1)
})
test_that('Beats and Stimulus Frequency Otoacoustic Emissions',{
  num_harmonics = 1

  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz

  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) - f_beat)

  sfoae_num_harmonics = 0
  P8_beats = mami.codi(c(C4_midi, C5_beat_midi),
                       sfoae_num_harmonics = 0,
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P8_beats$sfoae_spectrum[[1]] %>% nrow(), sfoae_num_harmonics)
  expect_true(P8_beats$beating < 3.0)
  expect_equal(P8_beats$beats_spectrum[[1]]$wavelength %>% sort,
               c(1.34),
               tolerance=0.1)
  expect_equal(P8_beats$beats_spectrum[[1]]$amplitude %>% sort,
               c(4.00),
               tolerance=0.1)


  sfoae_num_harmonics = 2
  P8_beats_sfoae = mami.codi(c(C4_midi, C5_beat_midi),
                       sfoae_num_harmonics = sfoae_num_harmonics,
                       include_beats=T,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P8_beats_sfoae$sfoae_spectrum[[1]] %>% nrow(), sfoae_num_harmonics)
  expect_true(P8_beats_sfoae$beating > 3.0)
  expect_equal(P8_beats_sfoae$beats_spectrum[[1]]$wavelength %>% sort,
               c(1.34, 48.99),
               tolerance=0.1)
  expect_equal(P8_beats_sfoae$beats_spectrum[[1]]$amplitude %>% sort,
               c(4.00, 3.57) %>% sort(),
               tolerance=0.1)


})
test_that('params round trip', {
  P1 = mami.codi(60,
                 verbose=T,
                 sfoae_num_harmonics = 2,
                 include_beats=T)
  expect_equal(P1$sfoae_num_harmonics, 2)
  expect_equal(P1$include_beats, T)
})
test_that('pure tone beat makes sense with without SFOAE 2 harmonics',{

  # without SFOAE
  dyad = mami.codi(c(60,71),
                   num_harmonics=1,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 2.78, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength, 1.47, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, 4, tolerance = 0.01)

  dyad = mami.codi(c(60,73),
                   num_harmonics=1,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 0, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength, numeric(0), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, numeric(0),, tolerance = 0.01)

  # with SFOAE

  dyad = mami.codi(c(60,61),
                   num_harmonics=1,
                   sfoae_num_harmonics = 2,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 5.57, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength, c(22.04, 1.39), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, c(4,3.57), tolerance = 0.01)

  dyad = mami.codi(c(60,71),
                   num_harmonics=1,
                   sfoae_num_harmonics = 2,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 4.63, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength, c(1.47, 11.67), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, c(4,3.57), tolerance = 0.01)

  dyad = mami.codi(c(60,73),
                   num_harmonics=1,
                   sfoae_num_harmonics = 2,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 5.34, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength, c(11.02), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, c(3.57), tolerance = 0.01)

})
test_that('pure tone beat makes sense with without SFOAE 3 harmonics',{

  # with SFOAE

  dyad = mami.codi(c(60,61),
                   num_harmonics=1,
                   sfoae_num_harmonics = 3,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 4.85, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength %>% sort(),
               c(22.04,2.62,1.39,2.97) %>% sort(), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude, c(4,3.36, 3.57, 3.36), tolerance = 0.01)

  dyad = mami.codi(c(60,71),
                   num_harmonics=1,
                   sfoae_num_harmonics = 3,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 4.18, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength %>% sort,
               c(1.476808,  2.622068 , 11.679447,  3.381144) %>% sort(), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude %>% sort(), c(4.000000, 3.360641, 3.576830 ,3.360641) %>% sort(), tolerance = 0.01)

  dyad = mami.codi(c(60,67),
                   num_harmonics=1,
                   sfoae_num_harmonics = 3,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 9.36, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength %>% sort(), c( 2.630976,2.622068,2.613220,774.420598), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude %>% sort(), c(4.00,3.36,3.57,3.36) %>% sort(), tolerance = 0.01)

  dyad = mami.codi(c(60,73),
                   num_harmonics=1,
                   sfoae_num_harmonics = 3,
                   include_beats=T,
                   verbose=T)
  expect_equal(dyad$beating, 4.28, tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$wavelength %>% sort(), c(2.622068, 11.023930,  2.118240) %>% sort(), tolerance = 0.01)
  expect_equal(dyad$beats_spectrum[[1]]$amplitude %>% sort(), c(3.360641,3.576830,3.360641) %>% sort(), tolerance = 0.01)

})
