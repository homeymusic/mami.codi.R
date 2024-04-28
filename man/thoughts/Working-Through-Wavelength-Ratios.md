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
    ## 3   2   1 2.000000     2.000000  523.2511  261.6256               1
    ## 4   3   1 2.996614     2.996614  783.9909  261.6256               1
    ## 5   4   1 4.000000     4.000000 1046.5023  261.6256               1

    ## [1] 1 2

    ## [1] 2

#### Wavelength

    ##   num den     ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   4   1 0.2500000    0.2500000  1.3110340  1.311034            0.25
    ## 2   8   3 0.3745768    0.3745768  0.8750102  1.311034            0.25
    ## 3   2   1 0.5000000    0.5000000  0.6555170  1.311034            0.25
    ## 4   4   3 0.7491535    0.7491535  0.4375051  1.311034            0.25
    ## 5   1   1 1.0000000    1.0000000  0.3277585  1.311034            0.25

    ## [1] 1 3

    ## [1] 3
