Harmonic Number Wavelengths
================

### JT Ratios

1.00000: Unison 1/1 1.06667: minor 2nd 16/15 1.12500: Major 2nd 9/8
1.20000: minor 3rd 6/5 1.25000: Major 3rd 5/4 1.33333: Perfect 4th 4/3
1.40625: Tritone 45/32 1.50000: Perfect 5th 3/2 1.60000: minor 6th 8/5
1.66667: Major 6th 5/3 1.80000: minor 7th 9/5 1.87500: Major 7th 15/8
2.00000: Octave 2/1

### P4 Wavelengths 2 Harmonics

``` r
ref = 1.311034
λ = 0.9821657
harmonic_num = 1 / 4
octave_span = floor(log(ref/λ) / log(2)) + 1
octave_factor = 2^octave_span
t = tibble::tibble(
  
  
  ratio = (ref  / (λ)) * harmonic_num,
  
  pseudo_ratio = (1 / .data$ratio) / octave_factor,
  
  fraction = list(rational_fraction(pseudo_ratio, WAVELENGTH_TOLERANCE)),
  
  
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2],
  just_P5 = 3 / 2,
  et_P5 = 2^(7/12),
  pre = ref / λ,
  pre_harm = (1 / (ref / λ * harmonic_num)) / 2,
  pseudo_raw = 1 / .data$pre,
  raw_ratio = list(rational_fraction(1 / .data$pseudo_raw, WAVELENGTH_TOLERANCE)),
  raw_num = .data$raw_ratio[[1]][1],
  raw_den = .data$raw_ratio[[1]][2],
  λ,
  ref,
  octave_span,
  octave_factor
)
t
```

    ## # A tibble: 1 × 17
    ##   ratio pseudo_ratio fraction    num   den just_P5 et_P5   pre pre_harm
    ##   <dbl>        <dbl> <list>    <dbl> <dbl>   <dbl> <dbl> <dbl>    <dbl>
    ## 1 0.334         1.50 <dbl [2]>     3     2     1.5  1.50  1.33     1.50
    ## # ℹ 8 more variables: pseudo_raw <dbl>, raw_ratio <list>, raw_num <dbl>,
    ## #   raw_den <dbl>, λ <dbl>, ref <dbl>, octave_span <dbl>, octave_factor <dbl>

### m3 M6 Ratios

``` r
C4f  = 261.6256
Eb4f = 311.1270
A4f  = 440.0000
C5f  = 523.2511

C4w  = SPEED_OF_SOUND / C4f
Eb4w = SPEED_OF_SOUND / Eb4f
A4w  = SPEED_OF_SOUND / A4f
C5w  = SPEED_OF_SOUND / C5f

tibble::tibble(
  jm3f = 6 / 5,
  m3f  = Eb4f / C4f,
  m3w  = C4w / Eb4w,
  dM6w = A4w / C5w,
  jM6f = 5 / 3,
  dm3w = Eb4w / C5w,
  M6f  = A4f / C4f,
  M6w  = C4w / A4w,
  C4f,
  Eb4f,
  A4f,
  C5f,
  C4w,
  Eb4w,
  A4w,
  C5w
)
```

    ## # A tibble: 1 × 16
    ##    jm3f   m3f   m3w  dM6w  jM6f  dm3w   M6f   M6w   C4f  Eb4f   A4f   C5f   C4w
    ##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1   1.2  1.19  1.19  1.19  1.67  1.68  1.68  1.68  262.  311.   440  523.  1.31
    ## # ℹ 3 more variables: Eb4w <dbl>, A4w <dbl>, C5w <dbl>

### M6 Wavelengths 2 Harmonics

``` r
ref = 1.311034
λ = 0.7795455
harmonic_num = 1 / 4
octave_span = floor(log(ref/λ) / log(2))
octave_factor = 2^octave_span
t = tibble::tibble(
  ratio = ref / (λ) * harmonic_num,
  fraction = list(rational_fraction((1 / .data$ratio) / octave_factor, WAVELENGTH_TOLERANCE)),
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2],
  pre = ref / λ,
  pre_harm = (1 / (ref / λ * harmonic_num)) / 2,
  pseudo_raw = 1 / .data$pre,
  raw_ratio = list(rational_fraction(1 / .data$pseudo_raw, WAVELENGTH_TOLERANCE)),
  raw_num = .data$raw_ratio[[1]][1],
  raw_den = .data$raw_ratio[[1]][2],
  λ,
  ref,
  octave_span,
  octave_factor
)
t
```

    ## # A tibble: 1 × 14
    ##   ratio fraction   num   den   pre pre_harm pseudo_raw raw_ratio raw_num raw_den
    ##   <dbl> <list>   <dbl> <dbl> <dbl>    <dbl>      <dbl> <list>      <dbl>   <dbl>
    ## 1 0.420 <dbl>       19     8  1.68     1.19      0.595 <dbl [2]>       5       3
    ## # ℹ 4 more variables: λ <dbl>, ref <dbl>, octave_span <dbl>,
    ## #   octave_factor <dbl>

### M3 Wavelengths 2 Harmonics

