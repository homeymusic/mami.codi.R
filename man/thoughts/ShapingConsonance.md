Shaping Consonance
================

``` r
chords$period_consonance = log2(chords$period_consonance+1)
print(plot_semitone_period(chords, 'Spatial'))
```

![](../figures/GCD-unnamed-chunk-4-1.svg)<!-- -->

``` r
chords$frequency_consonance = log2(chords$frequency_consonance+1)
print(plot_semitone_frequency(chords, 'Temporal'))
```

![](../figures/GCD-unnamed-chunk-5-1.svg)<!-- -->
