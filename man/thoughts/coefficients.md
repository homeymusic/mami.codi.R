Coefficients
================

``` r
f0           = hrep::midi_to_freq(60)
max_harmonic = 13
λ_max        = SPEED_OF_SOUND / (f0 * max_harmonic)
λ_min        = λ_max * max_harmonic
```

``` r
tibble::tibble(
  harmonic = 1:max_harmonic,
  f        = .data$harmonic * f0,
  f_inv    = SPEED_OF_SOUND / f,
  λ        =  λ_min / harmonic
)
#> # A tibble: 13 × 4
#>    harmonic     f f_inv     λ
#>       <int> <dbl> <dbl> <dbl>
#>  1        1  262. 1.31  1.31 
#>  2        2  523. 0.656 0.656
#>  3        3  785. 0.437 0.437
#>  4        4 1047. 0.328 0.328
#>  5        5 1308. 0.262 0.262
#>  6        6 1570. 0.219 0.219
#>  7        7 1831. 0.187 0.187
#>  8        8 2093. 0.164 0.164
#>  9        9 2355. 0.146 0.146
#> 10       10 2616. 0.131 0.131
#> 11       11 2878. 0.119 0.119
#> 12       12 3140. 0.109 0.109
#> 13       13 3401. 0.101 0.101
```
