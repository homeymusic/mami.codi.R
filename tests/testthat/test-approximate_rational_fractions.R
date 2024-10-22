library(testthat)

test_that("approximate_rational_fractions C4 with 3 harmonics", {
  chord = hrep::sparse_fr_spectrum(60, num_harmonics = 3)
  fractions = approximate_rational_fractions(hrep::freq(chord), OCTAVE_DEVIATION, TRUE, 343.0)
  gcd_integers(fractions$num)
  lcm_integers(fractions$den)
})

test_that("approximate_rational_fractions P5 with 1 harmonics", {
  chord = hrep::sparse_fr_spectrum(c(60,67), num_harmonics = 1)
  fractions = approximate_rational_fractions(hrep::freq(chord), OCTAVE_DEVIATION, TRUE, 343.0)
  gcd_integers(fractions$num)
  lcm_integers(fractions$den)
})
