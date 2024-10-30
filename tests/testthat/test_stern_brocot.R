test_that("stern brocot does not return 0", {
  x <- 0.1666667
  uncertainty <- 0.200000

  result <- stern_brocot(x, uncertainty)
  expect_false(result[1] == 0, 'Stern Brocot should never return a 0 value')
})
