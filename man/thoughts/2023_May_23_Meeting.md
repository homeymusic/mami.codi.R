2023 May 23 Meeting with Peter
================

### Major Third

``` r
M3 = hrep::sparse_fr_spectrum(c(60,64), num_harmonics=10, octave_ratio=2.1) %>%
  mami.codi(verbose=T)
```

``` r
M3$ratios_low[[1]] %>% 
  dplyr::arrange(pitch_freq) %>% 
  dplyr::mutate(midi=round(hrep::freq_to_midi(pitch_freq),1))
```

    ##    num den freq_ratio pseudo_ratio pitch_freq reference_freq  midi
    ## 1    1   1   1.000000     1.000000   261.6256       261.6256  60.0
    ## 2    5   4   1.259921     1.240923   329.6276       261.6256  64.0
    ## 3    2   1   2.100000     2.000000   549.4137       261.6256  72.8
    ## 4    5   2   2.645834     2.481845   692.2179       261.6256  76.8
    ## 5    3   1   3.241197     3.000000   847.9801       261.6256  80.4
    ## 6   11   3   4.083653     3.722768  1068.3880       261.6256  84.4
    ## 7    4   1   4.410000     4.000000  1153.7688       261.6256  85.7
    ## 8    5   1   5.556252     4.963691  1453.6575       261.6256  89.7
    ## 9    5   1   5.599768     5.000000  1465.0425       261.6256  89.8
    ## 10   6   1   6.806515     6.000000  1780.7583       261.6256  93.2
    ## 11  25   4   7.055266     6.204613  1845.8379       261.6256  93.8
    ## 12   7   1   8.027567     7.000000  2100.2167       261.6256  96.1
    ## 13  15   2   8.575671     7.445536  2243.6148       261.6256  97.2
    ## 14   8   1   9.261000     8.000000  2422.9144       261.6256  98.5
    ## 15  26   3  10.114100     8.686458  2646.1072       261.6256 100.1
    ## 16   9   1  10.505362     9.000000  2748.4712       261.6256 100.7
    ## 17  10   1  11.668129     9.927381  3052.6808       261.6256 102.5
    ## 18  10   1  11.759513    10.000000  3076.5893       261.6256 102.7
    ## 19  11   1  13.235926    11.168304  3462.8567       261.6256 104.7
    ## 20  25   2  14.816058    12.409227  3876.2596       261.6256 106.7

``` r
dens = M3$ratios_low[[1]]$den %>% unique %>% sort
tibble::tibble_row(
  unique_denominators = paste(dens, collapse=' '),
  relative_period_length  = lcm(dens) %>% as.integer,
  log2=log2(relative_period_length),
  consonance_below=ZARLINO-log2
)
```

    ## # A tibble: 1 × 4
    ##   unique_denominators relative_period_length  log2 consonance_below
    ##   <chr>                                <int> <dbl>            <dbl>
    ## 1 1 2 3 4                                 12  3.58             67.1

