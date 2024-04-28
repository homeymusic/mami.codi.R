Working Through Wavelength Ratios
================

``` r
chord = c(60, 69, 72) %>% mami.codi(verbose=T, num_harmonics=2)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  96.1        1.64

#### Frequency

    ##   num den    ratio pseudo_ratio      freq reference harmonic_number
    ## 1   1   1 1.000000     1.000000  261.6256  261.6256               1
    ## 2   5   3 1.681793     1.681793  440.0000  261.6256               1
    ## 3   2   1 2.000000     2.000000  523.2511  261.6256               1
    ## 4  10   3 3.363586     3.363586  880.0000  261.6256               1
    ## 5   4   1 4.000000     4.000000 1046.5023  261.6256               1
    ##   octave_spans octave_factor
    ## 1            0             0
    ## 2            0             0
    ## 3            0             0
    ## 4            0             0
    ## 5            0             0

    ## [1] 1 3

    ## [1] 3

#### Wavelength

    ##   num den    ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   1   1 1.000000     1.000000  0.3277585 0.3277585               1
    ## 2   6   5 1.189207     1.189207  0.3897727 0.3277585               1
    ## 3   2   1 2.000000     2.000000  0.6555170 0.3277585               1
    ## 4   7   3 2.378414     2.378414  0.7795455 0.3277585               1
    ## 5   4   1 4.000000     4.000000  1.3110340 0.3277585               1
    ##   octave_spans octave_factor
    ## 1            0             0
    ## 2            0             0
    ## 3            0             0
    ## 4            0             0
    ## 5            0             0

    ## [1] 1 3 5

    ## [1] 15
