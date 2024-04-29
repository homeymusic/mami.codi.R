Working Through Wavelength Ratios
================

``` r
chord = c(60, 72) %>% mami.codi(verbose=T, num_harmonics=4)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  98.2       0.414

#### Frequency

    ##   num den ratio pseudo_ratio      freq reference harmonic_number octave_spans
    ## 1   1   1   1.0          1.0  261.6256  261.6256               1            0
    ## 2   2   1   1.0          1.0  523.2511  261.6256               1            1
    ## 3   6   2   1.5          1.5  784.8767  261.6256               1            1
    ## 4   4   1   1.0          1.0 1046.5023  261.6256               1            2
    ## 5  12   2   1.5          1.5 1569.7534  261.6256               1            2
    ## 6   8   1   1.0          1.0 2093.0045  261.6256               1            3
    ##   octave_factor
    ## 1             1
    ## 2             2
    ## 3             2
    ## 4             4
    ## 5             4
    ## 6             8

    ## [1] 1 2

    ## [1] 2

#### Wavelength

    ##   num den    ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   8   1 2.000000     2.000000  0.1638792 0.1638792           0.125
    ## 2   8   3 1.333333     1.333333  0.2185057 0.1638792           0.125
    ## 3   4   1 2.000000     2.000000  0.3277585 0.1638792           0.125
    ## 4   4   3 1.333333     1.333333  0.4370113 0.1638792           0.125
    ## 5   2   1 2.000000     2.000000  0.6555170 0.1638792           0.125
    ## 6   1   1 2.000000     2.000000  1.3110340 0.1638792           0.125
    ##   octave_spans octave_factor
    ## 1            3             8
    ## 2            2             4
    ## 3            2             4
    ## 4            1             2
    ## 5            1             2
    ## 6            0             1

    ## [1] 1 3

    ## [1] 3
