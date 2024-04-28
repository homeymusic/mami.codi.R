Working Through Wavelength Ratios
================

``` r
chord = c(60, 63, 72) %>% mami.codi(verbose=T, num_harmonics=2)
```

    ## # A tibble: 1 × 2
    ##   consonance_dissonance major_minor
    ##                   <dbl>       <dbl>
    ## 1                  95.5        1.64

#### Frequency

    ##   num den    ratio pseudo_ratio      freq reference harmonic_number
    ## 1   4   1 4.000000     4.000000  261.6256  261.6256               4
    ## 2  19   4 4.756828     4.756828  311.1270  261.6256               4
    ## 3   8   1 4.000000     4.000000  523.2511  261.6256               4
    ## 4  38   4 4.756828     4.756828  622.2540  261.6256               4
    ## 5  16   1 4.000000     4.000000 1046.5023  261.6256               4
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 1 4

    ## [1] 4

#### Wavelength

    ##   num den     ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   1   4 0.2500000    0.2500000  0.3277585 0.3277585            0.25
    ## 2   2   5 0.4204482    0.4204482  0.5512219 0.3277585            0.25
    ## 3   2   4 0.2500000    0.2500000  0.6555170 0.3277585            0.25
    ## 4   4   5 0.4204482    0.4204482  1.1024438 0.3277585            0.25
    ## 5   4   4 0.2500000    0.2500000  1.3110340 0.3277585            0.25
    ##   octave_spans octave_factor
    ## 1            0             1
    ## 2            0             1
    ## 3            1             2
    ## 4            1             2
    ## 5            2             4

    ## [1] 4 5

    ## [1] 20