``` r
ref = 1.311034
λ = 1.0405683
harmonic_num = 1 / 4
octave_span = floor(log(ref/λ) / log(2)) + 1
octave_factor = 2^octave_span
t = tibble::tibble(
  just_P5 = 3 / 2,
  et_P5 = 2^(7/12),
  pre = ref / λ,
  pre_harm = (1 / (ref / λ * harmonic_num)) / 2,
  pseudo_raw = 1 / .data$pre,
  raw_ratio = list(rational_fraction(1 / .data$pseudo_raw, WAVELENGTH_TOLERANCE)),
  raw_num = .data$raw_ratio[[1]][1],
  raw_den = .data$raw_ratio[[1]][2],
  ratio = ref / (λ) * harmonic_num,
  fraction = list(rational_fraction((1 / .data$ratio) / octave_factor, WAVELENGTH_TOLERANCE)),
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2],
  λ,
  ref,
  octave_span,
  octave_factor
)
t
```

    ## # A tibble: 1 × 16
    ##   just_P5 et_P5   pre pre_harm pseudo_raw raw_ratio raw_num raw_den ratio
    ##     <dbl> <dbl> <dbl>    <dbl>      <dbl> <list>      <dbl>   <dbl> <dbl>
    ## 1     1.5  1.50  1.26     1.59      0.794 <dbl [2]>       5       4 0.315
    ## # ℹ 7 more variables: fraction <list>, num <dbl>, den <dbl>, λ <dbl>,
    ## #   ref <dbl>, octave_span <dbl>, octave_factor <dbl>

### M3 Wavelengths

``` r
ref = 1.311034
λ = 1.0405683
harmonic_num = 1 / 6
octave_span = floor(log(ref/λ) / log(2))
octave_factor = 2^octave_span
t = tibble::tibble(
  just_m6 = 8 / 5,
  et_m6 = 2^(8/12),
  pre_harm = 1 / (ref / λ * harmonic_num),
  pre = ref / λ,
  raw = .data$pre,
  pseudo_raw = 1 / .data$raw,
  raw_ratio = list(rational_fraction(1 / .data$pseudo_raw, WAVELENGTH_TOLERANCE)),
  raw_num = .data$raw_ratio[[1]][1],
  raw_den = .data$raw_ratio[[1]][2],
  ratio = ref / (λ * octave_factor) * harmonic_num,
  fraction = list(rational_fraction(1 / .data$ratio, WAVELENGTH_TOLERANCE)),
  num = .data$fraction[[1]][1] * octave_factor,
  den = .data$fraction[[1]][2],
  λ,
  ref,
  octave_span,
  octave_factor
)
t
```

    ## # A tibble: 1 × 17
    ##   just_m6 et_m6 pre_harm   pre   raw pseudo_raw raw_ratio raw_num raw_den ratio
    ##     <dbl> <dbl>    <dbl> <dbl> <dbl>      <dbl> <list>      <dbl>   <dbl> <dbl>
    ## 1     1.6  1.59     4.76  1.26  1.26      0.794 <dbl [2]>       5       4 0.210
    ## # ℹ 7 more variables: fraction <list>, num <dbl>, den <dbl>, λ <dbl>,
    ## #   ref <dbl>, octave_span <dbl>, octave_factor <dbl>

### Frequencies

``` r
ref = 261.6256
f = 1245.9141
octave_span = floor(log(f/ref) / log(2))
octave_factor = 2^octave_span
harmonic_num = 1
t = tibble::tibble(
  ratio = ( f / octave_factor) / ref  * harmonic_num,
  fraction = list(rational_fraction(.data$ratio, FREQUENCY_TOLERANCE)),
  num = .data$fraction[[1]][1] * octave_factor,
  den = .data$fraction[[1]][2]
)
t
```

    ## # A tibble: 1 × 4
    ##   ratio fraction    num   den
    ##   <dbl> <list>    <dbl> <dbl>
    ## 1  1.19 <dbl [2]>    24     5

### Wavelengths

``` r
ref = 1.311034
λ = 0.4129498
harmonic_num = 1 / 6
octave_span = floor(log(ref/λ) / log(2))
octave_factor = 2^octave_span
t = tibble::tibble(
  ratio = ref  / (λ * octave_factor) * harmonic_num,
  fraction = list(rational_fraction(1 / .data$ratio, WAVELENGTH_TOLERANCE)),
  num = .data$fraction[[1]][1] * octave_factor,
  den = .data$fraction[[1]][2],
  λ,
  ref,
  octave_span,
  octave_factor
)
t
```

    ## # A tibble: 1 × 8
    ##   ratio fraction    num   den     λ   ref octave_span octave_factor
    ##   <dbl> <list>    <dbl> <dbl> <dbl> <dbl>       <dbl>         <dbl>
    ## 1 0.265 <dbl [2]>    68     9 0.413  1.31           1             2

### Other Stuff

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

``` r
t = tibble::tibble(
  ratio = 1.311034 / 0.4370113 * 0.04545455,
  fraction = list(rational_fraction(.data$ratio, TOLERANCE)),
  num = .data$fraction[[1]][2],
  den = .data$fraction[[1]][1]
)
t
```

    ## # A tibble: 1 × 4
    ##   ratio fraction    num   den
    ##   <dbl> <list>    <dbl> <dbl>
    ## 1 0.136 <dbl [2]>     7     1

``` r
t = tibble::tibble(
  ratio = 1.311034  / 0.4129498 * 0.1666667,
  fraction = list(rational_fraction(1 / .data$ratio, WAVELENGTH_TOLERANCE)),
  num = .data$fraction[[1]][1],
  den = .data$fraction[[1]][2]
)
t
```

    ## # A tibble: 1 × 4
    ##   ratio fraction    num   den
    ##   <dbl> <list>    <dbl> <dbl>
    ## 1 0.529 <dbl [2]>    15     8
