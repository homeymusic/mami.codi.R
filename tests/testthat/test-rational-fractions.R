test_that('3 harmonics frequency looks good',{
  f = c(1,2,3)
  fractions = approximate_rational_fractions(f, min(f), sd = 1 / (4 * pi), approximate_lcm_sd = 0.11)
  expect_equal(fractions$num, c(1,2,3))
  expect_equal(fractions$den, c(1,1,1))
})
test_that('3 harmonics wavelength looks good',{
  l = 343 / c(1,2,3)
  fractions = approximate_rational_fractions(l, min(l), sd = 1 / (4 * pi), approximate_lcm_sd = 0.11)
  expect_equal(fractions$num, c(3,3,1))
  expect_equal(fractions$den, c(1,2,1))
})
