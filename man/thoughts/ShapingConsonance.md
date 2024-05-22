Shaping Consonance
================

``` r
chords$spatial_consonance = log2(chords$spatial_consonance+1)
print(plot_semitone_spatial(chords, 'Spatial'))
```

![](../figures/GCD-unnamed-chunk-4-1.svg)<!-- -->

``` r
chords$temporal_consonance = log2(chords$temporal_consonance+1)
print(plot_semitone_temporal(chords, 'Temporal'))
```

![](../figures/GCD-unnamed-chunk-5-1.svg)<!-- -->
