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

    ##   num den   ratio pseudo_ratio      freq reference harmonic_number
    ## 1   1   1 1.00000      1.00000  261.6256  261.6256               1
    ## 2   4   3 1.33484      1.33484  349.2282  261.6256               1
    ## 3   2   1 2.00000      2.00000  523.2511  261.6256               1
    ## 4   8   3 2.66968      2.66968  698.4565  261.6256               1
    ## 5   4   1 4.00000      4.00000 1046.5023  261.6256               1

    ## [1] 1 3

    ## [1] 3

#### Wavelength

    ##   num den     ratio pseudo_ratio wavelength reference harmonic_number
    ## 1   4   1 0.2500000    0.2500000  1.3110340  1.311034            0.25
    ## 2   3   1 0.3337100    0.3337100  0.9821657  1.311034            0.25
    ## 3   2   1 0.5000000    0.5000000  0.6555170  1.311034            0.25
    ## 4   3   2 0.6674199    0.6674199  0.4910829  1.311034            0.25
    ## 5   1   1 1.0000000    1.0000000  0.3277585  1.311034            0.25

    ## [1] 1 2

    ## [1] 2