``` r
M3$ratios_high[[1]] %>%
  dplyr::arrange(pitch_freq) %>% 
  dplyr::mutate(midi=round(hrep::freq_to_midi(pitch_freq),1))
```

    ##    num den freq_ratio pseudo_ratio pitch_freq reference_freq  midi
    ## 1   32   1  40.841010    32.000000   261.6256       10685.05  60.0
    ## 2   26   1  32.415531    25.787264   329.6276       10685.05  64.0
    ## 3   16   1  19.448100    16.000000   549.4137       10685.05  72.8
    ## 4   13   1  15.435967    12.893632   692.2179       10685.05  76.8
    ## 5   32   3  12.600593    10.666667   847.9801       10685.05  80.4
    ## 6   17   2  10.001097     8.595755  1068.3880       10685.05  84.4
    ## 7    8   1   9.261000     8.000000  1153.7688       10685.05  85.7
    ## 8   13   2   7.350461     6.446816  1453.6575       10685.05  89.7
    ## 9   19   3   7.293340     6.400000  1465.0425       10685.05  89.8
    ## 10  16   3   6.000282     5.333333  1780.7583       10685.05  93.2
    ## 11  26   5   5.788727     5.157453  1845.8379       10685.05  93.8
    ## 12  23   5   5.087595     4.571429  2100.2167       10685.05  96.1
    ## 13  13   3   4.762427     4.297877  2243.6148       10685.05  97.2
    ## 14   4   1   4.410000     4.000000  2422.9144       10685.05  98.5
    ## 15  11   3   4.038027     3.683895  2646.1072       10685.05 100.1
    ## 16  18   5   3.887635     3.555555  2748.4712       10685.05 100.7
    ## 17  13   4   3.500219     3.223408  3052.6808       10685.05 102.5
    ## 18  16   5   3.473019     3.200000  3076.5893       10685.05 102.7
    ## 19  17   6   3.085618     2.865252  3462.8567       10685.05 104.7
    ## 20  13   5   2.756537     2.578726  3876.2596       10685.05 106.7

``` r
dens = M3$ratios_high[[1]]$den %>% unique %>% sort
tibble::tibble_row(
  unique_denominators = paste(dens, collapse=' '),
  relative_period_length  = lcm(dens) %>% as.integer,
  log2=log2(relative_period_length),
  consonance_above=ZARLINO-log2
)
```

    ## # A tibble: 1 × 4
    ##   unique_denominators relative_period_length  log2 consonance_above
    ##   <chr>                                <int> <dbl>            <dbl>
    ## 1 1 2 3 4 5 6                             60  5.91             64.8

### Minor Third

``` r
m3 = hrep::sparse_fr_spectrum(c(60,63), num_harmonics=10, octave_ratio=2.1) %>%
  mami.codi(verbose=T)
```

``` r
m3$ratios_low[[1]] %>%
  dplyr::arrange(pitch_freq) %>% 
  dplyr::mutate(midi=round(hrep::freq_to_midi(pitch_freq),1))
```

    ##    num den freq_ratio pseudo_ratio pitch_freq reference_freq  midi
    ## 1    1   1   1.000000     1.000000   261.6256       261.6256  60.0
    ## 2    7   6   1.189207     1.175733   311.1270       261.6256  63.0
    ## 3    2   1   2.100000     2.000000   549.4137       261.6256  72.8
    ## 4    7   3   2.497335     2.351465   653.3667       261.6256  75.8
    ## 5    3   1   3.241197     3.000000   847.9801       261.6256  80.4
    ## 6    7   2   3.854455     3.527197  1008.4240       261.6256  83.4
    ## 7    4   1   4.410000     4.000000  1153.7688       261.6256  85.7
    ## 8   14   3   5.244403     4.702930  1372.0700       261.6256  88.7
    ## 9    5   1   5.599768     5.000000  1465.0425       261.6256  89.8
    ## 10  29   5   6.659284     5.878663  1742.2390       261.6256  92.8
    ## 11   6   1   6.806515     6.000000  1780.7583       261.6256  93.2
    ## 12   7   1   8.027567     7.000000  2100.2167       261.6256  96.1
    ## 13   7   1   8.094356     7.054395  2117.6904       261.6256  96.2
    ## 14   8   1   9.261000     8.000000  2422.9144       261.6256  98.5
    ## 15  25   3   9.546439     8.230128  2497.5926       261.6256  99.1
    ## 16   9   1  10.505362     9.000000  2748.4712       261.6256 100.7
    ## 17  19   2  11.013247     9.405860  2881.3470       261.6256 101.5
    ## 18  10   1  11.759513    10.000000  3076.5893       261.6256 102.7
    ## 19  21   2  12.493051    10.581593  3268.5015       261.6256 103.7
    ## 20  35   3  13.984497    11.757325  3658.7018       261.6256 105.7

