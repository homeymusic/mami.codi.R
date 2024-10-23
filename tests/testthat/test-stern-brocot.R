library(testthat)

test_that("stern_brocot approximates irrational number to a ratio and specific num/den within a tolerance", {
  # Test with Pi, an irrational number
  pi_approx <- stern_brocot(pi-0.01, pi, pi+0.01)
  approx_pi <- pi_approx[1] / pi_approx[2]

  # Check if the approximation is within the tolerance
  expect_true(abs(pi - approx_pi) < 0.01,
              info = paste("Failed to approximate Pi within tolerance. Got", pi_approx[1], "/", pi_approx[2]))

  # Check if the function returns 22/7 for Pi when within the tolerance
  expect_equal(pi_approx[1], 22, info = "Numerator for Pi approximation is incorrect")
  expect_equal(pi_approx[2], 7, info = "Denominator for Pi approximation is incorrect")

  # Test with sqrt(2), another irrational number
  sqrt2_approx <- stern_brocot(sqrt(2) - 0.0001, sqrt(2), sqrt(2) + 0.0001)
  approx_sqrt2 <- sqrt2_approx[1] / sqrt2_approx[2]

  # Check if the approximation is within the tolerance
  expect_true(abs(sqrt(2) - approx_sqrt2) < 0.0001,
              info = paste("Failed to approximate sqrt(2) within tolerance. Got", sqrt2_approx[1], "/", sqrt2_approx[2]))

  # Known rational approximation for sqrt(2) is 99/70
  expect_equal(sqrt2_approx[1], 99, info = "Numerator for sqrt(2) approximation is incorrect")
  expect_equal(sqrt2_approx[2], 70, info = "Denominator for sqrt(2) approximation is incorrect")
})
