Domain
================

``` r
P5 = c(60, 67) %>% mami.codi(num_harmonics = 1, verbose=T)
P5 %>% tidyr::unnest(cols=c('frequencies', 'periods', 'wavenumbers', 'wavelengths'))
#> # A tibble: 2 × 21
#>   spectrum   temporal_cycles temporal_fractions spatial_cycles spatial_fractions
#>   <list>               <dbl> <list>                      <dbl> <list>           
#> 1 <sprs_fr_>               2 <df [2 × 8]>                    2 <df [2 × 8]>     
#> 2 <sprs_fr_>               2 <df [2 × 8]>                    2 <df [2 × 8]>     
#> # ℹ 16 more variables: log2_temporal_cycles <dbl>, log2_spatial_cycles <dbl>,
#> #   dissonance <dbl>, majorness <dbl>, fundamental_frequency <dbl>,
#> #   fundamental_wavelength <dbl>, frequencies <dbl>, periods <dbl>,
#> #   wavenumbers <dbl>, wavelengths <dbl>, speed_of_sound <dbl>,
#> #   minimum_amplitude <dbl>, temporal_standard_deviation <dbl>,
#> #   spatial_standard_deviation <dbl>, harmonics_deviation <dbl>,
#> #   metadata <list>
```
