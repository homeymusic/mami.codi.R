test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_equal(P1$dissonance, 0)
  expect_equal(P1$time_cycles, 1)
  expect_equal(P1$space_cycles, 1)
  expect_equal(P1$time_dissonance, 0)
  expect_equal(P1$space_dissonance, 0)
})
test_that('P1 with 3 harmonics fundamental frequency and fundamental wavenumber have different cycles',{
  P1_3 = c(60) %>% mami.codi(num_harmonics = 3, verbose=T)
  C4_frequency = hrep::midi_to_freq(60)
  C4_wavenumber = hrep::midi_to_freq(60) / C_SOUND

  expected_time_cycles = 1
  expect_equal(P1_3$time_cycles, expected_time_cycles)
  expect_equal(P1_3$fundamental_frequency, C4_frequency / expected_time_cycles)

  expected_space_cycles = 2
  expect_equal(P1_3$space_cycles, expected_space_cycles)
  expect_equal(P1_3$fundamental_wavenumber, C4_wavenumber / expected_space_cycles)

  expect_false(expected_time_cycles == expected_space_cycles)
})
test_that('M3 is major m3 is minor pure P1 P8 neutral',{
  num_harmonics = 10
  P1 = c(60) %>% mami.codi(num_harmonics=1)
  expect_true(P1$majorness == 0)
  m3 = c(60, 63) %>% mami.codi(num_harmonics=num_harmonics)
  expect_true(m3$majorness < 0)
  M3 = c(60, 64) %>% mami.codi(num_harmonics=num_harmonics)
  expect_true(M3$majorness > 0)
  P8 = c(60, 72) %>% mami.codi(num_harmonics=1)
  expect_true(P1$majorness == 0)
})
