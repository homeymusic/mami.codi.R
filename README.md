MaMi.CoDi: A Spatiotemporal Periodicity Model of Consonance Perception
================

# Theoretical predictions compared to large-scale behavioral results

The large-scale behavioral data in the plots below are from [Timbral
effects on consonance disentangle psychoacoustic mechanisms and suggest
perceptual origins for musical
scales](https://www.nature.com/articles/s41467-024-45812-z) by Raja
Marjieh, Peter M. C. Harrison, Harin Lee, Fotini Deligiannaki & Nori
Jacoby.

# Manipulating harmonic frequencies

## Dyads spanning 15 semitones

### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.
With the broad smoothing parameter from the large-scale behavioral
study, used in this plot, the smoothed theoretical peaks at M2 and P8
are relatively lower than the theoretical predictions plotted as points.
In a plot below, we narrow the smoothing parameter by an order of
magnitude to see how the theoretical curve changes with respect to the
theoretical predictions.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->

### Harmonic ~ Narrow Smoothing Variation ~ Sigma: 0.02

With a narrow smoothing parameter (0.02 versus 0.2), the smoothed
theoretical peaks at M2 and P8 more closely align with the raw
theoretical predictions plotted as points. At this resolution, where
MaMi.CoDi predicts consonance peaks, the behavioral results shows
dissonance troughs. See the zoomed-in quarter tone spans at M3, M6 and
P8, below, for more discussion about consonance peaks in dissonance
troughs.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |            0.02 |

![](man/figures/README-unnamed-chunk-4-2.png)<!-- -->

### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below with the third partial deleted,
notice that the m3 peak is only slightly lower than the M3 peak. Near
M2, the theoretical smoothed curve is relatively lower than the
theoretical predictions plotted as points.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-3.png)<!-- -->

### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions largely agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is mostly the same for both sets of harmonics.
MaMi.CoDi predicts a peak with minor polarity just below the tritone
that does not exist in the behavioral data. Near M2, the theoretical
smoothed curve is relatively lower than the theoretical predictions
plotted as points.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-4.png)<!-- -->

### Pure ~ Partials: 1

For pure tones, the behavioral results and the theoretical predictions
agree. Only P5 and P8 have pronounced two-sided peaks. The behavioral
results show subtle variations in consonance height across the 15
semitones but the overall shape agrees with MaMi.CoDi predictions.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-5.png)<!-- -->

### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.CoDi predicts a relatively higher consonance peak
just above P4 than the behavioral results. MaMi.Codi predicts peaks with
minor polarity just above m3 and m7 that do not exist in the behavioral
results. Near M2, the theoretical smoothed curve is relatively lower
than the theoretical predictions plotted as points.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2.1                    | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-6.png)<!-- -->

### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks. However, for the behavioral peak between the
14th and 15th semitones, the MaMi.CoDi model predicts a trough. For some
of the non-peak dyads there are differences. MaMi.Codi predicts peaks
with mostly minor polarity just above m2, at m3, just above P4 and
halfway between M6 and m7 that do not exist in the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 1.9                    | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-7.png)<!-- -->

### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi’s
predicted peak at P5 is relatively higher than the behavioral results.
The predicted peak at P4 is shifted slightly lower than the behavioral
results. MaMi.CoDi predicts a peak between m3 and M3 that does not
appear in the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08                 | 0.04                |             0.2 |

![](man/figures/README-unnamed-chunk-4-8.png)<!-- -->

## Dyads spanning 1 quarter tone

### M3 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-4-9.png)<!-- -->

### M6 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-4-10.png)<!-- -->

### P8 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 3e-04                | 0.00015             |           0.035 |

![](man/figures/README-unnamed-chunk-4-11.png)<!-- -->

### Consonance peaks in dissonance troughs

For the high-resolution dyads centered on M3, M6 and P8, the large-scale
behavioral results and the MaMi.CoDi theoretical predictions both show
dissonance troughs centered on the JT dyads.  

MaMi.CoDi, though, predicts a local maximum consonance peak at the
center of each dissonance trough.  

Secondary maximums occur at the Pythagorean third and grave major sixth.
Those secondary peaks are also surrounded by dissonance troughs. There
are also tertiary troughs near the ET intervals.  

##### Consonance peak at P1 in octave-wide dissonance trough

![](man/figures/README-unnamed-chunk-15-1.png)<!-- -->

Performers of instruments with quantized semitones like keyboards and
fretted strings–especially beginners and their audiences–are aware that
the globally maximum consonant peak at the unison, P1, has dissonant
neighbors on both sides, M7 and m2. Consonance increases with each
semitone step out of the trough: downward from M7 to P4 below and upward
from m2 to P5 above.  

