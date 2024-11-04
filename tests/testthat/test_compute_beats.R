test_that('M7 beats make sense', {
  M7 = hrep::sparse_fr_spectrum(c(60,71), num_harmonics = 1)
  M7_l = C_SOUND / (M7 %>% hrep::freq())
  M7_beats = compute_beats(wavelength = M7_l, amplitude = M7 %>% hrep::amp())
  expect_equal(M7_beats$wavelength,1.47, tol=0.01)
  expect_equal(M7_beats$amplitude,2, tol=0.01)
})

test_that('beats make sense at octave P8 with 2 harmonics', {
  C4_midi = 60
  C5_midi = 72
  f_beat = 7 # Hz
  C5_beat_midi = hrep::freq_to_midi(hrep::midi_to_freq(C5_midi) + f_beat)
  num_harmonics = 2
  spectrum = hrep::sparse_fr_spectrum(c(C4_midi, C5_beat_midi), num_harmonics = num_harmonics)

  beats = compute_beats(wavelength = C_SOUND/spectrum$x, amplitude = spectrum$y)
  expect_equal(beats$wavelength,c(1.311034, 1.2768703,  0.4293529 , 49.0000466 , 0.6384352,  0.6468633), tol=0.01)
  expect_equal(beats$amplitude,c(1.891251, 2.000000,1.891251, 1.891251, 1.782502, 1.891251), tol=0.01)

})

test_that('calculated beat matches actual beat',{
  C4_freq = hrep::midi_to_freq(60)
  beat_freq = 7
  freqs = c(C4_freq, C4_freq+beat_freq)
  wavelengths = C_SOUND / freqs

  beats_spectrum = compute_beats(wavelength = wavelengths, amplitude=c(1,0.95))

  expect_equal(beats_spectrum$wavelength,
               c(49),
               tolerance = 0.1)
  expect_equal(beats_spectrum$amplitude,
               c(1.95),
               tolerance = 0.1)
  calculated_beat_freq = C_SOUND / beats_spectrum$wavelength
  expect_equal(beat_freq, calculated_beat_freq, tolerance = 0.1)
})
test_that('only low beats are returned',{
  C4_freq = hrep::midi_to_freq(60)
  E4_freq = hrep::midi_to_freq(64)
  beat_freq = 7
  freqs = c(C4_freq, C4_freq+beat_freq, E4_freq)
  wavelengths = C_SOUND / freqs
  amplitudes  = rep(1, length(wavelengths))

  beats_spectrum = compute_beats(wavelength = wavelengths, amplitude=amplitudes)

  expect_equal(beats_spectrum$wavelength,
               c(49.00, 5.04, 5.62),
               tolerance = 0.1)
  expect_equal(beats_spectrum$amplitude,
               c(2,2,2),
               tolerance = 0.1)
  calculated_beat_freqs = C_SOUND / beats_spectrum$wavelength
  expect_true(any(abs(calculated_beat_freqs - beat_freq) < 0.1))
})
test_that('beats near the octave',{

  C4_freq = hrep::midi_to_freq(60)
  Cb5_freq = hrep::midi_to_freq(71)

  freqs = c(C4_freq, Cb5_freq)
  wavelengths = C_SOUND / freqs
  l = (wavelengths[1] * wavelengths[2]) / abs(wavelengths[1] - wavelengths[2])
  expect_true(l > max(wavelengths))
  amplitudes  = rep(1, length(wavelengths))
  beats_spectrum = compute_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               c(1.47),
               tolerance = 0.1)

  C5_freq = hrep::midi_to_freq(72)
  freqs = c(C4_freq, C5_freq)
  wavelengths = C_SOUND / freqs
  l = (wavelengths[1] * wavelengths[2]) / abs(wavelengths[1] - wavelengths[2])
  expect_true(l <= max(wavelengths))
  amplitudes  = rep(1, length(wavelengths))
  beats_spectrum = compute_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               1.311034,
               tolerance = 0.1)

  Db5_freq = hrep::midi_to_freq(73)
  freqs = c(C4_freq, Db5_freq)
  wavelengths = C_SOUND / freqs
  l = (wavelengths[1] * wavelengths[2]) / abs(wavelengths[1] - wavelengths[2])
  # above the ocatve the beats are not audible?
  expect_true(l < max(wavelengths))
  amplitudes  = rep(1, length(wavelengths))
  beats_spectrum = compute_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               1.171689,
               tolerance=0.01)
})
