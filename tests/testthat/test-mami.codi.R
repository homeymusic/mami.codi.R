test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T,
                           cochlear_amplifier_num_harmonics = 0,
                           beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$time_cycle_length, 1)
  expect_equal(P1$space_cycle_length, 1)
  expect_equal(P1$time_dissonance, 0)
  expect_equal(P1$space_dissonance, 0)
})
test_that('P1 with 3 harmonics fundamental frequency and fundamental wavenumber have different cycles',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T,
                             cochlear_amplifier_num_harmonics = 0,
                             beat_pass_filter = BEAT_PASS_FILTER$NONE)
  C4_frequency = hrep::midi_to_freq(60)
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  expected_time_cycle_length = 1
  expect_equal(P1_3$time_cycle_length, expected_time_cycle_length)
  expect_equal(P1_3$fundamental_frequency, C4_frequency / expected_time_cycle_length)

  expected_space_cycle_length = 2
  expect_equal(P1_3$space_cycle_length, expected_space_cycle_length)
  expect_equal(P1_3$fundamental_wavenumber, C4_wavenumber / expected_space_cycle_length)

  expect_false(expected_time_cycle_length == expected_space_cycle_length)
})
test_that('Major-minor tonality of octave complements',{
  num_harmonics = 2

  ## Consonant Intervals

  # m3 & M6
  expected_magnitude = 2.0 # log2(4)
  dyad = c(60,63,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,69,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)

  # M3 & m6
  expected_magnitude = 1.0 # log2(2)
  dyad = c(60,64,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,68,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)

  ## Perfect Intervals

  # P4 & P5
  expected_magnitude = 0.5849625 # log2(1.5)
  dyad = c(60,65,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,67,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)

  # P1 & P8
  expected_magnitude = 0.0 # log2(1)
  dyad = c(60,60,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,72,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)

  ## Dissonant Intervals

  # M2 & m7 (traditional major-minor tonality is reversed)
  expected_magnitude = 2.3219281 # log2(5)
  dyad = c(60,62,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,70,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)

  # m2 & M7 (traditional major-minor tonality is reversed)
  expected_magnitude = 1.0 # log2(2)
  dyad = c(60,61,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)
  dyad = c(60,71,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)

  # tt with itself
  expected_magnitude = 0.0 # log2(1)
  dyad = c(60,66,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, -expected_magnitude)
  dyad = c(60,66,72) %>% mami.codi(num_harmonics=2,
                                   cochlear_amplifier_num_harmonics = 0,
                                   beat_pass_filter = BEAT_PASS_FILTER$NONE)
  expect_equal(dyad$majorness, expected_magnitude)

})
test_that('beat spectrum looks interesting near P1',{
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(60) + f_beat)

  num_harmonics = 2
  C4_beats = c(C4_midi, C4_beat_midi) %>%
    mami.codi(beat_pass_filter = BEAT_PASS_FILTER$LOW,
              cochlear_amplifier_num_harmonics = 0,
              num_harmonics=num_harmonics,
              verbose=T)

  expect_equal(C4_beats$frequency_spectrum[[1]]$frequency,
               c(hrep::midi_to_freq(C4_midi), hrep::midi_to_freq(C4_beat_midi),
                 2 * hrep::midi_to_freq(C4_midi),
                 2 * hrep::midi_to_freq(C4_beat_midi)))

  expect_equal(C4_beats$frequency_spectrum[[1]]$amplitude %>% sort(), c(0.89, 0.89,1,1),
               tolerance=0.1)

  expect_equal(C4_beats$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.24 , 1.28 , 1.31  ,1.35 ,24.50 ,49.00) %>% sort(),
               tolerance=0.1)

  expect_equal(C4_beats$all_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1.78,1.89, 1.89 ,1.89, 1.89, 2.00) %>% sort(),
               tolerance=0.1)

  expect_equal(C4_beats$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.31 , 1.35, 24.50, 49.00) %>% sort(),
               tolerance=0.1)

  expect_equal(C4_beats$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1.78, 1.89 ,1.89, 2.00) %>% sort(),
               tolerance=0.1)


  expect_equal(C4_beats$wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.6384351 , 0.6555170 , 1.2768703 , 1.3110340  ,1.3470760 ,24.5000035 ,49.0000099) %>% sort(),
               tolerance=0.1)

})
test_that('stimulus works beats near P1', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  num_harmonics = 1
  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C4_beat_midi), num_harmonics = num_harmonics)

  # no beats stimulus
  no_beats_stimulus = generate_stimulus(spectrum)
  expect_equal(no_beats_stimulus$stimulus_frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$stimulus_frequency_spectrum[[1]]$amplitude %>% sort(),
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$stimulus_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.31, 1.27),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$stimulus_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1,1),
               tolerance=0.1)
  expect_equal(no_beats_stimulus$source_spectrum[[1]],
               spectrum)
})

