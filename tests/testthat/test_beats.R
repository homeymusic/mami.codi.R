expected_number_of_beats <- function(num_harmonics) {
  (num_harmonics * (num_harmonics - 1)) /  2
}

test_that('expected_number_of_beats works', {
  expect_equal(expected_number_of_beats(10), 45)
})

test_that('For a single pitch, the number of frequencies and wavelengths make sense', {
  num_harmonics=10
  cochlear_amplifier_num_harmonics=0

  P1 = mami.codi(
    60,
    num_harmonics=num_harmonics,
    cochlear_amplifier_num_harmonics=cochlear_amplifier_num_harmonics,
    verbose=T
  )
  expect_equal(P1$frequency_spectrum[[1]]$frequency %>% length(), num_harmonics)
  expect_equal(P1$all_beats_wavelength_spectrum[[1]]$wavelength %>% length(),
               expected_number_of_beats(num_harmonics))
  expect_equal(P1$wavelength_spectrum[[1]]$wavelength %>% length(), num_harmonics)
})
test_that('For two pitches, the number of beat wavelengths should be num_harmonics - 1', {
  num_harmonics=10
  cochlear_amplifier_num_harmonics=0

  m2 = mami.codi(
    c(60,61),
    num_harmonics=num_harmonics,
    cochlear_amplifier_num_harmonics=cochlear_amplifier_num_harmonics,
    verbose=T
  )

  expect_equal(m2$frequency_spectrum[[1]]$frequency %>% length(), 2 * num_harmonics)
  expect_equal(m2$all_beats_wavelength_spectrum[[1]]$wavelength %>% length(),
               expected_number_of_beats(2 * num_harmonics))
})
