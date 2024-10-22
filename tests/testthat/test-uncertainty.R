library(testthat)

test_that("freq uncertainty makes sense", {
  u = frequency_uncertainty(hrep::midi_to_freq(0))
  expect_equal(u, 25.6, tolerance = 0.1)
  u = frequency_uncertainty(hrep::midi_to_freq(60))
  expect_equal(u, 52.9, tolerance = 0.1)
  u = frequency_uncertainty(hrep::midi_to_freq(120))
  expect_equal(u, 928.9, tolerance = 0.1)
})

test_that("wavelength uncertainty makes sense", {
  u = wavelength_uncertainty(343/hrep::midi_to_freq(0))
  expect_equal(u, 13.4, tolerance = 0.1)
  u = wavelength_uncertainty(343/hrep::midi_to_freq(60))
  expect_equal(u, 6.5, tolerance = 0.1)
  u = wavelength_uncertainty(343/hrep::midi_to_freq(120))
  expect_equal(u, 0.4, tolerance = 0.1)
})
