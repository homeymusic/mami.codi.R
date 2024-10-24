test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$temporal_cycles, 1)
  expect_equal(P1$spatial_cycles, 1)
  expect_equal(P1$temporal_dissonance, 0)
  expect_equal(P1$spatial_dissonance, 0)
})
test_that('fundamental frequency calc',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T)
  C4_frequency = hrep::midi_to_freq(60)

  expected_fundamental_cycles = 1
  expect_equal(P1_3$temporal_cycles, expected_fundamental_cycles)
  expect_equal(P1_3$fundamental_frequency, C4_frequency / expected_fundamental_cycles)
})
test_that('fundamental wavenumber calc',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T)
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  expected_fundamental_cycles = 2
  expect_equal(P1_3$spatial_cycles, expected_fundamental_cycles)
  expect_equal(P1_3$fundamental_wavenumber, C4_wavenumber / expected_fundamental_cycles)
})
