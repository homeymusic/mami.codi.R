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

  P8 = combine_spectra(C4, C5)
  expect_equal(P8$wavelength,c(1.3110340 ,0.6555170, 0.4370113 ,0.3277585, 0.2185057), tolerance=0.1)
  expect_equal(P8$amplitude,c(1.0000000, 1.89 ,0.8332050, 0.8912509, 0.8332050), tolerance=0.1)
})

test_that('combine_spectra', {
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

  P8 = combine_spectra(C4, C5)
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

test_that("combine_spectra combines multiple frequency spectra correctly", {
  # Create sample frequency spectra data
  x_freq <- tibble::tibble(
    frequency = c(1000.0001, 500.0001, 333.3333),
    amplitude = c(1.0, 0.9, 0.8)
  )

  y_freq <- tibble::tibble(
    frequency = c(1000.0001, 250.0001),
    amplitude = c(1.0, 0.7)
  )

  z_freq <- tibble::tibble(
    frequency = c(500.0001, 333.3333),
    amplitude = c(0.5, 0.4)
  )

  # Combine with tolerance
  combined <- combine_spectra(x_freq, y_freq, z_freq, tolerance = 1e-5)

  # Check that combined frequencies are sorted in ascending order
  expect_equal(combined$frequency, sort(combined$frequency))

  # Validate amplitudes have been summed within tolerance
  expect_equal(
    combined %>% dplyr::filter(frequency == 1000.0001) %>% dplyr::pull(amplitude),
    1.0 + 1.0
  )
  expect_equal(
    combined %>% dplyr::filter(frequency == 500.0001) %>% dplyr::pull(amplitude),
    0.9 + 0.5
  )
})

test_that("combine_spectra combines multiple wavelength spectra in descending order", {
  # Create sample wavelength spectra data
  x_wavelength <- tibble::tibble(
    wavelength = c(1.000000, 0.500000, 0.333333),
    amplitude = c(1.0, 0.9, 0.8)
  )

  y_wavelength <- tibble::tibble(
    wavelength = c(0.333333, 0.250000),
    amplitude = c(0.7, 0.6)
  )

  # Combine with tolerance
  combined <- combine_spectra(x_wavelength, y_wavelength, tolerance = 1e-5)

  # Check that combined wavelengths are sorted in descending order
  expect_equal(combined$wavelength, sort(combined$wavelength, decreasing = TRUE))

  # Validate amplitudes have been summed within tolerance
  expect_equal(
    combined %>% dplyr::filter(wavelength == 0.333333) %>% dplyr::pull(amplitude),
    0.8 + 0.7
  )
})

test_that("combine_spectra handles a single spectrum without modification", {
  # Create a single frequency spectrum
  x_freq <- tibble::tibble(
    frequency = c(1000.0001, 500.0001, 333.3333) %>% sort(),
    amplitude = c(1.0, 0.9, 0.8)
  )

  # Combine single spectrum
  combined <- combine_spectra(x_freq)

  # Check that result is the same as input
  expect_equal(combined$frequency, x_freq$frequency)
  expect_equal(combined$amplitude, x_freq$amplitude)
})

test_that("combine_spectra throws an error for mismatched types", {
  # Create a frequency spectrum and a wavelength spectrum
  x_freq <- tibble::tibble(
    frequency = c(1000.0001, 500.0001),
    amplitude = c(1.0, 0.9)
  )

  y_wavelength <- tibble::tibble(
    wavelength = c(1.000000, 0.500000),
    amplitude = c(1.0, 0.9)
  )

  # Expect an error due to mismatched types
  expect_error(combine_spectra(x_freq, y_wavelength), "All spectra must have the same type")
})

test_that("combine_spectra respects tolerance for frequency spectra", {
  # Create frequency spectra with close values
  x_freq <- tibble::tibble(
    frequency = c(1000.000001, 1000.000002, 500.0001),
    amplitude = c(1.0, 1.0, 0.9)
  )

  # Combine with a tolerance that will group close frequencies
  combined <- combine_spectra(x_freq, tolerance = 1e-5)

  # Check that close frequencies are combined
  expect_equal(nrow(combined), 2) # Should group the first two rows
  expect_equal(
    combined %>% dplyr::filter(frequency == mean(c(1000.000001, 1000.000002))) %>% dplyr::pull(amplitude),
    2.0
  )
})
