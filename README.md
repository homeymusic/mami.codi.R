MaMi.CoDi: A Spatiotemporal Periodicity Model of Consonance Perception
================

## How MaMi.CoDi Works

### Finding the Tolerance Values

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given tolerance. How do we find the best tolerance
values? For the MaMi.CoDi model we ran thousands of computations with
various tolerance values and compared the predictions with results from
six of the large-scale behavioral experiments.  

The best fits across the experiments were given by a tolerance of
0.08.  

The frequency tolerance is half the size of the wavelength tolerance.
Does that mean that the perception mechanism for frequency.  

## Theoretical predictions compared to large-scale behavioral results

The large-scale behavioral data in the plots below are from [Timbral
effects on consonance disentangle psychoacoustic mechanisms and suggest
perceptual origins for musical
scales](https://www.nature.com/articles/s41467-024-45812-z) by Raja
Marjieh, Peter M. C. Harrison, Harin Lee, Fotini Deligiannaki & Nori
Jacoby.

### Manipulating harmonic frequencies

#### Dyads spanning 15 semitones

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-5.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-10.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-12.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-15.png)<!-- -->

##### Pure ~ Partials: 1

For pure tones, the behavioral results and the theoretical predictions
mostly agree. Only P5 and P8 have pronounced two-sided peaks. The
behavioral results show subtle variations in consonance height across
the 15 semitones but the overall peak structure agrees with MaMi.CoDi
predictions. For futher comparison, the theoretical predictions for
major-minor versus the behavioral results are included in a plot below.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-18.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-20.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2.1                    | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-24.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-25.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 1.9                    | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-30.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 0.05              | 0.08               |             0.2 |

![](man/figures/README-unnamed-chunk-4-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-35.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 1e-04             | 1e-04              |           0.035 |

![](man/figures/README-unnamed-chunk-4-36.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-40.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 1e-04             | 1e-04              |           0.035 |

![](man/figures/README-unnamed-chunk-4-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-42.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-44.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-45.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:------------------|:-------------------|----------------:|
| 2                      | 0.03                    | 1e-04             | 1e-04              |           0.035 |

![](man/figures/README-unnamed-chunk-4-46.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-47.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-48.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-49.png)<!-- -->  
![](man/figures/README-unnamed-chunk-4-50.png)<!-- -->

### TODO: run the in-depth tolerance searches again for M3, M6 and P8

#### Notes on plots:

In the plots above:

- The cream lines are smoothed experimental data from Marjieh, Harrison
  et al.

- The multi-colored points are MaMi.CoDi computational predictions

- The multi-colored lines are smoothed MaMi.CoDi computational
  predictions

- The colors represent MaMi.CoDi computational predictions for
  major-minor polarity:

- Gold is major

- Red is neutral

- Blue is minor

- The vertical axis is z-scored consonance-dissonance

- The horizontal axis is the width of the dyad from 0 to 15 semitones

- For example, the data at 4 represents the equal tempered major third,
  M3

- While the data at 8 represents the equal tempered minor sixth, m6