``` r
dens = m3$ratios_low[[1]]$den %>% unique %>% sort
tibble::tibble_row(
  unique_denominators = paste(dens, collapse=' '),
  relative_period_length  = lcm(dens) %>% as.integer,
  log2=log2(relative_period_length),
  consonance_below=ZARLINO-log2
)
```

    ## # A tibble: 1 × 4
    ##   unique_denominators relative_period_length  log2 consonance_below
    ##   <chr>                                <int> <dbl>            <dbl>
    ## 1 1 2 3 5 6                               30  4.91             65.8

``` r
m3$ratios_high[[1]] %>%
  dplyr::arrange(pitch_freq) %>% 
  dplyr::mutate(midi=round(hrep::freq_to_midi(pitch_freq),2))
```

    ##    num den freq_ratio pseudo_ratio pitch_freq reference_freq   midi
    ## 1   32   1  40.841010    32.000000   261.6256       10685.05  60.00
    ## 2   27   1  34.343059    27.217075   311.1270       10685.05  63.00
    ## 3   16   1  19.448100    16.000000   549.4137       10685.05  72.84
    ## 4   27   2  16.353838    13.608537   653.3667       10685.05  75.84
    ## 5   32   3  12.600593    10.666667   847.9801       10685.05  80.36
    ## 6    9   1  10.595793     9.072358  1008.4240       10685.05  83.36
    ## 7    8   1   9.261000     8.000000  1153.7688       10685.05  85.69
    ## 8   27   4   7.787542     6.804269  1372.0700       10685.05  88.69
    ## 9   19   3   7.293340     6.400000  1465.0425       10685.05  89.82
    ## 10  11   2   6.132943     5.443415  1742.2390       10685.05  92.82
    ## 11  16   3   6.000282     5.333333  1780.7583       10685.05  93.20
    ## 12  23   5   5.087595     4.571429  2100.2167       10685.05  96.06
    ## 13   9   2   5.045616     4.536179  2117.6904       10685.05  96.20
    ## 14   4   1   4.410000     4.000000  2422.9144       10685.05  98.53
    ## 15  23   6   4.278141     3.888154  2497.5926       10685.05  99.06
    ## 16  18   5   3.887635     3.555555  2748.4712       10685.05 100.72
    ## 17  17   5   3.708353     3.402134  2881.3470       10685.05 101.53
    ## 18  16   5   3.473019     3.200000  3076.5893       10685.05 102.67
    ## 19   3   1   3.269098     3.024119  3268.5015       10685.05 103.72
    ## 20  11   4   2.920449     2.721707  3658.7018       10685.05 105.67

``` r
dens = m3$ratios_high[[1]]$den %>% unique %>% sort
tibble::tibble_row(
  unique_denominators = paste(dens, collapse=' '),
  relative_period_length  = lcm(dens) %>% as.integer,
  log2=log2(relative_period_length),
  consonance_above=ZARLINO-log2
)
```

    ## # A tibble: 1 × 4
    ##   unique_denominators relative_period_length  log2 consonance_above
    ##   <chr>                                <int> <dbl>            <dbl>
    ## 1 1 2 3 4 5 6                             60  5.91             64.8

## P1 Stretched, Harmonic and Compressed

``` r
P1_stretched = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=2.1) %>%
  mami.codi(verbose=T)
P1_harmonic = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=2.0) %>%
  mami.codi(verbose=T)
P1_compressed = hrep::sparse_fr_spectrum(60, num_harmonics=10, octave_ratio=1.9) %>%
  mami.codi(verbose=T)
```

    ## # A tibble: 3 × 3
    ##   pseudo_octave major_minor consonance_dissonance
    ##           <dbl>       <dbl>                 <dbl>
    ## 1           2.1           0                  97.3
    ## 2           2             0                  97.3
    ## 3           1.9           0                  97.3
