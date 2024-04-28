Harmonic Number Wavelengths
================

``` r
tibble::tibble(
  h = (12-1:11) %>% sort(),
  λ = SPEED_OF_SOUND / hrep::midi_to_freq(60) / .data$h
)
```

    ## # A tibble: 11 × 2
    ##        h     λ
    ##    <dbl> <dbl>
    ##  1     1 1.31 
    ##  2     2 0.656
    ##  3     3 0.437
    ##  4     4 0.328
    ##  5     5 0.262
    ##  6     6 0.219
    ##  7     7 0.187
    ##  8     8 0.164
    ##  9     9 0.146
    ## 10    10 0.131
    ## 11    11 0.119

``` r
t = tibble::tibble(
  tolerance = 0.01,
  ratio = 0.6555170 / 0.1191849 / 11,
  rounded = round(.data$ratio / (tolerance * 10)) * (tolerance * 10),
  fraction = list(rational_fraction(rounded, .data$tolerance)),
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2]
)
t
```

    ## # A tibble: 1 × 6
    ##   tolerance ratio rounded fraction    num   den
    ##       <dbl> <dbl>   <dbl> <list>    <dbl> <dbl>
    ## 1      0.01 0.500     0.5 <dbl [2]>     1     2

``` r
t$fraction
```

    ## [[1]]
    ## [1] 1 2

``` r
t = tibble::tibble(
  tolerance = 0.01,
  ratio = 0.4370113 / 0.1191849 / 11,
  # rounded = round(.data$ratio / (tolerance * 10)) * (tolerance * 10),
  rounded = .data$ratio,
  fraction = list(rational_fraction(rounded, .data$tolerance)),
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2]
)
t
```

    ## # A tibble: 1 × 6
    ##   tolerance ratio rounded fraction    num   den
    ##       <dbl> <dbl>   <dbl> <list>    <dbl> <dbl>
    ## 1      0.01 0.333   0.333 <dbl [2]>     1     3

``` r
t$fraction
```

    ## [[1]]
    ## [1] 1 3

``` r
rational_fraction(1/3, 0.00001)
```

    ## [1] 1 3
