Shaping Consonance
================

``` r
chords$log2_spatial_cycles = log2(chords$log2_spatial_cycles+1)
print(plot_semitone_spatial(chords, 'Spatial'))
```

![](../figures/GCD-unnamed-chunk-4-1.svg)<!-- -->

``` r
chords$log2_temporal_cycles = log2(chords$log2_temporal_cycles+1)
print(plot_semitone_temporal(chords, 'Temporal'))
```

![](../figures/GCD-unnamed-chunk-5-1.svg)<!-- -->
