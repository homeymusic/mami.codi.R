Working Through Wavelength Ratios
================

``` r
chord = c(60, 65, 72) %>% mami.codi(verbose=T, num_harmonics=2)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  98.2      -0.414

#### Frequency

    ##   num den   ratio pseudo_ratio      freq reference harmonic_number octave_spans
    ## 1   1   1 1.00000      1.00000  261.6256  261.6256               1            0
    ## 2   4   3 1.33484      1.33484  349.2282  261.6256               1            0
    ## 3   2   1 1.00000      1.00000  523.2511  261.6256               1            1
    ## 4   8   3 1.33484      1.33484  698.4565  261.6256               1            1
    ## 5   4   1 1.00000      1.00000 1046.5023  261.6256               1            2
    ##   octave_factor
    ## 1             1
    ## 2             1
    ## 3             2
    ## 4             2
    ## 5             4

    ## [1] 1 3

    ## [1] 3

#### Wavelength

    ##   num den    ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   1   1 1.000000     1.000000  0.3277585 0.3277585               1
    ## 2   3   2 1.498307     1.498307  0.4910829 0.3277585               1
    ## 3   2   1 1.000000     1.000000  0.6555170 0.3277585               1
    ## 4   6   2 1.498307     1.498307  0.9821657 0.3277585               1
    ## 5   4   1 1.000000     1.000000  1.3110340 0.3277585               1
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 2

    ## [1] 2
