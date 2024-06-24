Cochlea
================

``` r
midi=24
plot_fundamental_wavelength(midi)
```

![](../figures/Cochlea-unnamed-chunk-2-1.png)<!-- -->

``` r
C1 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C1 %>% plot(cochlea =T,ggplot=T,xlim=c(0,100))
```

![](../figures/Cochlea-unnamed-chunk-3-1.png)<!-- -->

``` r
C1 %>% hrep::wave(length_sec=time) %>% plot(ggplot=T)
```

![](../figures/Cochlea-unnamed-chunk-4-1.png)<!-- -->

``` r
C1 %>% plot(ggplot=T)
```

![](../figures/Cochlea-unnamed-chunk-5-1.png)<!-- -->

``` r
midi=60
plot_fundamental_wavelength(midi)
```

![](../figures/Cochlea-unnamed-chunk-6-1.png)<!-- -->

``` r
C4 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C4 %>% plot(cochlea =T,ggplot=T,xlim=c(0,100))
```

![](../figures/Cochlea-unnamed-chunk-7-1.png)<!-- -->

``` r
C4 %>% hrep::wave(length_sec=time) %>% plot(ggplot=T)
```

![](../figures/Cochlea-unnamed-chunk-8-1.png)<!-- -->

``` r
C4 %>% plot(ggplot=T)
```

![](../figures/Cochlea-unnamed-chunk-9-1.png)<!-- -->

``` r
midi=96
plot_fundamental_wavelength(midi)
```

![](../figures/Cochlea-unnamed-chunk-10-1.png)<!-- -->

![](../figures/Cochlea-unnamed-chunk-11-1.png)<!-- -->

``` r
C7 %>% hrep::wave(length_sec=time) %>% plot(ggplot=T)
```

![](../figures/Cochlea-unnamed-chunk-12-1.png)<!-- -->

![](../figures/Cochlea-unnamed-chunk-13-1.png)<!-- -->
