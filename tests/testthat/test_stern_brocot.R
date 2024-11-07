test_that("stern brocot does not return 0", {
  x <- 0.1666667
  uncertainty <- 0.2

  result <- stern_brocot(x, uncertainty)
  expect_equal(result, c(1,5))
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')
})

test_that("stern brocot does not return 0", {
  uncertainty <- 1/(4*pi)
  x <- uncertainty  - 0.0001

  result <- stern_brocot(x, uncertainty)
  expect_equal(result, c(1,12))
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')
})

test_that("stern brocot does not return 0", {
  uncertainty <- 1/(4*pi)
  x <- uncertainty  + 0.0001

  result <- stern_brocot(x, uncertainty)
  expect_equal(result, c(1,7))
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')
})

test_that("stern brocot does not return 0", {
  uncertainty <- 1/(4*pi)

  l = 726306141.917749
  min_l = 2.1310282514245
  x <- l / min_l

  expect_error(stern_brocot(x, uncertainty), 'STOP: this should not happen')
})

