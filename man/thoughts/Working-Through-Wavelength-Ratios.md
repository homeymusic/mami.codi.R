Working Through Wavelength Ratios
================

``` r
chord = c(60, 63, 72) %>% mami.codi(verbose=T, num_harmonics=2)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  97.2      -0.521

#### Frequency

    ##   num den    ratio pseudo_ratio      freq reference harmonic_number
    ## 1   1   1 1.000000     1.000000  261.6256  261.6256               1
    ## 2   6   5 1.189207     1.189207  311.1270  261.6256               1
    ## 3   2   1 1.000000     1.000000  523.2511  261.6256               1
    ## 4  12   5 1.189207     1.189207  622.2540  261.6256               1
    ## 5   4   1 1.000000     1.000000 1046.5023  261.6256               1
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 5

    ## [1] 5

#### Wavelength

    ##   num den    ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   1   1 1.000000     1.000000  0.3277585 0.3277585               1
    ## 2   5   3 1.681793     1.681793  0.5512219 0.3277585               1
    ## 3   2   1 1.000000     1.000000  0.6555170 0.3277585               1
    ## 4  10   3 1.681793     1.681793  1.1024438 0.3277585               1
    ## 5   4   1 1.000000     1.000000  1.3110340 0.3277585               1
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 3

    ## [1] 3
