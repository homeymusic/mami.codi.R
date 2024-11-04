test_that('combine wavelength spectra works', {
  C4_hrep = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  C4 = tibble::tibble(
    wavelength = C_SOUND / C4_hrep$x,
    amplitude  = C4_hrep$y
  )
  expect_equal(C4$wavelength, c(1.3110340, 0.6555170, 0.4370113), tolerance = 0.1)
  expect_equal(C4$amplitude, c(1.0000000, 0.8912509, 0.8332050), tolerance = 0.1)
  C5_hrep = hrep::sparse_fr_spectrum(72, num_harmonics = 3)
  C5 = tibble::tibble(
    wavelength = C_SOUND / C5_hrep$x,
    amplitude  = C5_hrep$y
  )
  expect_equal(C5$wavelength, c(0.6555170, 0.3277585, 0.2185057), tolerance = 0.1)
  expect_equal(C5$amplitude, c(1.0000000, 0.8912509, 0.8332050), tolerance = 0.1)

  P8 = combine_wavelength_spectra(C4, C5)
  expect_equal(P8$wavelength,c(1.3110340 ,0.6555170, 0.4370113 ,0.3277585, 0.2185057), tolerance=0.1)
  expect_equal(P8$amplitude,c(1.0000000, 1.89 ,0.8332050, 0.8912509, 0.8332050), tolerance=0.1)
})

test_that('combine_frequency_spectra', {
  C4_hrep = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  C4 = tibble::tibble(
    frequency = C4_hrep$x,
    amplitude = C4_hrep$y
  )
  expect_equal(C4$frequency, c(261.6256, 523.2511, 784.8767), tolerance = 0.1)
  C5_hrep = hrep::sparse_fr_spectrum(72, num_harmonics = 3)
  C5 = tibble::tibble(
    frequency = C5_hrep$x,
    amplitude = C5_hrep$y
  )
  expect_equal(C5$frequency, c(523.2511, 1046.5023, 1569.7534), tolerance = 0.1)

  P8 = combine_frequency_spectra(C4, C5)
  # the C5 from the C4 harmonic should be combined and have higher amp
  expect_equal(nrow(P8),5)
  P8_combined = P8 %>% dplyr::filter(abs(frequency-523.2511) < 0.1)
  expect_true(P8_combined$amplitude > 1)
})
test_that('sparse_fr_spectrum_from_wavelength_spectrum', {
  C4_hrep = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  C4 = tibble::tibble(
    wavelength = C_SOUND / C4_hrep$x,
    amplitude  = C4_hrep$y
  )
  expect_equal(C4$wavelength, c(1.3110340, 0.6555170, 0.4370113), tolerance = 0.1)
  C4_roundtrip = sparse_fr_spectrum_from_wavelength_spectrum(C4)
  expect_equal(C4_roundtrip, C4_hrep)
})

test_that('wavelength_spectrum_from_sparse_fr_spectrum', {
  C4_hrep = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  C4_roundtrip = wavelength_spectrum_from_sparse_fr_spectrum(C4_hrep)
  C4 = tibble::tibble(
    wavelength = C_SOUND / C4_hrep$x,
    amplitude  = C4_hrep$y
  )
  expect_equal(C4_roundtrip, C4, tolerance=0.1)
})
test_that('frequency_spectrum_from_sparse_fr_spectrum', {
  C4_hrep = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  C4 = tibble::tibble(
    frequency = C4_hrep$x,
    amplitude = C4_hrep$y
  )
  C4_roundtrip = frequency_spectrum_from_sparse_fr_spectrum(C4_hrep)
  expect_equal(C4, C4_roundtrip)
})
