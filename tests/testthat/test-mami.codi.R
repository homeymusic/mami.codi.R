test_that('form looks good',{
  tonic = 60
  tonic_timbre = hrep::freq(hrep::sparse_fr_spectrum(60,num_harmonics=10))
  harmonics_range = log2(max(tonic_timbre)/min(tonic_timbre))
  chord = c(60,64,67)
  metadata = list(
    label = 'Major Triad',
    type = 'triad'
  )

  major_triad = chord %>% mami.codi(tonic = 60,
                                    metadata=metadata, verbose=TRUE,
                                    num_harmonics=10)

  expect_equal(major_triad$metadata[[1]]$label,'Major Triad')
  expect_equal(major_triad$metadata[[1]]$type,'triad')

  expect_equal(major_triad$reference_register_low, LO_REG)
  expect_equal(major_triad$reference_register_high,HI_REG)
  expect_equal(major_triad$reference_freq_low, hrep::midi_to_freq(LO_MIDI))
  expect_equal(major_triad$reference_freq_high,hrep::midi_to_freq(HI_MIDI),
               tolerance=ONE_PERCENT)
  expect_gt(major_triad$consonance_low,  0)
  expect_gt(major_triad$consonance_high, 0)
  expect_true(is.numeric(major_triad$major_minor))
  expect_gt(major_triad$consonance_dissonance, 0)
})
test_that('metadata is saved',{
  result <- c(60,64,67) %>% mami.codi(tonic=60,
                                      metadata = list(type='triad', label='MT'),
                                      verbose=T)
  expect_equal(result$metadata[[1]]$type,'triad')
  expect_equal(result$metadata[[1]]$label,'MT')
})
test_that('fewest inputs works',{
  result = 60 %>% mami.codi
  expect_true(is.numeric(result$consonance_dissonance))
  expect_true(is.numeric(result$major_minor))
})
test_that('reference pitches transpose correctly',{
  tonic_timbre = hrep::freq(hrep::sparse_fr_spectrum(60,num_harmonics=10))
  result = c(60) %>% mami.codi(tonic=60, verbose=TRUE, num_harmonics = 10)
  expect_equal(result$ratios_low[[1]]$reference_freq%>%unique,
               hrep::midi_to_freq(LO_MIDI),
               tolerance = ONE_PERCENT)
  expect_equal(result$ratios_high[[1]]$reference_freq%>%unique,
               hrep::midi_to_freq(HI_MIDI),
               tolerance = ONE_PERCENT)
  result = c(72) %>% mami.codi(tonic=72, num_harmonics = 10, verbose=T)
  expect_equal(result$ratios_low[[1]]$reference_freq%>%unique,
               hrep::midi_to_freq(LO_MIDI+12),
               tolerance = ONE_PERCENT)
  expect_equal(result$ratios_high[[1]]$reference_freq%>%unique,
               hrep::midi_to_freq(HI_MIDI+12),
               tolerance = ONE_PERCENT)
})
test_that('automatic tonic selection works',{
  auto_tonic = c(60,64,67) %>% mami.codi(verbose=T)
  expect_equal(auto_tonic$tonic_freqs[[1]],hrep::freq(hrep::sparse_fr_spectrum(60)))
  explicit_tonic = c(60,64,67) %>% mami.codi(tonic=60, verbose=T)
  expect_equal(min(explicit_tonic$tonic_freqs[[1]]), hrep::midi_to_freq(60))
})
test_that('ratios are stored',{
  r = c(60,64,67,72) %>% mami.codi(num_harmonics=1,tonic=60,verbose=TRUE)
  expect_equal(nrow(r$ratios_low[[1]]),4)
  expect_equal(nrow(r$ratios_high[[1]]),4)
})
test_that('tonic is major-minor neutral',{
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=2^0,verbose=T)
  expect_equal(tonic$major_minor,0)
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=2^2,verbose=T)
  expect_equal(tonic$major_minor,0)
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=5,verbose=T)
  expect_equal(tonic$major_minor,0)
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=10,verbose=T)
  expect_equal(tonic$major_minor,0)
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=2^4,verbose=T)
  expect_equal(tonic$major_minor,0)
  tonic = c(60) %>% mami.codi(tonic=60,num_harmonics=2^5,verbose=T)
  expect_equal(tonic$major_minor,0)
})
test_that('auto tonic is major-minor neutral for all stretches',{
  P1 = hrep::sparse_fr_spectrum(60,num_harmonics=10,octave_ratio=2) %>%
    mami.codi
  expect_equal(P1$major_minor,0)

  P1 = hrep::sparse_fr_spectrum(60,num_harmonics=10,octave_ratio=2.1) %>%
    mami.codi
  expect_equal(P1$major_minor,0)

  P1 = hrep::sparse_fr_spectrum(60,num_harmonics=10,octave_ratio=1.9) %>%
    mami.codi
  expect_equal(P1$major_minor,0)
})
test_that('verbose works as expected', {
  colnames_default = colnames(mami.codi(60))
  colnames_quiet = colnames(mami.codi(60,verbose=FALSE))
  expect_equal(colnames_default,colnames_quiet)
  colnames_verbose = colnames(mami.codi(60,verbose=TRUE))
  expect_gt(length(colnames_verbose), length(colnames_quiet))
})
test_that('default harmonics and octave ratio are syncd with hrep',{
  spectrum = hrep::sparse_fr_spectrum(60)
  freq = hrep::freq(spectrum)
  expect_equal(length(freq),11)
  expect_equal(freq[2],2.0*freq[1], tolerance = ONE_PERCENT)
})
test_that('low and hi consonance makes sense',{
  MT = c(60,64,67) %>% mami.codi(verbose=T)
  expect_gt(MT$consonance_low,0)
  expect_gt(MT$consonance_high,0)
})
test_that('rotation of unison always has zer0 major minor',{
  r = 60 %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(r$major_minor,0,tolerance = ONE_PERCENT)
})
test_that('form looks good',{
  M3 = hrep::midi_to_freq(c(60,64))
  C4 = hrep::midi_to_freq(60)
  jnd = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))
  p = M3 %>% estimate_cycle(reference_freq=C4, jnd, 2, F, 1)
  expect_gt(p$dissonance,0)
  expect_equal(p$ratios[[1]]$reference_freq %>% unique,C4)
})
test_that('ratio behaves well',{
  jnd = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))
  ratios_result = ratios(C4,C3,jnd,2)
  expect_true(is.data.frame(ratios_result), info='ratio results should be a tibble')
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))

  ratios_result = ratios(G4,C3,jnd,2)
  expect_true(is.data.frame(ratios_result), info='ratio results should be a df')
})
test_that('big numbers work well',{
  chord = c(261.6256,331.5198,523.2511,663.0396,784.8767,994.5594,
            1046.5023,1308.1278,1326.0793,1569.7534,1657.5991,1831.3790,
            1989.1189,2093.0045,2320.6387,2354.6301,2616.2556,2652.1585,
            2983.6783,3315.1981)
  ref = 261.6256
  t = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))
  ratio = dplyr::bind_rows(chord %>% lapply(ratios,ref,t,2))
  p = log2(lcm(if (ref<=min(chord)) ratio$den else ratio$num))

  expect_gt(p,0)
})
test_that('lcm can handle big numbers',{
  easy = c(seq(2,10,2))
  expect_equal(lcm(easy),120)

  nasty = c(9,1,11,1,13,3,11,41,2,19,5,11,3,19,7,25,43,4,9,5)
  expect_equal(lcm(nasty),30177447300)
})
test_that('ratio is inverted for ref high',{
  M3 = mami.codi(64,tonic=60,num_harmonics=1,verbose=T)
  expect_gt(M3$ratios_low[[1]]$num, M3$ratios_low[[1]]$den)
  expect_gt(M3$ratios_high[[1]]$num, M3$ratios_high[[1]]$den)
})
test_that('passing in midi or spectrum give same results',{
  m3_midi     = c(60,63) %>% mami.codi(tonic=60)
  m3_spectrum = hrep::sparse_fr_spectrum(c(60,63)) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60))
  expect_equal(m3_midi$major_minor,m3_spectrum$major_minor)
  expect_equal(m3_midi$consonance_dissonance,m3_spectrum$consonance_dissonance)

  m3_midi     = c(60,63) %>% mami.codi
  m3_spectrum = hrep::sparse_fr_spectrum(c(60,63)) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60))
  expect_equal(m3_midi$major_minor,m3_spectrum$major_minor)
  expect_equal(m3_midi$consonance_dissonance,m3_spectrum$consonance_dissonance)
})
test_that('register shifting does not happen when spectrum is passed in',{
  m1 = hrep::sparse_fr_spectrum(c(60,61), num_harmonics=10) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=10), verbose=T)
  expect_equal(m1$reference_register_low,LO_REG)
  expect_equal(m1$reference_register_high,HI_REG)
})
test_that('ratios make sense',{
  t = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))
  r = ratios(440,880,t,2,T)
  expect_equal(r$num,2)
  expect_equal(r$den,1)

  r = ratios(880,440,t,2)
  # freq ratios above 1 are inverted
  expect_equal(r$num,2)
  expect_equal(r$den,1)
})
test_that('pure tone tonic has perfect gRameuas of consonance_dissonance and 0 gRameuas of major_minor', {
  P1_pure_tone = mami.codi(60, num_harmonics=1, verbose=T)
  expect_equal(P1_pure_tone$consonance_dissonance,100,tolerance=ONE_PERCENT)
  expect_equal(P1_pure_tone$major_minor,0)
})
test_that('number of ratios makes sense',{
  P1_pure_tone = mami.codi(60, num_harmonics=1, verbose=T)
  expect_equal(nrow(P1_pure_tone$ratios_low[[1]]),1)
  expect_equal(nrow(P1_pure_tone$ratios_high[[1]]),1)

  P1_timbre = mami.codi(60, num_harmonics=10, verbose=T)
  expect_equal(nrow(P1_timbre$ratios_low[[1]]),10)
  expect_equal(nrow(P1_timbre$ratios_high[[1]]),10)
})
test_that('chord progression works',{
  V       = (c(60,64,67) + 7)  %>% mami.codi(tonic=60, num_harmonics=10, verbose=T)
  expect_equal(V$tonic_freqs[[1]][1],hrep::midi_to_freq(60))
  vii_dim = (c(60,63,66) + 11) %>% mami.codi(tonic=60, num_harmonics=10, verbose=T)
  expect_equal(vii_dim$tonic_freqs[[1]][1],hrep::midi_to_freq(60))
})
test_that('rcpp ratio dens works',{
  r = ratios(440*1:3,880,c(semitone_ratio(-1,2),semitone_ratio(+1,2)),2)
  expect_equal(r$den %>% unique %>% sort, c(1,2))
})
test_that('estimate_cycle works',{
  jnd = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))
  dissonance = estimate_cycle(440*1:3,880,jnd,2,F,1)$dissonance
  expect_equal(dissonance, 1, tolerance = ONE_PERCENT)
})
test_that('chord progression works',{
  V       = (c(60,64,67) + 7)  %>% mami.codi(tonic=60, num_harmonics=10, verbose=T)
  expect_equal(V$tonic_freqs[[1]][1],hrep::midi_to_freq(60))
  vii_dim = (c(60,63,66) + 11) %>% mami.codi(tonic=60, num_harmonics=10, verbose=T)
  expect_equal(vii_dim$tonic_freqs[[1]][1],hrep::midi_to_freq(60))
})
test_that('ref pitch high makes sense',{
  P1 = mami.codi(60,verbose=T, num_harmonics=10)
  expect_equal(P1$ratios_high[[1]]$reference_freq %>% min,
               hrep::midi_to_freq(HI_MIDI), tolerance = ONE_PERCENT)
})
test_that('amplitude 0 does not get included',{
  C4 = hrep::sparse_fr_spectrum(60,num_harmonics=5)
  P1 = mami.codi(C4,tonic=C4,verbose=T)
  expect_equal(P1$chord_freqs[[1]] %>% length, 5)
  expect_equal(P1$tonic_freqs[[1]] %>% length, 5)

  C4$y[3] = 0
  expect_equal(C4$y[3],0)
  P1 = mami.codi(C4,tonic=C4,verbose=T)
  expect_equal(P1$chord_freqs[[1]] %>% length, 4)
  expect_equal(P1$tonic_freqs[[1]] %>% length, 4)
})
test_that('registers high and low based on tonic timbre make semse',{
  M3 = mami.codi(c(60,64),verbose=T,num_harmonics=10)
  expect_gt(M3$reference_freq_high, M3$tonic_freqs[[1]] %>% max)
  expect_equal(M3$reference_freq_high,
               hrep::midi_to_freq(HI_MIDI),
               tolerance=ONE_PERCENT)

  M7 = mami.codi(c(60,71),verbose=T,num_harmonics=10)
  expect_gt(M7$reference_freq_high, M7$tonic_freqs[[1]] %>% max)
  expect_equal(M7$reference_freq_high,
               hrep::midi_to_freq(HI_MIDI),
               tolerance=ONE_PERCENT)

  expect_equal(M3$tonic_freqs[[1]] %>% max, M7$tonic_freqs[[1]] %>% max)
  expect_equal(M3$reference_freq_high, M7$reference_freq_high)
})
test_that('pure tones registers high and low based on tonic timbre make semse',{
  M3 = mami.codi(c(60,64),verbose=T,num_harmonics=1)
  expect_gt(M3$reference_freq_high, M3$tonic_freqs[[1]] %>% max)
  expect_equal(M3$reference_freq_high,
               hrep::midi_to_freq(60+12*(HI_MIN_REG)),
               tolerance=ONE_PERCENT)

  M7 = mami.codi(c(60,71),verbose=T,num_harmonics=1)
  expect_gt(M7$reference_freq_high, M7$tonic_freqs[[1]] %>% max)
  expect_equal(M7$reference_freq_high,
               hrep::midi_to_freq(60+12*(HI_MIN_REG)),
               tolerance=ONE_PERCENT)

  expect_equal(M3$tonic_freqs[[1]] %>% max, M7$tonic_freqs[[1]] %>% max)
  expect_equal(M3$reference_freq_high, M7$reference_freq_high)
})
test_that('registers makes sense for freqs above and below tonic',{
  P16 = mami.codi(60+c(0,+24),tonic=60,verbose=T)
  expect_equal(P16$reference_register_low,LO_REG)
  expect_equal(P16$reference_register_high,HI_REG+1)

  dual_P16 = mami.codi(60+c(0,-24),tonic=60,verbose=T)
  expect_equal(dual_P16$reference_register_low,LO_REG-1)
  expect_equal(dual_P16$reference_register_high,HI_REG)
})
test_that('pseudo octaves work as expected',{
  P1_stretched  = mami.codi(60, num_harmonics=10, octave_ratio=2.1, verbose=T)
  P1_harmonic   = mami.codi(60, num_harmonics=10, octave_ratio=2.0, verbose=T)
  P1_compressed = mami.codi(60, num_harmonics=10, octave_ratio=1.9, verbose=T)

  expect_equal(P1_stretched$pseudo_octave,  2.1)
  expect_equal(P1_harmonic$pseudo_octave,   2.0)
  expect_equal(P1_compressed$pseudo_octave, 1.9)

  expect_equal(P1_stretched$reference_register_high,  HI_REG)
  expect_equal(P1_harmonic$reference_register_high,   HI_REG)
  expect_equal(P1_compressed$reference_register_high, HI_REG)

  expect_equal(P1_stretched$reference_freq_high,
               (P1_stretched$tonic_freqs[[1]] %>% min)*2.1^HI_REG,
               tolerance = ONE_PERCENT)
  expect_equal(P1_harmonic$reference_freq_high,
               (P1_harmonic$tonic_freqs[[1]] %>% min)*2.0^HI_REG,
               tolerance = ONE_PERCENT)
  expect_equal(P1_compressed$reference_freq_high,
               (P1_compressed$tonic_freqs[[1]] %>% min)*1.9^HI_REG,
               tolerance = ONE_PERCENT)

  expect_equal(P1_stretched$tolerance_window[[1]],
               c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE, 2.1),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE, 2.1)),
               tolerance = ONE_PERCENT)

})
test_that('semitone ratio works',{
  expect_gt(semitone_ratio(DEFAULT_SEMITONE_TOLERANCE,2.1),semitone_ratio(DEFAULT_SEMITONE_TOLERANCE,2.0))
  expect_equal(semitone_ratio(DEFAULT_SEMITONE_TOLERANCE,2,steps=TRICIA),
               semitone_ratio(25,2,steps=CENTS),
               tolerance = ONE_PERCENT)
})
test_that('pseudo ratios for P8 work in stern brocot',{
  jnd = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),
          semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))

  harmonic_P8 = mami.codi(60, verbose=T, num_harmonics=2, octave_ratio=2.0)
  P1_h_freq = harmonic_P8$chord_freqs[[1]] %>% min
  P8_h_freq = harmonic_P8$chord_freqs[[1]] %>% max
  expect_equal(harmonic_P8$pseudo_octave,2.0)
  # up
  ratios_result = ratios(P8_h_freq,P1_h_freq,jnd,harmonic_P8$pseudo_octave)
  expect_equal(ratios_result$freq_ratio,2.0)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))
  # inverted
  ratios_result = ratios(P1_h_freq,P8_h_freq,jnd,harmonic_P8$pseudo_octave, T)
  expect_equal(ratios_result$freq_ratio,2.0)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))

  # two harmonics is too few to tell ratio
  stretched_P8 = mami.codi(60, verbose=T, num_harmonics=2, octave_ratio=2.1)
  P1_freq = stretched_P8$chord_freqs[[1]] %>% min
  P8_freq = stretched_P8$chord_freqs[[1]] %>% max

  # up
  ratios_result = ratios(P8_freq,P1_freq,jnd,2.1)
  expect_equal(ratios_result$freq_ratio,2.1)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))
  # inverted
  ratios_result = ratios(P1_freq,P8_freq,jnd,2.1,T)
  expect_equal(ratios_result$freq_ratio,2.1)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))

  compressed_P8 = mami.codi(60, verbose=T, num_harmonics=2, octave_ratio=1.9)
  P1_freq = compressed_P8$chord_freqs[[1]] %>% min
  P8_freq = compressed_P8$chord_freqs[[1]] %>% max
  # up
  ratios_result = ratios(P8_freq,P1_freq,jnd,1.9)
  expect_equal(ratios_result$freq_ratio,1.9)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))
  # inverted
  ratios_result = ratios(P1_freq,P8_freq,jnd,1.9,T)
  expect_equal(ratios_result$freq_ratio,1.9)
  expect_equal(ratios_result$pseudo_ratio,2.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(2,1))
})
test_that('pseudo ratios for P8 work in stern brocot',{
  jnd = c(semitone_ratio(-DEFAULT_SEMITONE_TOLERANCE,2),semitone_ratio(+DEFAULT_SEMITONE_TOLERANCE,2))

  harmonic_P12 = mami.codi(60, verbose=T, num_harmonics=3, octave_ratio=2.0)
  P1_h_freq = harmonic_P12$chord_freqs[[1]] %>% min
  P12_h_freq = harmonic_P12$chord_freqs[[1]] %>% max
  expect_equal(harmonic_P12$pseudo_octave,2.0)
  # up
  ratios_result = ratios(P12_h_freq,P1_h_freq,jnd,2)
  expect_equal(ratios_result$freq_ratio,3.0)
  expect_equal(ratios_result$pseudo_ratio,3.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))
  # inverted
  ratios_result = ratios(P1_h_freq,P12_h_freq,jnd,2,T)
  expect_equal(ratios_result$freq_ratio,3.0)
  expect_equal(ratios_result$pseudo_ratio,3.0)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))

  stretched_P12 = mami.codi(60, verbose=T, num_harmonics=3, octave_ratio=2.1)
  P1_freq = stretched_P12$chord_freqs[[1]] %>% min
  P12_freq = stretched_P12$chord_freqs[[1]] %>% max
  expect_equal(stretched_P12$pseudo_octave,2.1)
  # up
  ratios_result = ratios(P12_freq,P1_freq,jnd,2.1)
  expect_equal(ratios_result$freq_ratio,3.241197,tolerance = ONE_PERCENT)
  expect_equal(ratios_result$pseudo_ratio,3.0,tolerance = ONE_PERCENT)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))
  # inverted
  ratios_result = ratios(P1_freq,P12_freq,jnd,2.1,T)
  expect_equal(ratios_result$freq_ratio,3.241197,tolerance = ONE_PERCENT)
  expect_equal(ratios_result$pseudo_ratio,3.0,tolerance = ONE_PERCENT)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))

  compressed_P12 = mami.codi(60, verbose=T, num_harmonics=3, octave_ratio=1.9)
  P1_freq = compressed_P12$chord_freqs[[1]] %>% min
  P12_freq = compressed_P12$chord_freqs[[1]] %>% max
  expect_equal(compressed_P12$pseudo_octave,1.9)
  # up
  ratios_result = ratios(P12_freq,P1_freq,jnd,1.9)
  expect_equal(ratios_result$freq_ratio,2.765757,tolerance = ONE_PERCENT)
  expect_equal(ratios_result$pseudo_ratio,3.0, tolerance = ONE_PERCENT)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))
  # inverted
  ratios_result = ratios(P1_freq,P12_freq,jnd,1.9,T)
  expect_equal(ratios_result$freq_ratio,2.765757,tolerance = ONE_PERCENT)
  expect_equal(ratios_result$pseudo_ratio,3.0,tolerance = ONE_PERCENT)
  expect_equal(c(ratios_result$num,ratios_result$den),c(3,1))
})
test_that('ratios work as expected in mami.codi',{
  low_pseudo_ratios = c(1,2,3)*2^(BUFFER)
  high_pseudo_ratios = c(1+1/3,2,4)*2^(BUFFER)
  l_n=3*2^(BUFFER)
  l_d=1
  h_n=4*2^(BUFFER)
  h_d=3

  P1_harmonic = mami.codi(60,num_harmonics=3,octave_ratio=2.0,verbose=T)
  expect_equal(P1_harmonic$reference_register_low, -BUFFER)
  expect_equal(P1_harmonic$reference_register_high, +BUFFER+2)
  expect_equal(P1_harmonic$ratios_low[[1]]$pseudo_ratio %>% sort,low_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_harmonic$ratios_low[[1]]$num[3],l_n)
  expect_equal(P1_harmonic$ratios_low[[1]]$den[3],l_d)
  expect_equal(P1_harmonic$ratios_high[[1]]$pseudo_ratio %>% sort,high_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_harmonic$ratios_high[[1]]$num[3],h_n)
  expect_equal(P1_harmonic$ratios_high[[1]]$den[3],h_d)

  P1_stretched = mami.codi(60,num_harmonics=3,octave_ratio=2.1,verbose=T)
  expect_equal(P1_harmonic$reference_register_low, -BUFFER)
  expect_equal(P1_harmonic$reference_register_high, +BUFFER+2)
  expect_equal(P1_stretched$ratios_low[[1]]$pseudo_ratio %>% sort,low_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_stretched$ratios_low[[1]]$num[3],l_n)
  expect_equal(P1_stretched$ratios_low[[1]]$den[3],l_d)
  expect_equal(P1_stretched$ratios_high[[1]]$pseudo_ratio %>% sort,high_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_stretched$ratios_high[[1]]$num[3],h_n)
  expect_equal(P1_stretched$ratios_high[[1]]$den[3],h_d)

  P1_compressed = mami.codi(60,num_harmonics=3,octave_ratio=1.9,verbose=T)
  expect_equal(P1_harmonic$reference_register_low, -BUFFER)
  expect_equal(P1_harmonic$reference_register_high, +BUFFER+2)
  expect_equal(P1_compressed$ratios_low[[1]]$pseudo_ratio %>% sort,low_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_compressed$ratios_low[[1]]$num[2],l_n)
  expect_equal(P1_compressed$ratios_low[[1]]$den[2],l_d)
  expect_equal(P1_compressed$ratios_high[[1]]$pseudo_ratio %>% sort,high_pseudo_ratios,
               tolerance=ONE_PERCENT)
  expect_equal(P1_compressed$ratios_high[[1]]$num[2],h_n)
  expect_equal(P1_compressed$ratios_high[[1]]$den[2],h_d)
})
test_that('1 harmonic low and hi registers make sense',{
  P1 = 60 %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(P1$reference_register_low,LO_MIN_REG)
  expect_equal(P1$reference_register_high,HI_MIN_REG)
  P1plus = c(60,60.01) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(P1plus$reference_register_low,LO_MIN_REG)
  expect_equal(P1plus$reference_register_high,HI_MIN_REG)
  m6 = c(60,68) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(m6$reference_register_low,LO_MIN_REG)
  expect_equal(m6$reference_register_high,HI_MIN_REG)
  M6 = c(60,69) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(M6$reference_register_low,LO_MIN_REG)
  expect_equal(M6$reference_register_high,HI_MIN_REG)
  P8 = c(60,72) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(P8$reference_register_low,LO_MIN_REG)
  expect_equal(P8$reference_register_high,HI_MIN_REG)
  m9 = c(60,73) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(m9$reference_register_low,LO_MIN_REG)
  expect_equal(m9$reference_register_high,HI_MIN_REG+1)
  m10 = c(60,75) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(m10$reference_register_low,LO_MIN_REG)
  expect_equal(m10$reference_register_high,HI_MIN_REG+1)
  P12 = c(60,67+12) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(P12$reference_register_low,LO_MIN_REG)
  expect_equal(P12$reference_register_high,HI_MIN_REG+1)
  P15 = c(60,84) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(P15$reference_register_low,LO_MIN_REG)
  expect_equal(P15$reference_register_high,HI_MIN_REG+1)
  m16 = c(60,85) %>% mami.codi(verbose=T, num_harmonics=1)
  expect_equal(m16$reference_register_low,LO_MIN_REG)
  expect_equal(m16$reference_register_high,HI_MIN_REG+2)
  m6 = hrep::sparse_fr_spectrum(c(60,68), num_harmonics=1) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=1), verbose=T)
  expect_equal(m6$reference_register_low,LO_MIN_REG)
  expect_equal(m6$reference_register_high,HI_MIN_REG)
  M6 = hrep::sparse_fr_spectrum(c(60,69), num_harmonics=1) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=1), verbose=T)
  expect_equal(M6$reference_register_low,LO_MIN_REG)
  expect_equal(M6$reference_register_high,HI_MIN_REG)
})
test_that('5 harmonics low and hi registers make sense',{
  P1 = 60 %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(P1$reference_register_low,LO_REG)
  expect_equal(P1$reference_register_high,HI_REG-1)
  P1plus = c(60,60.01) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(P1plus$reference_register_low,LO_REG)
  expect_equal(P1plus$reference_register_high,HI_REG-1)
  m6 = c(60,68) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(m6$reference_register_low,LO_REG)
  expect_equal(m6$reference_register_high,HI_REG-1)
  M6 = c(60,69) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(M6$reference_register_low,LO_REG)
  expect_equal(M6$reference_register_high,HI_REG-1)
  P8 = c(60,72) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(P8$reference_register_low,LO_REG)
  expect_equal(P8$reference_register_high,HI_REG)
  m9 = c(60,73) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(m9$reference_register_low,LO_REG)
  expect_equal(m9$reference_register_high,HI_REG-1)
  m10 = c(60,75) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(m10$reference_register_low,LO_REG)
  expect_equal(m10$reference_register_high,HI_REG-1)
  m10_stretched = c(60,75) %>% mami.codi(verbose=T, num_harmonics=10, octave_ratio=2.1)
  expect_equal(m10_stretched$reference_register_low,LO_REG)
  expect_equal(m10_stretched$reference_register_high,HI_REG)
  P12 = c(60,67+12) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(P12$reference_register_low,LO_REG)
  expect_equal(P12$reference_register_high,HI_REG-1)
  P15 = c(60,84) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(P15$reference_register_low,LO_REG)
  expect_equal(P15$reference_register_high,HI_REG+1)
  m16 = c(60,85) %>% mami.codi(verbose=T, num_harmonics=5)
  expect_equal(m16$reference_register_low,LO_REG)
  expect_equal(m16$reference_register_high,HI_REG)
  m6 = hrep::sparse_fr_spectrum(c(60,68), num_harmonics=5) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=5), verbose=T)
  expect_equal(m6$reference_register_low,LO_REG)
  expect_equal(m6$reference_register_high,HI_REG-1)
  M6 = hrep::sparse_fr_spectrum(c(60,69), num_harmonics=5) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=5), verbose=T)
  expect_equal(M6$reference_register_low,LO_REG)
  expect_equal(M6$reference_register_high,HI_REG-1)
})
test_that('10 harmonics low and hi registers make sense',{
  P1 = 60 %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(P1$reference_register_low,LO_REG)
  expect_equal(P1$reference_register_high,HI_REG)
  P1plus = c(60,60.01) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(P1plus$reference_register_low,LO_REG)
  expect_equal(P1plus$reference_register_high,HI_REG)
  m6 = c(60,68) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(m6$reference_register_low,LO_REG)
  expect_equal(m6$reference_register_high,HI_REG)
  M6 = c(60,69) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(M6$reference_register_low,LO_REG)
  expect_equal(M6$reference_register_high,HI_REG)
  P8 = c(60,72) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(P8$reference_register_low,LO_REG)
  expect_equal(P8$reference_register_high,HI_REG+1)
  m9 = c(60,73) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(m9$reference_register_low,LO_REG)
  expect_equal(m9$reference_register_high,HI_REG)
  m10 = c(60,75) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(m10$reference_register_low,LO_REG)
  expect_equal(m10$reference_register_high,HI_REG)
  m10_stretched = c(60,75) %>% mami.codi(verbose=T, num_harmonics=10, octave_ratio=2.1)
  expect_equal(m10_stretched$reference_register_low,LO_REG)
  expect_equal(m10_stretched$reference_register_high,HI_REG)
  P12 = c(60,67+12) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(P12$reference_register_low,LO_REG)
  expect_equal(P12$reference_register_high,HI_REG)
  P15 = c(60,84) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(P15$reference_register_low,LO_REG)
  expect_equal(P15$reference_register_high,HI_REG+2)
  m16 = c(60,85) %>% mami.codi(verbose=T, num_harmonics=10)
  expect_equal(m16$reference_register_low,LO_REG)
  expect_equal(m16$reference_register_high,HI_REG+1)
  m6 = hrep::sparse_fr_spectrum(c(60,68), num_harmonics=10) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=10), verbose=T)
  expect_equal(m6$reference_register_low,LO_REG)
  expect_equal(m6$reference_register_high,HI_REG)
  M6 = hrep::sparse_fr_spectrum(c(60,69), num_harmonics=10) %>%
    mami.codi(tonic=hrep::sparse_fr_spectrum(60, num_harmonics=10), verbose=T)
  expect_equal(M6$reference_register_low,LO_REG)
  expect_equal(M6$reference_register_high,HI_REG)
})
test_that('highest and lowest chord freqs make sense',{
  m2 = mami.codi(c(60,61),num_harmonics=10,verbose=T)
  m9 = mami.codi(c(60,73),num_harmonics=10,verbose=T)
  compound_m2s = dplyr::bind_rows(m2,m9)

  expect_equal(length(compound_m2s$tonic_freqs %>% unlist),20)
  expect_equal(length(compound_m2s$chord_freqs %>% unlist),40)
})
test_that('pure tone pseudo octave works',{
  A4 = listen_for_harmonics(c(440))
  expect_equal(A4$freq[1],440)
  expect_equal(A4$pseudo_octave,2)
})
test_that('freqs outside valid harmonics range default to pseudo octave 2',{
  expect_equal(listen_for_harmonics(c(440,3/2*440))$pseudo_octave,2)
})
test_that('tricky pseudo octave cases work as expected',{
  P8_compressed = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=1.9)
  expect_equal(listen_for_harmonics(P8_compressed %>% hrep::freq())$pseudo_octave %>% max,1.9)
  expect_equal(nrow(listen_for_harmonics(P8_compressed %>% hrep::freq())),10)
  P8_harmonic = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=2.0)
  expect_equal(listen_for_harmonics(P8_harmonic %>% hrep::freq())$pseudo_octave %>% max,2.0)
  expect_equal(nrow(listen_for_harmonics(P8_harmonic %>% hrep::freq())),10)
  P8_stretched = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=2.1)
  expect_equal(listen_for_harmonics(P8_stretched %>% hrep::freq())$pseudo_octave %>% max,2.1)
  expect_equal(nrow(listen_for_harmonics(P8_stretched %>% hrep::freq())),10)
})
test_that('mami codi pseudo octaves work',{
  P8_compressed = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=1.9)
  P8_compressed_results = mami.codi(P8_compressed, verbose=T)
  expect_equal(P8_compressed_results$pseudo_octave,1.9)

  P8_harmonic = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=2.0)
  P8_harmonic_results = mami.codi(P8_harmonic, verbose=T)
  expect_equal(P8_harmonic_results$pseudo_octave,2.0)

  P8_stretched = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=10,octave_ratio=2.1)
  P8_stretched_results = mami.codi(P8_stretched, verbose=T)
  expect_equal(P8_stretched_results$pseudo_octave,2.1)
})
test_that('number of harmonics makes sense for harmonics octave',{
  P8_harmonic = hrep::sparse_fr_spectrum(c(60,72),num_harmonics=10,octave_ratio=2.0)
  P8_harmonic_results = mami.codi(P8_harmonic, verbose=T)
  expect_equal(P8_harmonic_results$pseudo_octave,2.0)
})
test_that('pure tones makes sesne for octave_ratios',{
  P8_minus_pure         = hrep::sparse_fr_spectrum(c(60,71.5),num_harmonics=1)
  P8_minus_pure_results = mami.codi(P8_minus_pure, verbose=T)
  expect_equal(P8_minus_pure_results$pseudo_octave,2.0)

  P8_pure         = hrep::sparse_fr_spectrum(c(60,72.00),num_harmonics=1)
  P8_pure_results = mami.codi(P8_pure, verbose=T)
  expect_equal(P8_pure_results$pseudo_octave,2.0)

  P8_plus_pure  = hrep::sparse_fr_spectrum(c(60,72.5),num_harmonics=1)
  P8_plus_pure_results = mami.codi(P8_plus_pure, verbose=T)
  expect_equal(P8_plus_pure_results$pseudo_octave,2.0)

})
test_that('more than two harmonics needed to guess pseudo_octave',{
  # two harmonics is too few to tell ratio
  stretched_P8 = mami.codi(60, verbose=T, num_harmonics=2, octave_ratio=2.1)
  P1_freq = stretched_P8$chord_freqs[[1]] %>% min
  P8_freq = stretched_P8$chord_freqs[[1]] %>% max
  expect_equal(stretched_P8$pseudo_octave,2.0)

  # but three is enough
  stretched_P8 = mami.codi(60, verbose=T, num_harmonics=3, octave_ratio=2.1)
  P1_freq = stretched_P8$chord_freqs[[1]] %>% min
  P8_freq = stretched_P8$chord_freqs[[1]] %>% max
  expect_equal(stretched_P8$pseudo_octave,2.1)
})
test_that('for chord progression default mami.codi returns tonic spectrum',{
  P1 = mami.codi(60)
  expect_equal(class(P1$tonic[[1]])[1],'sparse_fr_spectrum')
})
test_that('auto tonic freqs with dropped harmonic works',{
  P1 = hrep::sparse_fr_spectrum(60,num_harmonics=10,octave_ratio=2.1)
  P1_freqs = P1 %>% hrep::freq()
  P1_freqs = P1_freqs[-3]
  h = listen_for_harmonics(P1_freqs)
  expect_equal(h$freq, P1_freqs)
})
test_that('P1 maj min and co di is the same for various pseudo octaves',{
  P1_stretched = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=2.1)
  P1_harmonic = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=2.0)
  P1_compressed = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=1.9)

  expect_equal(P1_harmonic$major_minor, P1_stretched$major_minor)
  expect_equal(P1_harmonic$major_minor, P1_compressed$major_minor)

  expect_equal(P1_harmonic$consonance_dissonance, P1_stretched$consonance_dissonance)
  expect_equal(P1_harmonic$consonance_dissonance, P1_compressed$consonance_dissonance)
})
test_that('bonang major-minor makes sense',{
  voice         = hrep::midi_to_freq(60)
  voice_timbre  = voice * 1:4

  bonang        = hrep::midi_to_freq(60)
  bonang_timbre = bonang * c(1, 1.52, 3.46, 3.92)

  dyad_spectrum = tibble::tibble(
    frequency = c(voice_timbre, bonang_timbre),
    amplitude = 1
  ) %>% as.list() %>% hrep::sparse_fr_spectrum()

  gamelan       = dyad_spectrum %>% mami.codi(verbose=T)

  expect_equal(gamelan$pseudo_octave,2.0)
  expect_equal(gamelan$tonic_freqs[[1]],voice_timbre)
})
test_that('analyze harmonics works as expected',{
  n  = 10
  x  = 440*1:n
  tolerance_octave_ratio=DEFAULT_OCTAVE_TOLERANCE

  potential_harmonics = analyze_harmonics(x)
  expect_equal(nrow(potential_harmonics),19)
  analysis = potential_harmonics %>%
    dplyr::count(.data$pseudo_octave, name='num_harmonics',sort=TRUE) %>%
    dplyr::slice(1)
  expect_equal(analysis$pseudo_octave,2)
  expect_equal(analysis$num_harmonics,9)
})
test_that('auto tonic works as expected',{
  P1_stretched  = mami.codi(60, num_harmonics=10, octave_ratio=2.1,verbose=T)
  P1_harmonic   = mami.codi(60, num_harmonics=10, octave_ratio=2.0, verbose=T)
  P1_compressed = mami.codi(60, num_harmonics=10, octave_ratio=1.9, verbose=T)

  expect_equal(P1_stretched$tonic_freqs[[1]],
               P1_stretched$chord_freqs[[1]],
               tolerance = ONE_PERCENT)

  expect_equal(P1_harmonic$tonic_freqs[[1]],
               P1_harmonic$chord_freqs[[1]],
               tolerance = ONE_PERCENT)

  expect_equal(P1_compressed$tonic_freqs[[1]],
               P1_compressed$chord_freqs[[1]],
               tolerance = ONE_PERCENT)
})
test_that('reference freq is stored in ratios',{
  MT = c(60,64,67) %>% mami.codi(num_harmonics=10, verbose=T)
  expect_equal(MT$ratios_low[[1]]$reference_freq %>% unique, LO_FREQ)
  expect_equal(MT$ratios_high[[1]]$reference_freq %>% unique, HI_FREQ)
})
test_that('period of the chord makes sense', {
  M3 = c(60,64) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_lt(M3$period_low, M3$period_high)
  expect_lt(M3$dissonance_low, M3$dissonance_high)
  expect_gt(M3$freq_low, M3$freq_high)
  expect_equal(M3$lcm_low[[1]],  2)
  expect_equal(M3$lcm_high[[1]], 5)
  expect_equal(M3$period_high * as.integer(M3$lcm_low[[1]]) /
                 as.integer(M3$lcm_high[[1]]), M3$period_low)

  m3 = c(60,63) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_gt(m3$period_low, m3$period_high)
  expect_gt(m3$dissonance_low, m3$dissonance_high)
  expect_lt(m3$freq_low, m3$freq_high)
  expect_equal(m3$lcm_low[[1]],  5)
  expect_equal(m3$lcm_high[[1]], 3)
  expect_equal(m3$period_high * as.integer(m3$lcm_low[[1]]) /
                 as.integer(m3$lcm_high[[1]]), m3$period_low)
})
test_that('period of the chord with harmonics makes sense', {
  M3 = c(60,64) %>% mami.codi(num_harmonics=10, verbose=T)
  expect_lt(M3$lcm_low[[1]], M3$lcm_high[[1]])
  expect_lt(M3$dissonance_low, M3$dissonance_high)
  expect_gt(M3$consonance_low, M3$consonance_high)
  expect_gt(M3$major_minor, 0)
  expect_lt(M3$period_low, M3$period_high)
  expect_gt(M3$freq_low, M3$freq_high)
  expect_equal(M3$lcm_low[[1]],  2)
  expect_equal(M3$lcm_high[[1]], 2520)
  expect_equal(M3$period_high * as.integer(M3$lcm_low[[1]]) / as.integer(M3$lcm_high[[1]]), M3$period_low)

  m3 = c(60,63) %>% mami.codi(num_harmonics=10, verbose=T)
  expect_lt(m3$consonance_low, m3$consonance_high)
  expect_lt(m3$major_minor, 0)
  expect_equal(m3$lcm_low[[1]],  60)
  expect_equal(m3$lcm_high[[1]], 210)
  expect_equal(m3$period_high * as.integer(m3$lcm_low[[1]]) / as.integer(m3$lcm_high[[1]]), m3$period_low)
})
test_that('relative periods work as expected', {
  MT = c(60,64,67) %>% mami.codi(num_harmonics=1, verbose=T)

  expect_equal(MT$period_low / (1/min(MT$ratios_low[[1]]$pitch_freq)), 2,
               tolerance = ONE_PERCENT)

  expect_equal(MT$period_high / (1/min(MT$ratios_high[[1]]$pitch_freq)), 15,
               tolerance = ONE_PERCENT)

  mT = c(60,63,67) %>% mami.codi(num_harmonics=1, verbose=T)

  expect_equal(mT$period_low / (1/min(mT$ratios_low[[1]]$pitch_freq)), 5,
               tolerance = ONE_PERCENT)

  expect_equal(mT$period_high / (1/min(mT$ratios_high[[1]]$pitch_freq)), 3,
               tolerance = ONE_PERCENT)
})
test_that('how dissonant does it get?',{
  nasty = 60:75 %>% mami.codi()
  expect_gt(nasty$consonance_dissonance,0)
  nastier = seq(60,86,0.5) %>% mami.codi()
  expect_gt(nastier$consonance_dissonance,0)
})
test_that('pure tones are higher consonance than complex',{
  P1_pure = mami.codi(60,num_harmonics=1,verbose=T)
  P1_comp = mami.codi(60,num_harmonics=10,verbose=T)
  expect_gt(P1_pure$consonance_dissonance, P1_comp$consonance_dissonance)
})
