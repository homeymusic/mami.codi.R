Greatest Common Divisor
================

## Generalized GCD Precision

Maybe we evaluate stern brocot approximation with these limits:  

lower_bound = pow(2.0, log(freq_ratio) / log(1.89))  

upper_bound = pow(2.0, log(freq_ratio) / log(2.11))  

## P1

    #>  [1]  261.6256  523.2511  784.8767 1046.5023 1308.1278 1569.7534 1831.3790
    #>  [8] 2093.0045 2354.6301 2616.2556

``` r
f0 = gcd(f, p)$gcd
f0
#> [1] 0.01666667
```

``` r
f0 / min(f)
#> [1] 6.370427e-05
```

``` r
gcd(f/min(f), p)
#> # A tibble: 1 × 4
#>   gcd_num lcm_den   gcd fractions    
#>     <dbl>   <dbl> <dbl> <list>       
#> 1       1       1     1 <df [10 × 5]>
```

## M3

    #>  [1]  261.6256  329.6276  523.2511  659.2551  784.8767  988.8827 1046.5023
    #>  [8] 1308.1278 1318.5102 1569.7534 1648.1378 1831.3790 1977.7653 2093.0045
    #> [15] 2307.3929 2354.6301 2616.2556 2637.0205 2966.6480 3296.2755

``` r
f0 = gcd(f, p)$gcd
f0
#> [1] 0.01666667
```

``` r
f0 / min(f)
#> [1] 6.370427e-05
```

``` r
gcd(f/min(f), p)
#> # A tibble: 1 × 4
#>   gcd_num lcm_den    gcd fractions    
#>     <dbl>   <dbl>  <dbl> <list>       
#> 1       1      84 0.0119 <df [20 × 5]>
```
