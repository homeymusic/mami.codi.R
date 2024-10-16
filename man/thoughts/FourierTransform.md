Fourier Transform
================

``` r
f = c(1, 2-1i, -1i, -1+2i)
fft_slow(f)
#> [1]  2+0i -2-2i  0-2i  4+4i
```

``` r
c_sound = 343
chord = tibble::tibble(
  f = 100*1:10,
  w = 2 * pi * f,
  l = c_sound / f,
  k = (2 * pi) / l
)
chord
#> # A tibble: 10 × 4
#>        f     w     l     k
#>    <dbl> <dbl> <dbl> <dbl>
#>  1   100  628. 3.43   1.83
#>  2   200 1257. 1.72   3.66
#>  3   300 1885. 1.14   5.50
#>  4   400 2513. 0.858  7.33
#>  5   500 3142. 0.686  9.16
#>  6   600 3770. 0.572 11.0 
#>  7   700 4398. 0.49  12.8 
#>  8   800 5027. 0.429 14.7 
#>  9   900 5655. 0.381 16.5 
#> 10  1000 6283. 0.343 18.3
```

``` r
fft_wk(chord$w, chord$k, inverse=F)
#>  [1]  3.9894228+0.0000000i -0.8130237-0.3778951i -0.9958107+0.1443733i
#>  [4]  0.8448118+1.6145177i  1.4361388-1.6463718i -0.5252498-0.9226724i
#>  [7] -0.2992071+1.6165278i  2.1976949-0.3961052i  0.9427283+0.0914856i
#> [10] -2.5405680-0.2248090i
```

``` r
fft_wk(chord$w, chord$k, inverse=T)
#>  [1]  3.9894228+0.0000000i -0.8130237+0.3778951i -0.9958107-0.1443733i
#>  [4]  0.8448118-1.6145177i  1.4361388+1.6463718i -0.5252498+0.9226724i
#>  [7] -0.2992071-1.6165278i  2.1976949+0.3961052i  0.9427283-0.0914856i
#> [10] -2.5405680+0.2248090i
```