test_that('mamai.codi works with beats near the unison', {
  C4_midi = 60
  f_beat = 7 # Hz
  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  num_harmonics = 1

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
                       num_harmonics=num_harmonics,
                       verbose=T)

  expect_equal(P1_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 268.62),
               tolerance=0.1)
  expect_equal(P1_beats$frequency_spectrum[[1]]$amplitude %>% sort(),
               c(1,1),
               tolerance=0.1)
  expect_equal(P1_beats$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(49),
               tolerance=0.1)
  expect_equal(P1_beats$all_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2),
               tolerance=0.1)
  expect_equal(P1_beats$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(49),
               tolerance=0.1)
  expect_equal(P1_beats$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2),
               tolerance=0.1)
  expect_equal(P1_beats$wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.31, 1.27, 49),
               tolerance=0.1)
  expect_equal(P1_beats$wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1,1,2),
               tolerance=0.1)

  expect_equal(P1_beats$time_cycle_length, 1)
  expect_equal(P1_beats$space_cycle_length, 3)
})

test_that('mami.codi works with beats near the octave P8 with 2 harmonics', {
  C4_midi = 60
  C5_midi = 72
  f_beat  = 7 # Hz
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)
  num_harmonics = 2

  P8_beats = mami.codi(c(C4_midi, C5_beat_midi),
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
                       num_harmonics=num_harmonics,
                       verbose=T)

  expect_equal(P8_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(P8_beats$frequency_spectrum[[1]]$amplitude %>% sort(),
               c(1,0.89,1,0.89),
               tolerance=0.1)
  expect_equal(P8_beats$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.429 , 0.638 , 0.647 , 1.277 , 1.311, 49.000),
               tolerance=0.1)
  expect_equal(P8_beats$all_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1.78 ,1.89, 1.89 ,1.89 ,1.89, 2.00),
               tolerance=0.1)
   expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(49.000 , 1.311 , 0.656 , 0.647  ,0.323) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.311034, 49.000047),
               tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1.89, 1.89),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength %>% sort(),
               c( 0.3234317 , 0.6468633 , 0.6555170, 1.3110340, 49.0000467) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(0.8912509, 0.8912509 ,1.0000000,1.891, 2.891) %>% sort(),
               tolerance=0.1)

  expect_equal(P8_beats$time_cycle_length, 1)
  expect_equal(P8_beats$space_cycle_length, 2)

  P8 = mami.codi(c(C4_midi, C5_midi),
                 beat_pass_filter = BEAT_PASS_FILTER$LOW,
                 cochlear_amplifier_num_harmonics=0,
                 num_harmonics=num_harmonics,
                 verbose=T)
  expect_equal(P8$time_cycle_length, 1)
  expect_equal(P8$space_cycle_length, 1)

})

