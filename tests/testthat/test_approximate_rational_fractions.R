library(testthat)


# Test for approximate_rational_fractions
test_that("approximate_rational_fractions works as expected", {

  # Create the vector x
  x <- c(1, 0.5, 0.333333333499956, 0.25, 0.200000001601729, 0.166666666749978,
         0.142857143390959, 0.125, 0.111111111222193, 0.100000000800864)

  standard_deviation <- 0.200000

  # Call the function
  result <- approximate_rational_fractions(x, standard_deviation, HARMONICS_DEVIATION)

  # Check that the result contains both num and den
  expect_true(!is.null(result$num), info = "Numerators should not be null")
  expect_true(!is.null(result$den), info = "Denominators should not be null")

  # Check that the lengths of num and den match the input vector length
  expect_equal(length(result$num), length(x), info = "Length of numerators should match length of x")
  expect_equal(length(result$den), length(x), info = "Length of denominators should match length of x")

  # Check that no numerators or denominators are infinite
  expect_false(any(is.infinite(result$num)), info = "Numerators should not contain Inf or -Inf")
  expect_false(any(is.infinite(result$den)), info = "Denominators should not contain Inf or -Inf")

  # Check that all numerators and denominators are integers
  expect_true(all(result$num == as.integer(result$num)), info = "Numerators should be integers")
  expect_true(all(result$den == as.integer(result$den)), info = "Denominators should be integers")

  # Check that no numerators or denominators are zero
  expect_true(all(result$num != 0), info = "Numerators should not be 0")
  expect_true(all(result$den != 0), info = "Denominators should not be 0")

  # Check that no numerators or denominators are infinite
  expect_false(any(is.infinite(log2(result$num))), info = "Numerators should not contain Inf or -Inf")
  expect_false(any(is.infinite(log2(result$den))), info = "Denominators should not contain Inf or -Inf")

})
