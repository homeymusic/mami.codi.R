test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$temporal_cycles, 1)
  expect_equal(P1$spatial_cycles, 1)
  expect_equal(P1$temporal_dissonance, 0)
  expect_equal(P1$spatial_dissonance, 0)
})
test_that('P1 with 3 harmonics fundamental frequency and fundamental wavenumber have different cycles',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T)
  C4_frequency = hrep::midi_to_freq(60)
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  expected_temporal_cycles = 1
  expect_equal(P1_3$temporal_cycles, expected_temporal_cycles)
  expect_equal(P1_3$fundamental_frequency, C4_frequency / expected_temporal_cycles)

  expected_spatial_cycles = 2
  expect_equal(P1_3$spatial_cycles, expected_spatial_cycles)
  expect_equal(P1_3$fundamental_wavenumber, C4_wavenumber / expected_spatial_cycles)

  expect_false(expected_temporal_cycles == expected_spatial_cycles)
})
test_that()