test_that('mami codi with beats around unison and octave', {
  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz
  num_harmonics = 2

  C4_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C4_midi) + f_beat)
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)

  P1 = mami.codi(c(C4_midi),
                 beat_pass_filter = BEAT_PASS_FILTER$LOW,
                 cochlear_amplifier_num_harmonics=0,
                 num_harmonics = num_harmonics,
                 verbose =T)

  expect_equal(P1$time_fractions[[1]]$num %>% sort(), c(1,2))
  expect_equal(P1$time_fractions[[1]]$den %>% sort(), c(1,1))

  expect_equal(P1$wavelength_spectrum[[1]]$wavelength %>% sort(), c(0.655517, 1.311034) %>% sort(), tolerance=0.1)
  expect_equal(P1$space_fractions[[1]]$num %>% sort(), c(1,2))
  expect_equal(P1$space_fractions[[1]]$den %>% sort(), c(1,1))

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
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
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
                       num_harmonics = num_harmonics,
                       verbose =T)

  expect_equal(P8_beats$frequency_spectrum[[1]]$frequency,
               c(261.62, 523.25, 530.25, 1060.50),
               tolerance=0.1)
  expect_equal(P8_beats$frequency_spectrum[[1]]$amplitude %>% sort(),
               c(1,1, 0.89, 0.89) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength,
               c(49.000 , 1.311, 0.656 , 0.647,  0.323),
               tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.31,49.00),
               tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(1.89, 1.89) %>% sort(),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.32, 0.64, 0.65, 1.31, 49.00),
               tolerance=0.1)
  expect_equal(P8_beats$wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(0.8912509, 0.8912509, 1.0000000, 1.89, 2.89) %>% sort(),
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
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P1_beats$beating, 0.0, tolerance=0.1)

  P1_beats = mami.codi(c(C4_midi, C4_beat_midi),
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       cochlear_amplifier_num_harmonics=0,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P1_beats$beating, log2(2*2*49.0+1), tolerance=0.1)
})
test_that('Stimulus Frequency Otoacoustic Emissions',{
  cochlear_amplifier_num_harmonics=0
  P1 = mami.codi(60, verbose=T, cochlear_amplifier_num_harmonics = cochlear_amplifier_num_harmonics, num_harmonics=1)
  expect_equal(P1$cochlear_amplifier_frequency_spectrum[[1]] %>% nrow(), cochlear_amplifier_num_harmonics)
  expect_equal(P1$frequencies[[1]], c(261.6), tolerance=0.1)

  cochlear_amplifier_num_harmonics=2
  P1_cochlear_amplifier = mami.codi(60, verbose=T, cochlear_amplifier_num_harmonics = cochlear_amplifier_num_harmonics, num_harmonics=1)
  expect_equal(P1_cochlear_amplifier$cochlear_amplifier_frequency_spectrum[[1]] %>% nrow(), cochlear_amplifier_num_harmonics)
  expect_equal(P1_cochlear_amplifier$frequencies[[1]] %>% length(), 1)
  expect_equal(P1_cochlear_amplifier$frequencies[[1]], 261.6, tolerance=0.1)
  expect_equal(P1_cochlear_amplifier$wavelengths[[1]] %>% length(), 2)
  expect_equal(P1_cochlear_amplifier$wavelengths[[1]], c(1.311034,  0.655517), tolerance=0.1)
})
test_that('Beats and Stimulus Frequency Cochlear Amplifier',{
  num_harmonics = 1

  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz

  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) - f_beat)

  cochlear_amplifier_num_harmonics = 0
  P8_beats = mami.codi(c(C4_midi, C5_beat_midi),
                       cochlear_amplifier_num_harmonics = cochlear_amplifier_num_harmonics,
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P8_beats$cochlear_amplifier_frequency_spectrum[[1]] %>% nrow(), cochlear_amplifier_num_harmonics)
  expect_equal(P8_beats$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.3585),
               tolerance=0.1)
  expect_equal(P8_beats$beating, 2.67, tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.34),
               tolerance=0.1)
  expect_equal(P8_beats$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2.00),
               tolerance=0.1)


  cochlear_amplifier_num_harmonics = 2
  P8_beats_cochlear_amplifier = mami.codi(c(C4_midi, C5_beat_midi),
                       cochlear_amplifier_num_harmonics = cochlear_amplifier_num_harmonics,
                       beat_pass_filter = BEAT_PASS_FILTER$LOW,
                       num_harmonics = num_harmonics,
                       verbose =T)
  expect_equal(P8_beats_cochlear_amplifier$cochlear_amplifier_frequency_spectrum[[1]] %>% nrow(),
               cochlear_amplifier_num_harmonics * (P8_beats_cochlear_amplifier$stimulus_frequency_spectrum[[1]] %>% nrow()))
  expect_equal(P8_beats_cochlear_amplifier$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.4449479 , 0.6644053,  0.6735380 , 1.3110340 , 1.3470761 ,48.9999691),
               tolerance=0.1)
  expect_equal(P8_beats_cochlear_amplifier$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.3585, 1.31, 48.9),
               tolerance=0.1)
  expect_equal(P8_beats_cochlear_amplifier$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2.035481, 2.035481, 4.000000) %>% sort(),
               tolerance=0.1)

  expect_equal(P8_beats_cochlear_amplifier$beating, 7.63, tolerance = 0.1)

})
test_that('params round trip', {
  P1 = mami.codi(60,
                 verbose=T,
                 cochlear_amplifier_num_harmonics = 2,
                 beat_pass_filter = BEAT_PASS_FILTER$LOW)
  expect_equal(P1$cochlear_amplifier_num_harmonics, 2)
  expect_equal(P1$beat_pass_filter, BEAT_PASS_FILTER$LOW)
})
test_that('pure tone beat makes sense with without cochlear amplification 2 harmonics',{

  # without cochlear amplification
  dyad = mami.codi(c(60,71),
                   num_harmonics=1,
                   cochlear_amplifier_num_harmonics=0,
                   beat_pass_filter = BEAT_PASS_FILTER$LOW,
                   verbose=T)
  expect_equal(dyad$beating, 2.788, tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$wavelength, 1.47, tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$amplitude, 2, tolerance = 0.01)

  dyad = mami.codi(c(60,73),
                   num_harmonics=1,
                   cochlear_amplifier_num_harmonics=0,
                   beat_pass_filter = BEAT_PASS_FILTER$LOW,
                   verbose=T)
  expect_equal(dyad$beating, 0, tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$wavelength, numeric(0), tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$amplitude, numeric(0),, tolerance = 0.01)

  # with cochlear amplification

  dyad = mami.codi(c(60,61),
                   num_harmonics=1,
                   cochlear_amplifier_num_harmonics = 2,
                   beat_pass_filter = BEAT_PASS_FILTER$LOW,
                   verbose=T)
  expect_equal(dyad$beating, 8.51, tolerance = 0.01)
  expect_equal(dyad$stimulus_wavelength_spectrum[[1]]$wavelength,
               c(1.31,1.23), tolerance = 0.01)
  expect_equal(dyad$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.171689,  1.237451 , 1.311034  ,1.393921, 11.023930 ,22.047860), tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.311034,  1.393921, 11.023930, 22.047860), tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(0.07096268 ,2.03548134 ,2.03548134 ,4.00000000) %>% sort(), tolerance = 0.01)

  dyad = mami.codi(c(60,71),
                   num_harmonics=1,
                   cochlear_amplifier_num_harmonics = 2,
                   beat_pass_filter = BEAT_PASS_FILTER$LOW,
                   verbose=T)
  expect_equal(dyad$beating, 6.29, tolerance = 0.01)
  expect_equal(dyad$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.4723600,  0.6944960 , 0.7384038 , 1.3110340 , 1.4768076, 11.6794468), tolerance = 0.1)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.48, 1.31, 11.67)  %>% sort(), tolerance = 0.1)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2.035481, 2.035481 ,4.000000) %>% sort(), tolerance = 0.01)

  dyad = mami.codi(c(60,73),
                   num_harmonics=1,
                   cochlear_amplifier_num_harmonics = 2,
                   beat_pass_filter = BEAT_PASS_FILTER$LOW,
                   verbose=T)
  expect_equal(dyad$stimulus_wavelength_spectrum[[1]]$wavelength,
               c(1.31, 0.61), tolerance = 0.01)
  expect_equal(dyad$cochlear_amplifier_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.3093628, 0.6187256, 0.6555170, 1.3110340), tolerance = 0.01)
  expect_equal(dyad$all_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(0.4049085 , 0.5858447 , 0.6187256 , 1.1716894 , 1.3110340 ,11.0239298), tolerance = 0.01)
  expect_equal(dyad$beating, 5.68, tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$wavelength %>% sort(),
               c(1.311034, 11.023930) %>% sort(), tolerance = 0.01)
  expect_equal(dyad$filtered_beats_wavelength_spectrum[[1]]$amplitude %>% sort(),
               c(2.035481, 2.035481) %>% sort(), tolerance = 0.01)

})
test_that('cochlear_amplifier_num_harmonics round trips', {
  P1 = mami.codi(60, verbose=T)
  expect_equal(P1$cochlear_amplifier_num_harmonics, default_cochlear_amplifier_num_harmonics())
})
test_that('beating for all beats has values', {
  MT = c(60) %>% mami.codi(
    beat_pass_filter = BEAT_PASS_FILTER$ALL,
    verbose=T
  )
  expect_equal(MT$beating, 8.65 , tolerance=0.1)
})
test_that('beating in framed dyads works', {
  dyad_mami_codi_no_beats = mami.codi(
    c(0.0, 0.5, 12.0, 12.5, 24.0),
    verbose=T,
    beat_pass_filter = BEAT_PASS_FILTER$NONE,
    num_harmonics=1
  )
  expect_equal(dyad_mami_codi_no_beats$beating, 0, tolerance=0.1)


  dyad_mami_codi = mami.codi(
    c(0.0, 0.5, 12.0, 12.5, 24.0),
    verbose=T,
    num_harmonics=1
  )
  expect_equal(dyad_mami_codi$beating, 10.41, tolerance=0.1)
})
test_that('freqs are less than max', {
  num_harmonics = 10

  too_high_freq = MAX_FREQUENCY + 1
  result = mami.codi(c(60, hrep::freq_to_midi(too_high_freq)),
                     verbose=T,
                     cochlear_amplifier_num_harmonics = 0,
                     num_harmonics=num_harmonics)
  expect_equal(result$frequencies[[1]] %>% length(), num_harmonics)
  expect_true(all(result$frequencies[[1]] <= MAX_FREQUENCY))
})
test_that('freqs are greater than min', {
  num_harmonics = 10

  too_low_freq = MIN_FREQUENCY -0.1
  result = mami.codi(c(60, hrep::freq_to_midi(too_low_freq)),
                     verbose=T,
                     cochlear_amplifier_num_harmonics = 0,
                     num_harmonics=num_harmonics)
  expect_true(all(result$frequencies[[1]] >= MIN_FREQUENCY))
  expect_equal(result$frequencies[[1]] %>% length(), 19)
})
test_that('wavelengths are less than max', {
  num_harmonics = 10

  too_long_wavelength_freq = C_SOUND / (MAX_WAVELENGTH + 1)
  result = mami.codi(c(60, hrep::freq_to_midi(too_long_wavelength_freq)),
                     verbose=T,
                     cochlear_amplifier_num_harmonics = 0,
                     num_harmonics=num_harmonics)
  expect_equal(result$wavelengths[[1]] %>% length(), 21)
  expect_true(all(result$wavelengths[[1]] <= MAX_WAVELENGTH))
})
test_that('wavelengths are greater than min', {
  num_harmonics = 10

  too_small_wavelength_freq = C_SOUND / (MIN_WAVELENGTH - 0.0001)
  result = mami.codi(c(60, hrep::freq_to_midi(too_small_wavelength_freq)),
                     verbose=T,
                     cochlear_amplifier_num_harmonics = 0,
                     num_harmonics=num_harmonics)
  expect_true(all(result$wavelengths[[1]] >= MIN_WAVELENGTH))
  expect_equal(result$wavelengths[[1]] %>% length(), 10)
})