That is, at the resolution of an octave, the tonic pitch is the maximum
consonance peak in the center of a dissonance trough.  

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
    #>  1     63.8                  94.9
    #>  2     63.8                  94.9
    #>  3     63.8                  94.9
    #>  4     63.8                  94.9
    #>  5     63.8                  94.9
    #>  6     63.8                  94.9
    #>  7     63.8                  94.9
    #>  8     63.8                  94.9
    #>  9     63.8                  94.9
    #> 10     63.8                  94.9
    #> # ℹ 990 more rows

###### The JT M3 has the highest consonance

    #> [1] 63.78964

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                  94.9

###### Frequency ratios of the JT M3

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    5   4  1.244705     1.244705  325.6465       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    5   2  2.489409     2.489409  651.2931       261.6256
    #> 5    3   1  3.000000     3.000000  784.8767       261.6256
    #> 6   11   3  3.734114     3.734114  976.9396       261.6256
    #> 7    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8    5   1  4.978818     4.978818 1302.5861       261.6256
    #> 9    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11  25   4  6.223523     6.223523 1628.2326       261.6256
    #> 12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13  15   2  7.468227     7.468227 1953.8792       261.6256
    #> 14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15  26   3  8.712932     8.712932 2279.5257       261.6256
    #> 16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17  10   1  9.957636     9.957636 2605.1722       261.6256
    #> 18  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19  45   4 11.202341    11.202341 2930.8188       261.6256
    #> 20  25   2 12.447045    12.447045 3256.4653       261.6256

##### Intervals near the major third ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     64.1                  87.7
    #>  2     64.1                  87.7
    #>  3     64.1                  87.7
    #>  4     64.1                  87.7
    #>  5     64.1                  87.7
    #>  6     64.1                  87.7
    #>  7     64.1                  87.7
    #>  8     64.1                  87.7
    #>  9     64.1                  87.7
    #> 10     64.1                  87.7
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 64.13799

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     64.1                  87.7

###### The lowest consonance ratios

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    4   3  1.270003     1.270003  332.2654       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    5   2  2.540007     2.540007  664.5307       261.6256
    #> 5    3   1  3.000000     3.000000  784.8767       261.6256
    #> 6   15   4  3.810010     3.810010  996.7961       261.6256
    #> 7    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9   36   7  5.080014     5.080014 1329.0614       261.6256
    #> 10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11  19   3  6.350017     6.350017 1661.3267       261.6256
    #> 12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13  23   3  7.620020     7.620020 1993.5921       261.6256
    #> 14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15  53   6  8.890024     8.890024 2325.8575       261.6256
    #> 16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 18  51   5 10.160027    10.160027 2658.1228       261.6256
    #> 19  23   2 11.430030    11.430030 2990.3882       261.6256
    #> 20  38   3 12.700034    12.700034 3322.6535       261.6256

###### The Pythagorean third is the second highest consonance

MIDI:

    #> [1] 63.79014

Cents:

    #> [1] 379.014

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                  94.9

###### Frequency ratios of the second highest consonance

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    5   4  1.244740     1.244740  325.6559       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    5   2  2.489481     2.489481  651.3119       261.6256
    #> 5    3   1  3.000000     3.000000  784.8767       261.6256
    #> 6   11   3  3.734221     3.734221  976.9678       261.6256
    #> 7    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8    5   1  4.978962     4.978962 1302.6237       261.6256
    #> 9    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11  25   4  6.223702     6.223702 1628.2797       261.6256
    #> 12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13  15   2  7.468443     7.468443 1953.9356       261.6256
    #> 14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15  26   3  8.713183     8.713183 2279.5915       261.6256
    #> 16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17  10   1  9.957924     9.957924 2605.2475       261.6256
    #> 18  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19  45   4 11.202664    11.202664 2930.9034       261.6256
    #> 20  25   2 12.447405    12.447405 3256.5593       261.6256

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
    #>  1     68.8                  94.7
    #>  2     68.8                  94.7
    #>  3     68.8                  94.7
    #>  4     68.8                  94.7
    #>  5     68.8                  94.7
    #>  6     68.8                  94.7
    #>  7     68.8                  94.7
    #>  8     68.8                  94.7
    #>  9     68.8                  94.7
    #> 10     68.8                  94.7
    #> # ℹ 990 more rows

###### The JT M6 has the highest consonance

    #> [1] 68.76061

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.8                  94.7

