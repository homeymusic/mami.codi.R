MaMi.CoDi: A Spatiotemporal Periodicity Model of Consonance Perception
================

## How MaMi.CoDi Works

### Estimating Spatiotemporal Periodicity

To estimate the periodicity of a chord, the MaMi.CoDi model uses a
signal processing technique. It finds ratios, within a given tolerance,
for every tone in the chord (fundamental, harmonics, noise, etc.)
relative to a reference tone. The least common multiple of those ratios
is a measure of the cycle length, relative to the reference tone. Long
relative cycles are predicted to sound unpleasant and short relative
cycles are predicted to sound pleasant.  

MaMi.CoDi creates two estimates of the chord’s period: a temporal
estimate and a spatial estimate.  

For the frequency (i.e. phase-locking or temporal) estimate the
reference tone is the smallest frequency. Small frequencies are low
tones and are detected by the inner ear hair cells closest to the apex
of the cochlea, which is the end furthest from the source of the wave.  

For the wavelength (i.e. rate-place or spatial) estimate, the reference
tone is the smallest wavelength. Small wavelengths are high tones and
are detected by the inner ear hair cells closest to the base of the
cochlea, which is the end closest to the middle ear, the source of the
wave.  

MaMi.CoDi combines the two cycle estimates into a two-dimensional space
with consonance-dissonance along one dimension and major-minor on the
orthogonal dimension.

#### Chord

Below, we estimate the periodicity of the C4, E4 and G4 major triad with
5 harmonics per pitch.

- Fundamental Frequencies: 261.6255653, 329.6275569, 391.995436  

- Fundamental Wavelengths: 1.311034, 1.0405683, 0.8750102  

- MIDI: 60, 64, 67  

- Number of Harmonics: 5

#### Temporal Estimate

| chord_Hz |  chord_m |   chord_s | chord_Sz | tol |
|---------:|---------:|----------:|---------:|----:|
| 21.80213 | 15.73241 | 0.0458671 |       12 | 0.1 |

##### Periods

![](man/figures/README-unnamed-chunk-11-1.png)<!-- -->

##### Relative Periodicity

![](man/figures/README-unnamed-chunk-12-1.png)<!-- -->

#### Frequency Ratios

| index | num | den |    ratio |      tone | reference_tone |
|------:|----:|----:|---------:|----------:|---------------:|
|     1 |   1 |   1 | 1.000000 |  261.6256 |       261.6256 |
|     2 |   4 |   3 | 1.259921 |  329.6276 |       261.6256 |
|     3 |   3 |   2 | 1.498307 |  391.9954 |       261.6256 |
|     4 |   2 |   1 | 2.000000 |  523.2511 |       261.6256 |
|     5 |   5 |   2 | 2.519842 |  659.2551 |       261.6256 |
|     6 |   3 |   1 | 2.996614 |  783.9909 |       261.6256 |
|     7 |   3 |   1 | 3.000000 |  784.8767 |       261.6256 |
|     8 |  15 |   4 | 3.779763 |  988.8827 |       261.6256 |
|     9 |   4 |   1 | 4.000000 | 1046.5023 |       261.6256 |
|    10 |   9 |   2 | 4.494921 | 1175.9863 |       261.6256 |
|    11 |   5 |   1 | 5.000000 | 1308.1278 |       261.6256 |
|    12 |   5 |   1 | 5.039684 | 1318.5102 |       261.6256 |
|    13 |   6 |   1 | 5.993228 | 1567.9817 |       261.6256 |
|    14 |  19 |   3 | 6.299605 | 1648.1378 |       261.6256 |
|    15 |  15 |   2 | 7.491535 | 1959.9772 |       261.6256 |

#### Spatial Estimate

| chord_Hz |  chord_m |   chord_s | chord_Sz | tol |
|---------:|---------:|----------:|---------:|----:|
| 4.360426 | 10.50012 | 0.2293354 |       60 | 0.1 |

##### Wavenumbers

