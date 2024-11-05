test_that('combintion tones show up', {
  P1 = mami.codi(60, verbose=T, combination_coefficients = c(-4,4))
  expect_equal(P1$combination_tones_frequency_spectrum[[1]] %>% nrow(), 64)
})
