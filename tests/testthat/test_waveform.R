test_that("we can create a new wavelength spectrum with multiple wavelengths and amplitudes", {

  # Create a tibble with wavelengths and corresponding amplitudes
  wavelengths <- tibble::tibble(
    wavelength = c(1, 0.5, 0.33),
    amplitude = c(1.0, 0.8, 0.5)
  )

  # Create a wavelength_spectrum object
  wavelength_spectrum_obj <- wavyr::wavelength_spectrum(wavelengths)

  # Expectations to check wavelength_spectrum creation
  expect_s3_class(wavelength_spectrum_obj, "wavelength_spectrum")
  expect_equal(nrow(wavelength_spectrum_obj$wavelengths), 3)
  expect_equal(wavelength_spectrum_obj$wavelengths$wavelength, c(1, 0.5, 0.33))
  expect_equal(wavelength_spectrum_obj$wavelengths$amplitude, c(1.0, 0.8, 0.5))
})
