Standard Deviation Search
================

# minor6

time Standard Deviations:

    #>  [1] 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.010 0.020 0.030
    #> [13] 0.040 0.050 0.060 0.070 0.080 0.090 0.100 0.200 0.300 0.400 0.500 0.600
    #> [25] 0.700 0.800 0.900 1.000

space Standard Deviations:

    #>  [1] 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.010 0.020 0.030
    #> [13] 0.040 0.050 0.060 0.070 0.080 0.090 0.100 0.200 0.300 0.400 0.500 0.600
    #> [25] 0.700 0.800 0.900 1.000

Number of Harmonics:

    #> [1] 10

Octave Ratios:

    #> [1] 2

## CoDi

``` r
if (search_label == 'minor3' || search_label == 'minor6') {
  experimental_data = NULL
} else {
  experimental_data = experiment
}
```

### Cartesian Coordinates

![](../figures/standard_deviation_search/_CoDi-1.png)<!-- -->

### Polar Coordinates

![](../figures/standard_deviation_search/_Polar_CoDi-1.png)<!-- -->

## Space and Time

![](../figures/standard_deviation_search/_Spacetime-1.png)<!-- -->
