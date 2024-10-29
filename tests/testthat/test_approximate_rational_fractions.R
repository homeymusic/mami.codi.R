# Test for approximate_rational_fractions
test_that("approximate_rational_fractions works as expected", {

  # Create the vector x
  x <- c(1, 0.5, 0.333333333499956, 0.25, 0.200000001601729, 0.166666666749978,
         0.142857143390959, 0.125, 0.111111111222193, 0.100000000800864)

  standard_deviation <- 0.200000

  # Call the function
  result <- approximate_rational_fractions(x, standard_deviation, HARMONICS_DEVIATION)

  # Check that the result contains both num and den
  expect_true(!is.null(result$num), info = "Numerators should not be null")
  expect_true(!is.null(result$den), info = "Denominators should not be null")

  # Check that the lengths of num and den match the input vector length
  expect_equal(length(result$num), length(x), info = "Length of numerators should match length of x")
  expect_equal(length(result$den), length(x), info = "Length of denominators should match length of x")

  # Check that no numerators or denominators are infinite
  expect_false(any(is.infinite(result$num)), info = "Numerators should not contain Inf or -Inf")
  expect_false(any(is.infinite(result$den)), info = "Denominators should not contain Inf or -Inf")

  # Check that all numerators and denominators are integers
  expect_true(all(result$num == as.integer(result$num)), info = "Numerators should be integers")
  expect_true(all(result$den == as.integer(result$den)), info = "Denominators should be integers")

  # Check that no numerators or denominators are zero
  expect_true(all(result$num != 0), info = "Numerators should not be 0")
  expect_true(all(result$den != 0), info = "Denominators should not be 0")

  # Check that no numerators or denominators are infinite
  expect_false(any(is.infinite(log2(result$num))), info = "Numerators should not contain Inf or -Inf")
  expect_false(any(is.infinite(log2(result$den))), info = "Denominators should not contain Inf or -Inf")

})
test_that('calculated beat matches actual beat',{
  C4_freq = hrep::midi_to_freq(60)
  beat_freq = 7
  freqs = c(C4_freq, C4_freq+beat_freq)
  wavelengths = C_SOUND / freqs

  beats_spectrum = calculate_beats(wavelength = wavelengths, amplitude=c(1,0.95))

  expect_equal(beats_spectrum$wavelength,
               c(49),
               tolerance = 0.1)
  expect_equal(beats_spectrum$amplitude,
               c(3.8025),
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

  beats_spectrum = calculate_beats(wavelength = wavelengths, amplitude=amplitudes)

  expect_equal(beats_spectrum$wavelength,
               c(49.00, 5.04, 5.62),
               tolerance = 0.1)
  expect_equal(beats_spectrum$amplitude,
               c(4,4,4),
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
  beating = mami.codi(c(60,71), num_harmonics=1, verbose=T, include_beats=T)$beating
  expect_equal(beating, 1.30, tolerance = 0.01)
  beats_spectrum = calculate_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               c(1.47),
               tolerance = 0.1)

  C5_freq = hrep::midi_to_freq(72)
  freqs = c(C4_freq, C5_freq)
  wavelengths = C_SOUND / freqs
  l = (wavelengths[1] * wavelengths[2]) / abs(wavelengths[1] - wavelengths[2])
  expect_true(l <= max(wavelengths))
  amplitudes  = rep(1, length(wavelengths))
  beating = mami.codi(c(60,72), num_harmonics=1, verbose=T, include_beats=T)$beating
  expect_equal(beating, 0, tolerance = 0.01)
  beats_spectrum = calculate_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               numeric(0),
               tolerance = 0.1)

  Db5_freq = hrep::midi_to_freq(73)
  freqs = c(C4_freq, Db5_freq)
  wavelengths = C_SOUND / freqs
  l = (wavelengths[1] * wavelengths[2]) / abs(wavelengths[1] - wavelengths[2])
  # above the ocatve the beats are not audible?
  expect_true(l < max(wavelengths))
  amplitudes  = rep(1, length(wavelengths))
  beating = mami.codi(c(60,73), num_harmonics=1, verbose=T, include_beats=T)$beating
  expect_equal(beating, 0, tolerance = 0.01)
  beats_spectrum = calculate_beats(wavelength = wavelengths, amplitude=amplitudes)
  expect_equal(beats_spectrum$wavelength,
               numeric(0))
})
