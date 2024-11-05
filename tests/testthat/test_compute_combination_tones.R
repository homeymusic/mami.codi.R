# from Otoacoustic emissions, their origin in cochlear function, and use
# David T Kemp
# UCL Centre for Auditory Research
# Institute of Laryngology and Otology, London, UK

test_that('not enough freqs',{
  combination_coefficients = -3:3
  f = c(1425)

  ct = compute_combination_tones(f, combination_coefficients)
  expect_equal(ct, numeric())
})

test_that('not enough combos',{
  combination_coefficients = numeric(0)
  f = c(1425,1500)

  ct = compute_combination_tones(f, combination_coefficients)
  expect_equal(ct, numeric())
})

test_that('not enough combos usinc c()',{
  combination_coefficients = c()
  f = c(1425,1500)

  ct = compute_combination_tones(f, combination_coefficients)
  expect_equal(ct, numeric())
})

test_that('1 combo works',{
  combination_coefficients = c(1)
  f = c(1425,1500)

  ct = compute_combination_tones(f, combination_coefficients)
  expect_equal(ct, 2 * 1425 - 1500)
})

test_that('all combos works',{
  combination_coefficients = -4:4
  f = c(1425,1500)

  ct = compute_combination_tones(f, combination_coefficients)
  expect_equal(ct, c(1125, 1200, 1275, 1350 ,1425, 1500 ,1575 ,1650))
})
