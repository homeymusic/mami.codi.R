Listen for Harmonics
================

## Major 3rd

``` r
M3 = hrep::sparse_fr_spectrum(c(60,64), num_harmonics=10)
M3 %>% hrep::freq()
#>  [1]  261.6256  329.6276  523.2511  659.2551  784.8767  988.8827 1046.5023
#>  [8] 1308.1278 1318.5102 1569.7534 1648.1378 1831.3790 1977.7653 2093.0045
#> [15] 2307.3929 2354.6301 2616.2556 2637.0205 2966.6480 3296.2755
```

``` r
C4_harmonics_w_tolerance = harmonic_series_with_tolerance(60,20,DEFAULT_OCTAVE_TOLERANCE)
C4_harmonics_w_tolerance
#> # A tibble: 20 × 4
#>    harmonic harmonic_freq valid_min valid_max
#>       <int>         <dbl>     <dbl>     <dbl>
#>  1        1          262.      220       311.
#>  2        2          523.      440       622.
#>  3        3          785.      660.      933.
#>  4        4         1047.      880      1245.
#>  5        5         1308.     1100.     1556.
#>  6        6         1570.     1320.     1867.
#>  7        7         1831.     1540.     2178.
#>  8        8         2093.     1760      2489.
#>  9        9         2355.     1980.     2800.
#> 10       10         2616.     2200.     3111.
#> 11       11         2878.     2420.     3422.
#> 12       12         3140.     2640.     3734.
#> 13       13         3401.     2860.     4045.
#> 14       14         3663.     3080.     4356.
#> 15       15         3924.     3300.     4667.
#> 16       16         4186.     3520      4978.
#> 17       17         4448.     3740.     5289.
#> 18       18         4709.     3960.     5600.
#> 19       19         4971.     4180.     5911.
#> 20       20         5233.     4400.     6223.
```

``` r
matches=analyze_harmonics(hrep::freq(M3),hrep::freq(M3) %>% min,C4_harmonics_w_tolerance)
#> 
#> Attaching package: 'purrr'
#> The following object is masked from 'package:testthat':
#> 
#>     is_null
matches
#> # A tibble: 39 × 5
#>    harmonic harmonic_freq valid_min valid_max pseudo_octave
#>       <int>         <dbl>     <dbl>     <dbl>         <dbl>
#>  1        1          262.      220       311.          1   
#>  2        2          523.      440       622.          2   
#>  3        3          785.      660.      933.          2   
#>  4        4         1047.      880      1245.          1.94
#>  5        4         1047.      880      1245.          2   
#>  6        5         1308.     1100.     1556.          2   
#>  7        5         1308.     1100.     1556.          2.01
#>  8        6         1570.     1320.     1867.          2   
#>  9        7         1831.     1540.     2178.          1.89
#> 10        6         1570.     1320.     1867.          2.04
#> # ℹ 29 more rows
```

``` r
matches %>%
    dplyr::count(.data$pseudo_octave, name='num_harmonics',sort=TRUE) 
#> # A tibble: 31 × 2
#>    pseudo_octave num_harmonics
#>            <dbl>         <int>
#>  1          2                9
#>  2          1                1
#>  3          1.89             1
#>  4          1.91             1
#>  5          1.93             1
#>  6          1.93             1
#>  7          1.93             1
#>  8          1.93             1
#>  9          1.94             1
#> 10          1.94             1
#> # ℹ 21 more rows
```

## Major 3rd - Missing Fundamental-ish

``` r
M3 = hrep::sparse_fr_spectrum(c(60,64), num_harmonics=10)
M3 = M3 %>% dplyr::filter(x>300)
M3 %>% hrep::freq()
#>  [1]  329.6276  523.2511  659.2551  784.8767  988.8827 1046.5023 1308.1278
#>  [8] 1318.5102 1569.7534 1648.1378 1831.3790 1977.7653 2093.0045 2307.3929
#> [15] 2354.6301 2616.2556 2637.0205 2966.6480 3296.2755
```

``` r
C5_harmonics_w_tolerance = harmonic_series_with_tolerance(72,20,DEFAULT_OCTAVE_TOLERANCE)
C5_harmonics_w_tolerance
#> # A tibble: 20 × 4
#>    harmonic harmonic_freq valid_min valid_max
#>       <int>         <dbl>     <dbl>     <dbl>
#>  1        1          523.      440       622.
#>  2        2         1047.      880      1245.
#>  3        3         1570.     1320.     1867.
#>  4        4         2093.     1760      2489.
#>  5        5         2616.     2200.     3111.
#>  6        6         3140.     2640.     3734.
#>  7        7         3663.     3080.     4356.
#>  8        8         4186.     3520      4978.
#>  9        9         4709.     3960.     5600.
#> 10       10         5233.     4400.     6223.
#> 11       11         5756.     4840.     6845.
#> 12       12         6279.     5280.     7467.
#> 13       13         6802.     5720.     8089.
#> 14       14         7326.     6160.     8712.
#> 15       15         7849.     6600.     9334.
#> 16       16         8372.     7040      9956.
#> 17       17         8895.     7480.    10578.
#> 18       18         9419.     7920.    11201.
#> 19       19         9942.     8360.    11823.
#> 20       20        10465.     8800.    12445.
```

``` r
matches=analyze_harmonics(hrep::freq(M3),hrep::freq(M3) %>% min,C4_harmonics_w_tolerance)
matches
#> # A tibble: 38 × 5
#>    harmonic harmonic_freq valid_min valid_max pseudo_octave
#>       <int>         <dbl>     <dbl>     <dbl>         <dbl>
#>  1        2          523.      440       622.          1.59
#>  2        3          785.      660.      933.          1.73
#>  3        4         1047.      880      1245.          1.73
#>  4        4         1047.      880      1245.          1.78
#>  5        5         1308.     1100.     1556.          1.81
#>  6        5         1308.     1100.     1556.          1.82
#>  7        6         1570.     1320.     1867.          1.83
#>  8        7         1831.     1540.     2178.          1.74
#>  9        6         1570.     1320.     1867.          1.86
#> 10        7         1831.     1540.     2178.          1.77
#> # ℹ 28 more rows
```

``` r
matches %>%
    dplyr::count(.data$pseudo_octave, name='num_harmonics',sort=TRUE) 
#> # A tibble: 38 × 2
#>    pseudo_octave num_harmonics
#>            <dbl>         <int>
#>  1          1.59             1
#>  2          1.73             1
#>  3          1.73             1
#>  4          1.74             1
#>  5          1.77             1
#>  6          1.77             1
#>  7          1.78             1
#>  8          1.79             1
#>  9          1.80             1
#> 10          1.81             1
#> # ℹ 28 more rows
```