###### Frequency ratios of the JT M6

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    5   3  1.658698     1.658698  433.9577       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    3   1  3.000000     3.000000  784.8767       261.6256
    #> 5   10   3  3.317395     3.317395  867.9154       261.6256
    #> 6    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7    5   1  4.976093     4.976093 1301.8731       261.6256
    #> 8    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9    6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10  20   3  6.634791     6.634791 1735.8308       261.6256
    #> 11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13  25   3  8.293488     8.293488 2169.7885       261.6256
    #> 14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15  10   1  9.952186     9.952186 2603.7462       261.6256
    #> 16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17  35   3 11.610883    11.610883 3037.7039       261.6256
    #> 18  40   3 13.269581    13.269581 3471.6616       261.6256
    #> 19  15   1 14.928279    14.928279 3905.6193       261.6256
    #> 20  50   3 16.586976    16.586976 4339.5770       261.6256

##### Intervals near the major sixth ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     68.7                  89.7
    #>  2     68.7                  89.7
    #>  3     68.7                  89.7
    #>  4     68.7                  89.7
    #>  5     68.7                  89.7
    #>  6     68.7                  89.7
    #>  7     68.7                  89.7
    #>  8     68.7                  89.7
    #>  9     68.7                  89.7
    #> 10     68.7                  89.7
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 68.69304

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.7                  89.7

###### The lowest consonance ratios

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    5   3  1.652237     1.652237  432.2673       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    3   1  3.000000     3.000000  784.8767       261.6256
    #> 5   10   3  3.304473     3.304473  864.5346       261.6256
    #> 6    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7    5   1  4.956710     4.956710 1296.8020       261.6256
    #> 8    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9    6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10  20   3  6.608946     6.608946 1729.0693       261.6256
    #> 11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13  25   3  8.261183     8.261183 2161.3366       261.6256
    #> 14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15  69   7  9.913419     9.913419 2593.6039       261.6256
    #> 16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17  23   2 11.565656    11.565656 3025.8712       261.6256
    #> 18  53   4 13.217892    13.217892 3458.1386       261.6256
    #> 19  74   5 14.870129    14.870129 3890.4059       261.6256
    #> 20  33   2 16.522365    16.522365 4322.6732       261.6256

###### The grave major sixth is the second highest consonance

MIDI:

    #> [1] 68.76111

Cents:

    #> [1] 876.1111

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.8                  94.7

###### Frequency ratios of the second highest consonance

    #>    num den     ratio pseudo_ratio      tone reference_tone
    #> 1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2    5   3  1.658746     1.658746  433.9702       261.6256
    #> 3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4    3   1  3.000000     3.000000  784.8767       261.6256
    #> 5   10   3  3.317491     3.317491  867.9405       261.6256
    #> 6    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7    5   1  4.976237     4.976237 1301.9107       261.6256
    #> 8    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9    6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10  20   3  6.634982     6.634982 1735.8810       261.6256
    #> 11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13  25   3  8.293728     8.293728 2169.8512       261.6256
    #> 14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15  10   1  9.952473     9.952473 2603.8214       261.6256
    #> 16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17  35   3 11.611219    11.611219 3037.7917       261.6256
    #> 18  40   3 13.269964    13.269964 3471.7619       261.6256
    #> 19  15   1 14.928710    14.928710 3905.7321       261.6256
    #> 20  50   3 16.587455    16.587455 4339.7024       261.6256

###### References for the grave major sixth

- [List of Pitch
  Intervals](https://en.wikipedia.org/wiki/List_of_pitch_intervals)
- [Grave major sixth on
  C](https://en.m.wikipedia.org/wiki/File:Grave_major_sixth_on_C.png)

#### P8 Octave

Plot of P8 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![P8 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/P8%20Orders%20of%20Magnitude.png)

# Manipulating harmonic amplitudes

### Harmonic ~ Roll Off: 12

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08333              | 0.041665            |             0.2 |

![](man/figures/README-unnamed-chunk-9-1.png)<!-- -->

### Harmonic ~ Roll Off: 7

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08333              | 0.041665            |             0.2 |

![](man/figures/README-unnamed-chunk-9-2.png)<!-- -->

### Harmonic ~ Roll Off: 2

| detected_pseudo_octave | ignore_amplitudes_below | wavelength_tolerance | frequency_tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:---------------------|:--------------------|----------------:|
| 2                      | 0.03                    | 0.08333              | 0.041665            |             0.2 |

![](man/figures/README-unnamed-chunk-9-3.png)<!-- -->

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
