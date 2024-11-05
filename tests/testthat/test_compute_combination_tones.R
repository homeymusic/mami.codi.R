# from Otoacoustic emissions, their origin in cochlear function, and use
# David T Kemp
# UCL Centre for Auditory Research
# Institute of Laryngology and Otology, London, UK

test_that('not enough freqs',{
  combination_coefficients = -3:3
  f = c(1425)
  a = c(1)

  ct = compute_combination_tones(f, a, combination_coefficients)
  expect_equal(ct$frequency, numeric())
})

test_that('not enough combos',{
  combination_coefficients = numeric(0)
  f = c(1425,1500)
  a = c(1,1)

  ct = compute_combination_tones(f, a, combination_coefficients)
  expect_equal(ct$frequency, numeric())
})

test_that('1 combo works',{
  combination_coefficients = c(1)
  f = c(1425,1500)
  a = c(1,1)

  ct = compute_combination_tones(f, a, combination_coefficients)
  expect_equal(ct$frequency, 2 * 1425 - 1500)
})

test_that('all combos works',{
  combination_coefficients = -4:4
  f = c(1425,1500)
  a = c(1,1)

  ct = compute_combination_tones(f, a, combination_coefficients)
  expect_equal(ct$frequency %>% sort(),
               c(1125, 1200, 1275, 1350 ,1425, 1500 ,1575 ,1650, 1725) %>% sort())
})

test_that('negative frequencies are not returned',{
  combination_coefficients = -4:4
  P1 = hrep::sparse_fr_spectrum(60, num_harmonics = 10)

  ct = compute_combination_tones(P1$x, P1$y, combination_coefficients)
  expect_true(all(ct>0))
})