![](man/figures/README-unnamed-chunk-15-1.png)<!-- -->

##### Relative Spatial Frequency

![](man/figures/README-unnamed-chunk-16-1.png)<!-- -->

##### Wavelength Ratios

| index | num | den |    ratio |      tone | reference_tone |
|------:|----:|----:|---------:|----------:|---------------:|
|    15 |   1 |   1 | 1.000000 | 0.1750020 |       0.175002 |
|    14 |   5 |   4 | 1.189207 | 0.2081137 |       0.175002 |
|    13 |   4 |   3 | 1.250000 | 0.2187525 |       0.175002 |
|    12 |   3 |   2 | 1.486509 | 0.2601421 |       0.175002 |
|    11 |   3 |   2 | 1.498307 | 0.2622068 |       0.175002 |
|    10 |   5 |   3 | 1.666667 | 0.2916701 |       0.175002 |
|     9 |   9 |   5 | 1.872884 | 0.3277585 |       0.175002 |
|     8 |   2 |   1 | 1.982012 | 0.3468561 |       0.175002 |
|     7 |   5 |   2 | 2.497178 | 0.4370113 |       0.175002 |
|     6 |   5 |   2 | 2.500000 | 0.4375051 |       0.175002 |
|     5 |   3 |   1 | 2.973018 | 0.5202842 |       0.175002 |
|     4 |  11 |   3 | 3.745768 | 0.6555170 |       0.175002 |
|     3 |   5 |   1 | 5.000000 | 0.8750102 |       0.175002 |
|     2 |   6 |   1 | 5.946035 | 1.0405683 |       0.175002 |
|     1 |  15 |   2 | 7.491535 | 1.3110340 |       0.175002 |

### Finding the Tolerance Values

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given tolerance. How do we find the best tolerance
values? For the MaMi.CoDi model we ran thousands of computations with
various tolerance values and compared the predictions with results from
six of the large-scale behavioral experiments.  

Because spatial and temporal information is encoded via different
mechanisms by the cochlea, we assumed that the wavelength and frequency
tolerances would have different values.  

So, our tolerance searches were two-dimensional. We searched for
combinations of frequency tolerance and wavelength tolerance. The image
below is a sample of a 2D tolerance search using the harmonic experiment
from large-scale behavioral study.  

