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


# helper for testing fundmanetals
check_fundamental <- function(ref_midi, dyad_ratio, expected_fund_ratio) {
  ref_freq = hrep::midi_to_freq(ref_midi)
  ref_tol = frequency_erb(ref_freq)
  sb_ref_ratio = stern_brocot(ref_freq - ref_tol, ref_freq, ref_freq + ref_tol)
  expect_equal(sb_ref_ratio[1] / sb_ref_ratio[2], ref_freq, tolerance = ref_tol)

  dyad_freq = dyad_ratio * ref_freq
  dyad_tol = frequency_erb(dyad_freq)
  sb_dyad_ratio = stern_brocot(dyad_freq - dyad_tol, dyad_freq, dyad_freq + dyad_tol)
  expect_equal(sb_dyad_ratio[1] / sb_dyad_ratio[2], dyad_freq, tolerance = dyad_tol)

  num = gcd_integers(c(sb_ref_ratio[1], sb_dyad_ratio[1]))
  den = lcm_integers(c(sb_ref_ratio[2], sb_dyad_ratio[2]))
  fund_freq = num / den
  expect_equal(fund_freq, expected_fund_ratio * ref_freq, tolerance = max(c(ref_tol, dyad_tol)))
}

# C-1
test_that("fund of C-1 and C0 is C-1", {
  check_fundamental(ref_midi = 0,
                    dyad_ratio = 2,
                    expected_fund_ratio = 1)
})

test_that("fund of C-1 and G-1 is C-2", {
  check_fundamental(ref_midi = 0,
                    dyad_ratio = 3/2,
                    expected_fund_ratio = 0.5)
})

test_that("fund of C-1 and G-1 is C-2", {
  check_fundamental(ref_midi = 0,
                    dyad_ratio = 3/2, expected_fund_ratio = 0.5)
})

# C0

test_that("fund of C0 and C1 is C0", {
  check_fundamental(ref_midi = 12,
                    dyad_ratio = 2, expected_fund_ratio = 1)
})

test_that("fund of C0 and G0 is C-1", {
  check_fundamental(ref_midi = 12,
                    dyad_ratio = 3/2, expected_fund_ratio = 0.5)
})

# C1

test_that("fund of C1 and C2 is C1", {
  check_fundamental(ref_midi = 24,
                    dyad_ratio = 2, expected_fund_ratio = 1)
})

test_that("fund of C1 and G1 is C0", {
  check_fundamental(ref_midi = 24,
                    dyad_ratio = 3/2, expected_fund_ratio = 0.5)
})

# C4

test_that("fund of C4 and C5 is C4", {
  check_fundamental(ref_midi = 60,
                    dyad_ratio = 2, expected_fund_ratio = 1)
})

test_that("the fundamental of C4 and G4 is C3", {
  check_fundamental(ref_midi = 60,
                    dyad_ratio = 3/2, expected_fund_ratio = 0.5)
})

test_that("the fundamental of C4 and ET G4 is C3", {
  check_fundamental(ref_midi = 60,
                    dyad_ratio = hrep::midi_to_freq(67) / hrep::midi_to_freq(60),
                    expected_fund_ratio = 0.5)
})

test_that("the fundamental of C4 and ET G4 is C3", {
  check_fundamental(ref_midi = 60,
                    dyad_ratio = hrep::midi_to_freq(67) / hrep::midi_to_freq(60),
                    expected_fund_ratio = 0.5)
})

# C9

test_that("fund of C9 and C10 is C9", {
  check_fundamental(ref_midi = 120,
                    dyad_ratio = 2, expected_fund_ratio = 1)
})

test_that("the fundamental of C9 and G9 is C8", {
  check_fundamental(ref_midi = 120,
                    dyad_ratio = 3/2, expected_fund_ratio = 0.5)
})
