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


test_that("approximate_rational_fractions calculates upper and lower bounds correctly", {

  sd <- 0.01
  approximate_lcm_sd <- 0.05
  x <- c(440, 880, 1320)
  reference <- min(x)

  result <- approximate_rational_fractions(x, reference, sd, approximate_lcm_sd)

  # Expected calculations for bounds should be close
  expect_true(all(result$lower_bound < result$upper_bound))

  # Check the relationship between the x and calculated bounds
  expect_true(all(result$lower_bound <= x / reference))
  expect_true(all(result$upper_bound >= x / reference))

  # Additional checks for specific values, for example:
  expect_equal(result$lower_bound[1], (440-sd)/(440+sd), tolerance = 1e-6)
  expect_equal(result$upper_bound[1], (440+sd)/(440-sd), tolerance = 1e-6)

  # Test Case 2: x values at boundary conditions (like close to reference)
  x <- c(430, 450)

  result <- approximate_rational_fractions(x, reference, sd, approximate_lcm_sd)

  expect_true(all(result$lower_bound < result$upper_bound))
  expect_true(all(result$lower_bound <= x / reference))
  expect_true(all(result$upper_bound >= x / reference))

  # Add more cases as necessary for validation
})

