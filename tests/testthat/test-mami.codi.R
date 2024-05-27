test_that('pure tone is 100% consonant',{
  P1 = c(60) %>% mami.codi(num_harmonics=1)
  expect_equal(P1$consonance_dissonance, 100)
})
test_that('harmonic lcm works', {
  P1_Harmonic = mami.codi(c(60), verbose=T, num_harmonics=3, octave_ratio=2.0)
  expect_equal(P1_Harmonic$spatial_fractions[[1]]$den, c(1,2,1))
  expect_equal(P1_Harmonic$spatial_alcd, 2)
  expect_equal(P1_Harmonic$temporal_fractions[[1]]$den, c(1,1,1))
  expect_equal(P1_Harmonic$temporal_alcd, 1)
})
test_that('stretched lcm works', {
  P1_Stretched = mami.codi(c(60), verbose=T, num_harmonics=3, octave_ratio=2.1)
  expect_equal(P1_Stretched$spatial_fractions[[1]]$den, c(4,2,1))
  expect_equal(P1_Stretched$spatial_alcd, 4)
  expect_equal(P1_Stretched$temporal_fractions[[1]]$den, c(1,7,4))
  expect_equal(P1_Stretched$temporal_alcd, 28 )
})
