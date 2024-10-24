test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$log2_temporal_cycles, 0)
  expect_equal(P1$log2_spatial_cycles, 0)
})
test_that('fundamental frequency calc',{
  C4_freq = hrep::midi_to_freq(60)

  P1 = c(60) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 1
  expect_equal(P1$temporal_cycles, expected_fundamental_cycles)
  expect_equal(P1$fundamental_frequency, C4_freq / expected_fundamental_cycles)

  P5 = c(60, 67) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 3
  expect_equal(P5$temporal_cycles, expected_fundamental_cycles)
  expect_equal(P5$fundamental_frequency, C4_freq / expected_fundamental_cycles)

  P8 = c(60, 72) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 2
  expect_equal(P8$temporal_cycles, expected_fundamental_cycles)
  expect_equal(P8$fundamental_frequency, C4_freq / expected_fundamental_cycles)

})
test_that('fundamental wavenumber calc',{
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  P1 = c(60) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 1
  expect_equal(P1$spatial_cycles, expected_fundamental_cycles)
  expect_equal(P1$fundamental_wavenumber, C4_wavenumber / expected_fundamental_cycles)

  P5 = c(60, 67) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 2
  expect_equal(P5$spatial_cycles, expected_fundamental_cycles)
  expect_equal(P5$fundamental_wavenumber, C4_wavenumber / expected_fundamental_cycles)

  P8 = c(60, 72) %>% mami.codi(num_harmonics = 1, verbose=T)
  expected_fundamental_cycles = 1
  expect_equal(P8$spatial_cycles, expected_fundamental_cycles)
  expect_equal(P8$fundamental_wavenumber, C4_wavenumber / expected_fundamental_cycles)
})
test_that('major-minor tonality',{
  M3 = c(60, 64, 72) %>% mami.codi(num_harmonics = 1, verbose=T)
  m6 = c(60, 68, 72) %>% mami.codi(num_harmonics = 1, verbose=T)
  expect_true(M3$temporal_cycles <= m6$temporal_cycles)
  expect_true(M3$spatial_cycles >= m6$spatial_cycles)
  expect_true(M3$majorness > m6$majorness)
})
