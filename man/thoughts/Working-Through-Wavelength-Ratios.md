Working Through Wavelength Ratios
================

``` r
chord = c(60, 67, 72) %>% mami.codi(verbose=T, num_harmonics=2)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  98.2       0.414

#### Frequency

    ##   num den    ratio pseudo_ratio      freq reference harmonic_number
    ## 1   1   1 1.000000     1.000000  261.6256  261.6256               1
    ## 2   3   2 1.498307     1.498307  391.9954  261.6256               1
    ## 3   2   1 1.000000     1.000000  523.2511  261.6256               1
    ## 4   6   2 1.498307     1.498307  783.9909  261.6256               1
    ## 5   4   1 1.000000     1.000000 1046.5023  261.6256               1
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 2

    ## [1] 2

#### Wavelength

    ##   num den     ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   4   1 0.2500000      4.00000  1.3110340  1.311034            0.25
    ## 2   8   3 0.3745768      2.66968  0.8750102  1.311034            0.25
    ## 3   8   1 0.2500000      4.00000  0.6555170  1.311034            0.25
    ## 4  16   3 0.3745768      2.66968  0.4375051  1.311034            0.25
    ## 5  16   1 0.2500000      4.00000  0.3277585  1.311034            0.25
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 3

    ## [1] 3