![Two-dimensional tolerance search for frequency and wavelength
tolerance values for finding rational fractions for tone
ratios.](https://github.com/homeymusic/mami.codi.R/blob/2D_tolerance/man/tolerance_search_plots/Harmonic2DCropped.png?raw=true)
Click here, for the [full 2D tolerance
search](https://github.com/homeymusic/mami.codi.R/blob/2D_tolerance/man/tolerance_search_plots/Harmonic2D.jpg)
image for the harmonics experiment. Click here, for the [2D_tolerance
branch on
GitHub](https://github.com/homeymusic/mami.codi.R/tree/2D_tolerance) to
recreate all the 2D searches.  

The best fits across the experiments were given by a frequency tolerance
of 0.075 and a wavelength tolerance of 0.15. The frequency tolerance is
half the size of the wavelength tolerance. Does that mean that the
perception mechanism for frequency is twice as discriminating as the
wavelength mechanism? “At 1 kHz information contained in temporal
discharges was an order of magnitude better than that obtained by a
rate–place mechanism. Heinz et al. (2001)” from Winter (2005).  

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

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-4.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-5.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-8.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-9.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-10.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-12.png)<!-- -->

##### Pure ~ Partials: 1

For pure tones, the behavioral results and the theoretical predictions
mostly agree. Only P5 and P8 have pronounced two-sided peaks. The
behavioral results show subtle variations in consonance height across
the 15 semitones but the overall peak structure agrees with MaMi.CoDi
predictions. For futher comparison, the theoretical predictions for
major-minor versus the behavioral results are included in a plot below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-13.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-15.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-16.png)<!-- -->  
For pure tones, MaMi.CoDi’s theoretical predictions for major-minor have
similar contours to the behavioral results for
consonance-dissonance.![](man/figures/README-unnamed-chunk-5-17.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2.1                    | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-18.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-20.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-21.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 1.9                    | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-22.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-24.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-25.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.15                 | 0.075               |             0.2 |

![](man/figures/README-unnamed-chunk-5-26.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-29.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-5-30.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-33.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-5-34.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-35.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-36.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-37.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-5-38.png)<!-- -->

![](man/figures/README-unnamed-chunk-5-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-40.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-41.png)<!-- -->

### Consonance peaks in dissonance troughs

For the high-resolution dyads centered on M3, M6 and P8, the large-scale
behavioral results and the MaMi.CoDi theoretical predictions both show
dissonance troughs centered on the JT dyads.  

MaMi.CoDi, though, predicts a local maximum consonance peak at the
center of each dissonance trough.  

Secondary maximums occur at the Pythagorean third and grave major sixth.
Those secondary peaks are also surrounded by dissonance troughs. There
are also tertiary troughs near the ET intervals.  

### Theoretical consonance peak at P1 in octave-wide dissonance trough

| multicolored_line_sigma | green_line_sigma | pseudo_octave | wavelength_tolerance | frequency_tolerance |
|------------------------:|-----------------:|:--------------|:---------------------|:--------------------|
|                     0.2 |                2 | 2             | 0.15                 | 0.0375              |

![](man/figures/README-unnamed-chunk-31-1.png)<!-- -->

Performers of instruments with quantized semitones like keyboards and
fretted strings–especially beginners and their audiences–are aware that
the globally maximum consonant peak at the unison, P1, has dissonant
neighbors on both sides, M7 and m2. Consonance increases with each
semitone step out of the trough: downward from M7 to P4 below and upward
from m2 to P5 above.  

The green line in the plot above was generated using a smoothing sigma
an order of magnitude broader than the default soothing sigma, 2.0
versus 0.2. At the broader resolution, the green line highlights the
dissonance trough and ignore the consonance peak at P1.

That is, at the resolution of an octave, MaMi.CoDi predicts a global
maximum consonance peak in the center of a smoothed dissonance trough.  

At other resolutions, for example stringed instruments without frets,
the nearest playable neighbors to P1 are not necessarily dissonant.

In the harmonic study with the narrow resolution, above, the behavioral
results shows dissonance troughs and MaMi.CoDi predicts consonance peaks
in the center of those dissonance troughs.

### MaMi.CoDi resolution correlates with dissonance troughs and consonance peaks

As the tolerance value of the MaMi.CoDi model varies from very small to
very large the consonance peaks expand their width until they overcome
the dissonance troughs. See plot sets, below, for M3, M6 and P8.  

MaMi.CoDi’s tolerance value is the only parameter in the model and
indicates the resolution for turning irrational ratios into rational
fractions. Those fractions are then used to estimate wavelength
periodicity and frequency periodicity.  

- Small tolerances give more accurate fractions which give longer
  periods.
- Large tolerances give less accurate fractions which give shorter
  period estimates.

#### M3 ~ Major Third

Plot of M3 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![M3 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/M3%20Orders%20of%20Magnitude.png)

- JT: 5/4
- ET: 2^(4/12)

<!-- -->

    #> # A tibble: 1 × 4
    #>   just_M3_freq just_M3_midi M3_freq M3_midi
    #>          <dbl>        <dbl>   <dbl>   <dbl>
    #> 1         327.         63.9    330.      64

##### Intervals near the major third ranked by consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     63.8                  68.7
    #>  2     63.8                  68.7
    #>  3     63.8                  68.7
    #>  4     63.8                  68.7
    #>  5     63.8                  68.7
    #>  6     63.8                  68.7
    #>  7     63.8                  68.7
    #>  8     63.9                  68.7
    #>  9     63.9                  68.7
    #> 10     63.9                  68.7
    #> # ℹ 990 more rows

###### The JT M3 has the highest consonance

    #> [1] 63.8467

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                  68.7

###### Frequency ratios of the JT M3

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   4  1.248814     1.248814  326.7215       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   5   2  2.497627     2.497627  653.4431       261.6256
    #> 5      5   3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  15   4  3.746441     3.746441  980.1646       261.6256
    #> 7      7   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8   5   1  4.995254     4.995254 1306.8862       261.6256
    #> 9      9   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10    10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  25   4  6.244068     6.244068 1633.6077       261.6256
    #> 12    12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  15   2  7.492881     7.492881 1960.3293       261.6256
    #> 14    14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15  35   4  8.741695     8.741695 2287.0508       261.6256
    #> 16    16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  10   1  9.990508     9.990508 2613.7724       261.6256
    #> 18    18  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19    19  45   4 11.239322    11.239322 2940.4939       261.6256
    #> 20    20  25   2 12.488135    12.488135 3267.2155       261.6256

##### Intervals near the major third ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     63.7                  62.0
    #>  2     63.7                  62.0
    #>  3     63.7                  62.0
    #>  4     63.7                  62.0
    #>  5     63.7                  62.0
    #>  6     63.7                  62.0
    #>  7     63.7                  62.0
    #>  8     63.7                  62.0
    #>  9     63.7                  62.0
    #> 10     63.7                  62.0
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 63.70405

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.7                  62.0

###### The lowest consonance ratios

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   4  1.238566     1.238566  324.0406       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   5   2  2.477133     2.477133  648.0812       261.6256
    #> 5      5   3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  11   3  3.715699     3.715699  972.1219       261.6256
    #> 7      7   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8   5   1  4.954265     4.954265 1296.1625       261.6256
    #> 9      9   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10    10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  25   4  6.192832     6.192832 1620.2031       261.6256
    #> 12    12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  15   2  7.431398     7.431398 1944.2437       261.6256
    #> 14    14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15  26   3  8.669964     8.669964 2268.2844       261.6256
    #> 16    16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  69   7  9.908531     9.908531 2592.3250       261.6256
    #> 18    18  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19    19  56   5 11.147097    11.147097 2916.3656       261.6256
    #> 20    20  37   3 12.385663    12.385663 3240.4062       261.6256

###### The Pythagorean third is the second highest consonance

MIDI:

    #> [1] 63.8472

Cents:

    #> [1] 384.7197

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                  68.7

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   4  1.248850     1.248850  326.7310       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   5   2  2.497699     2.497699  653.4620       261.6256
    #> 5      5   3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  15   4  3.746549     3.746549  980.1930       261.6256
    #> 7      7   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8   5   1  4.995398     4.995398 1306.9239       261.6256
    #> 9      9   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10    10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  25   4  6.244248     6.244248 1633.6549       261.6256
    #> 12    12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  15   2  7.493098     7.493098 1960.3859       261.6256
    #> 14    14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15  35   4  8.741947     8.741947 2287.1169       261.6256
    #> 16    16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  10   1  9.990797     9.990797 2613.8479       261.6256
    #> 18    18  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19    19  45   4 11.239646    11.239646 2940.5789       261.6256
    #> 20    20  25   2 12.488496    12.488496 3267.3098       261.6256

###### References for the Pythagorean third

- “19/15 409.2443014 (good approximation of Pythagorean 3rd)”
  - from [M3 in the Encyclopedia of Microtonal Music
    Theory](http://www.tonalsoft.com/enc/m/major-3rd.aspx)
- [Pythagorean ditone](https://en.wikipedia.org/wiki/Ditone)

#### M6 ~ Major Sixth

Plot of M6 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![M6 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/M6%20Orders%20of%20Magnitude.png)

- JT: 5/3
- ET: 2^(9/12)

<!-- -->

    #> # A tibble: 1 × 4
    #>   just_M6_freq just_M6_midi M6_freq M6_midi
    #>          <dbl>        <dbl>   <dbl>   <dbl>
    #> 1         436.         68.8     440      69

##### Intervals near the major sixth ranked by consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     68.8                  69.1
    #>  2     68.8                  69.1
    #>  3     68.8                  69.1
    #>  4     68.8                  69.1
    #>  5     68.8                  69.1
    #>  6     68.8                  69.1
    #>  7     68.8                  69.1
    #>  8     68.8                  69.1
    #>  9     68.8                  69.1
    #> 10     68.8                  69.1
    #> # ℹ 990 more rows

###### The JT M6 has the highest consonance

    #> [1] 68.76562

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.8                  69.1

###### Frequency ratios of the JT M6

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   3  1.659177     1.659177  434.0832       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  10   3  3.318354     3.318354  868.1664       261.6256
    #> 6      6   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7   5   1  4.977532     4.977532 1302.2495       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  20   3  6.636709     6.636709 1736.3327       261.6256
    #> 11    11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13  25   3  8.295886     8.295886 2170.4159       261.6256
    #> 14    14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  10   1  9.955063     9.955063 2604.4991       261.6256
    #> 16    16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17    17  35   3 11.614241    11.614241 3038.5823       261.6256
    #> 18    18  40   3 13.273418    13.273418 3472.6654       261.6256
    #> 19    19  15   1 14.932595    14.932595 3906.7486       261.6256
    #> 20    20  50   3 16.591772    16.591772 4340.8318       261.6256

##### Intervals near the major sixth ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     68.7                  62.0
    #>  2     68.7                  62.0
    #>  3     68.7                  62.0
    #>  4     68.7                  62.0
    #>  5     68.7                  62.0
    #>  6     68.7                  62.0
    #>  7     68.7                  62.0
    #>  8     68.7                  62.0
    #>  9     68.7                  62.0
    #> 10     68.7                  62.0
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 68.68453

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.7                  62.0

###### The lowest consonance ratios

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   3  1.651425     1.651425  432.0549       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  10   3  3.302850     3.302850  864.1099       261.6256
    #> 6      6   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7   5   1  4.954274     4.954274 1296.1648       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  20   3  6.605699     6.605699 1728.2198       261.6256
    #> 11    11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13  33   4  8.257124     8.257124 2160.2747       261.6256
    #> 14    14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  69   7  9.908549     9.908549 2592.3296       261.6256
    #> 16    16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17    17  23   2 11.559973    11.559973 3024.3846       261.6256
    #> 18    18  53   4 13.211398    13.211398 3456.4395       261.6256
    #> 19    19  74   5 14.862823    14.862823 3888.4944       261.6256
    #> 20    20  33   2 16.514248    16.514248 4320.5494       261.6256

###### The grave major sixth is the second highest consonance

MIDI:

    #> [1] 68.76612

Cents:

    #> [1] 876.6116

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.8                  69.1

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   3  1.659225     1.659225  434.0957       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  10   3  3.318450     3.318450  868.1914       261.6256
    #> 6      6   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7   5   1  4.977675     4.977675 1302.2872       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  20   3  6.636901     6.636901 1736.3829       261.6256
    #> 11    11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13  25   3  8.296126     8.296126 2170.4786       261.6256
    #> 14    14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  10   1  9.955351     9.955351 2604.5743       261.6256
    #> 16    16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17    17  35   3 11.614576    11.614576 3038.6700       261.6256
    #> 18    18  40   3 13.273801    13.273801 3472.7657       261.6256
    #> 19    19  15   1 14.933026    14.933026 3906.8615       261.6256
    #> 20    20  50   3 16.592251    16.592251 4340.9571       261.6256

###### References for the grave major sixth

- [List of Pitch
  Intervals](https://en.wikipedia.org/wiki/List_of_pitch_intervals)
- [Grave major sixth on
  C](https://en.m.wikipedia.org/wiki/File:Grave_major_sixth_on_C.png)

#### P8 Octave

Plot of P8 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![P8 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/P8%20Orders%20of%20Magnitude.png)

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
