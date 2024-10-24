test_that("stern brocot does not return 0", {
  x <- 0.1666667
  standard_deviation <- 0.200000

  result <- stern_brocot(x, standard_deviation)
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')

  x <- 1 / x
  result <- stern_brocot(x, standard_deviation)
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')
})
