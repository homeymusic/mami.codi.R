MaMi.CoDi: A Spatiotemporal Periodicity Model of Consonance Perception
================

## How MaMi.CoDi Works

### The Basilar Membrane

When a chord is sounded, pressure waves travel through the air. Those
pressure waves enter the ear canal where they vibrate the ear drum. The
ear drum transfers the energy of the pressure waves through a series of
bones in the fluid of the middle ear to an oval window on the
shell-shaped cochlea of the inner ear. Within the fluid of the cochlea,
the sound energy is converted into a traveling surface wave along the
basilar membrane.  

Human basilar membranes are around 33 mm long. Thousands of
evenly-spaced hair cells are arranged in a line on the basilar membrane.
The hair cells transduce mechanical vibrations into electrical activity
that is sent along the auditory nerve to the central auditory system.
When a sound wave travels along the basilar membrane, the hair cells
positioned near the wavelength of that sound will send electrical
activity along the auditory nerve.  

The fundamental tone of middle C is over a meter long in room
temperature air at sea level. But the basilar membrane is only 33mm
long. How can the hair cells positioned along the basilar membrane
detect wavelengths that are longer than the entire basilar membrane?  

The traveling sound waves shorten as they travel around the spiral
cochlea. Middle C’s fundamental wavelength of 1.31 meters in air shrinks
to 26 mm along the basilar membrane. So, when the fundamental tone of
middle C is sounded, the hair cells positioned 26 mm (81%) from the base
of the cochlea send electrical activity along the auditory nerve.  

When a musical chord comprised of many fundamental tones and harmonics
is sounded, the hair cells at each shortened wavelength position send
signals along the auditory nerve. This spatial or rate-place arrangement
of hair cell positions and wavelengths of tones is known as tonotopy.  

### The Core Idea of MaMi.CoDi

If we play a chord, freeze time and observe which hair cells are
displaced, what are we observing? Are we observing frequencies? Periods?
No. Time is frozen. Frequency (1/s) and period (s) are temporal
observations. We are making a purely spatial observation about
wavelengths (m). We will come back to temporal observations shortly.  

When we combine all the component parts of a chord together into a
whole, we can estimate the overall wavelength for the whole chord. A
technique used in digital signal processing and bricklaying is to
estimate ratios (within an acceptable tolerance) between each of the
parts and a selected reference part. The least common denominator (LCD)
of those part ratios will be a measure of the periodicity of the whole
relative to the selected reference part.  

The overall chord wavelength will be as long as or longer than the
longest component wavelength of the chord. Chords with short wavelengths
relative to the component wavelengths sound pleasant. And chords with
long wavelengths relative to component wavelengthsound unpleasant.
MaMi.CoDi uses this measure of relative wavelength to predict the
perceived spatial consonance of a chord.  

Let us unfreeze time and start counting how often a hair cell moves due
to a pure tone of our sounded chord. If we count the number of movements
relative to a certain amount of time, we will be observing the frequency
of the partial. This would be a temporal observation. The auditory
system has a property called phase locking which allows it to encode the
time intervals, periods, between spikes from sound waves.  

When we combine the period components of a chord together, we can
estimate the overall period for the whole chord. That chord period will
be as long as or longer than the longest component period of the chord.
Short relative periods sound pleasant. Long relative periods sound
unpleasant. MaMi.CoDi uses this measure of chord period to predict the
perceived temporal consonance of a chord.  

MaMi.CoDi sums the spatial and temporal consonance predictions to create
an overall consonance-dissonance prediction. MaMi.CoDi subtracts the
spatial consonance from the temporal consonance to create a major-minor
polarity prediction. Positive values will sound major, negative values
minor and values around zero will sound neutral.  

Because wavelength and frequency are inverse of each other one might
imagine that the spatial and temporal signals would have the same
values. However, for complex pitches that is not the case. The pattern
of the two sets of components are different. See the example of the
major triad with 5 harmonics, below.

### Estimating Spatiotemporal Periodicity

To estimate the periodicity of a chord, the MaMi.CoDi model uses a
signal processing technique. It finds ratios, within a given tolerance,
for every tone in the chord (fundamental, harmonics, noise, etc.)
relative to a reference tone. The least common denominator of those
ratios is a measure of the cycle length, relative to the reference tone.
Long relative cycles are predicted to sound unpleasant and short
relative cycles are predicted to sound pleasant.  

MaMi.CoDi creates two estimates of the chord’s period: a temporal
estimate and a spatial estimate.  

For the temporal (i.e. phase-locking or frequency) estimate the
reference tone is the smallest frequency. Small frequencies are low
tones and are detected by the inner ear hair cells closest to the apex
of the cochlea, which is the end furthest from the source of the wave.  

For the spatial (i.e. rate-place or wavelength) estimate, the reference
tone is the smallest wavelength. Small wavelengths are high tones and
are detected by the inner ear hair cells closest to the base of the
cochlea, which is the end closest to the middle ear, the source of the
wave.  

MaMi.CoDi combines the two cycle estimates into a two-dimensional space
with consonance-dissonance along one dimension and major-minor on the
orthogonal dimension.

#### Example Chord: Major Triad

Below, we estimate the periodicity of the C4, E4 and G4 major triad with
3 harmonics per pitch. The MaMi.CoDi model is based on ratios of tones -
both frequency and wavelength ratios. The input to the model is a sparse
frequency spectrum. We convert frequencies to wavelengths by dividing a
speed of sound constant by the frequency.  

For tone ratios, the value of the speed of sound constant does not
impact the mathematics. Ideally, we could choose any media for the speed
of sound: air, cochlear fluid, basilar membrane, etc.

However, for calculations in a computer, the constant does make a
difference because of the way computers handle very small and very large
numbers. So, we chose a constant for each chord that ensures the
wavelength and frequency values are in the same range. Choosing a
constant that gives similar ranges for frequencies and wavelengths makes
it easier to see how different the ratios for the two signals will be.

- Fundamentals in MIDI: 60, 64, 67  

- Number of Harmonics: 3

- Frequencies: 261.6, 329.6, 392.0, 523.3, 659.3, 784.0, 784.9, 988.9,
  1176.0  

- Speed of Sound: 307668.1

- Wavelengths: 1176.0, 933.4, 784.9, 588.0, 466.7, 392.4, 392.0, 311.1,
  261.6  

###### MaMi.CoDi Predictions

| consonance_dissonance | major_minor | temporal_consonance | spatial_consonance |
|----------------------:|------------:|--------------------:|-------------------:|
|             0.0349206 |   0.0206349 |           0.0277778 |          0.0071429 |

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz |  c_sound |  chord_m |   chord_s |  tol |
|----:|---------:|---------:|---------:|---------:|----------:|-----:|
|  36 | 5.169925 | 7.267377 | 307668.1 | 42335.51 | 0.1376012 | 0.02 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-13-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-14-1.png)<!-- -->

##### Frequency Ratios

| index | num | den |    ratio |   tone_hz | reference_tone_hz | tolerance |
|------:|----:|----:|---------:|----------:|------------------:|----------:|
|     1 |   1 |   1 | 1.000000 |  261.6256 |          261.6256 |      0.02 |
|     2 |   5 |   4 | 1.259921 |  329.6276 |          261.6256 |      0.02 |
|     3 |   3 |   2 | 1.498307 |  391.9954 |          261.6256 |      0.02 |
|     4 |   2 |   1 | 2.000000 |  523.2511 |          261.6256 |      0.02 |
|     5 |   5 |   2 | 2.519842 |  659.2551 |          261.6256 |      0.02 |
|     6 |   3 |   1 | 2.996614 |  783.9909 |          261.6256 |      0.02 |
|     7 |   3 |   1 | 3.000000 |  784.8767 |          261.6256 |      0.02 |
|     8 |  34 |   9 | 3.779763 |  988.8827 |          261.6256 |      0.02 |
|     9 |   9 |   2 | 4.494921 | 1175.9863 |          261.6256 |      0.02 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz |  c_sound |  chord_m |   chord_s |  tol |
|----:|---------:|---------:|---------:|---------:|----------:|-----:|
| 140 | 7.129283 | 1.868754 | 307668.1 | 164638.1 | 0.5351159 | 0.02 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-17-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-18-1.png)<!-- -->

##### Wavelength Ratios

| index | num | den |    ratio |    tone_m | reference_tone_m | tolerance |
|------:|----:|----:|---------:|----------:|-----------------:|----------:|
|     9 |   1 |   1 | 1.000000 |  261.6256 |         261.6256 |      0.02 |
|     8 |   6 |   5 | 1.189207 |  311.1270 |         261.6256 |      0.02 |
|     7 |   3 |   2 | 1.498307 |  391.9954 |         261.6256 |      0.02 |
|     6 |   3 |   2 | 1.500000 |  392.4383 |         261.6256 |      0.02 |
|     5 |   9 |   5 | 1.783811 |  466.6905 |         261.6256 |      0.02 |
|     4 |   9 |   4 | 2.247461 |  587.9932 |         261.6256 |      0.02 |
|     3 |   3 |   1 | 3.000000 |  784.8767 |         261.6256 |      0.02 |
|     2 |  25 |   7 | 3.567621 |  933.3810 |         261.6256 |      0.02 |
|     1 |   9 |   2 | 4.494921 | 1175.9863 |         261.6256 |      0.02 |

### Finding the Tolerance Values

“One difficulty with distinguishing between place and temporal (or
place-time) models of pitch is that spectral and temporal
representations of a signal are mathematically equivalent: any change in
the spectral representation is reflected by a change in the temporal
representation, and vice versa . Discovering what the auditory system
does means focusing on the physiological limits imposed by the cochlea
and auditory nerve.  

“For instance, the place theory can be tested using known limits of
frequency selectivity: if pitch can be heard when only unresolved
harmonics are presented (eliminating place information), then place
information is not necessary for pitch. Similarly, if all the
frequencies within a stimulus are above the upper limits of phase
locking, and the temporal envelope information is somehow suppressed,
then temporal information is not necessary for pitch perception.”  

from “Revisiting place and temporal theories of pitch”, Andrew J.
Oxenham, 2014.  

The MaMi.CoDi model, based on Stolzenburg (2015), has one one parameter:
tolerance. Tolerance is used by the Stern-Brocot algorithm to find tone
ratios as rational fractions that are then used to estimate the relative
periodicity of chords. Tolerance acts as the physiological limits
mentioned by Oxenham, above.  

Considering that the spatial and temporal signals had two different
physiological origins, we searched a two-dimensional tolerance space in
order to match model predictions with the large-scale behavioral
results. It turned out that the values that best matched large-scale
behavioral results were always the same for temporal and spatial
tolerance. This might indicate that the physiological limitations are
not specific to place signals or time signals separetely. But instead
the limitation is higher in the auditory system after the signals have
been passed along.  

That is to say, the limits that creates differences between temporal and
spatial signals might not be frequency selectivity or phase locking but
instead a limit of higher-level perception or pattern recognition, where
estimates of the period of a complex signal is made from components.  

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given tolerance. How do we find the best tolerance
values? For the MaMi.CoDi model we ran thousands of computations with
various tolerance values and compared the predictions with results from
six of the large-scale behavioral experiments.  

Because the spatial signal and the temporal signal have different
origins we initially did a two-dimensional tolerance search. However the
closest fits to the behavioral data came from spatial and tolerance
values being the same. Insofar as this model represents processing in
the auditory cortex, it would seem that estimating the cyclicity of the
two signals happens higher up in the auditoray system after the spatial
and temporal signals have been processed.  

## Theoretical predictions compared to large-scale behavioral results

The large-scale behavioral data in the plots below are from [Timbral
effects on consonance disentangle psychoacoustic mechanisms and suggest
perceptual origins for musical
scales](https://www.nature.com/articles/s41467-024-45812-z) by Raja
Marjieh, Peter M. C. Harrison, Harin Lee, Fotini Deligiannaki & Nori
Jacoby.

### Manipulating harmonic frequencies

#### Dyads spanning 15 semitones

##### Pure ~ Partials: 1

For pure tones, the behavioral results and the theoretical predictions
mostly agree. Only P5 and P8 have pronounced two-sided peaks. The
behavioral results show subtle variations in consonance height across
the 15 semitones but the overall peak structure agrees with MaMi.CoDi
predictions. For futher comparison, the theoretical predictions for
major-minor versus the behavioral results are included in a plot below.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-2.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-4.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-6.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-8.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-10.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-12.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 0.02              | 0.02               |             0.2 |

![](man/figures/README-unnamed-chunk-5-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-14.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 5e-05             | 5e-05              |           0.035 |

![](man/figures/README-unnamed-chunk-5-15.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-16.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 5e-05             | 5e-05              |           0.035 |

![](man/figures/README-unnamed-chunk-5-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-18.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| min_amplitude | spatial_tolerance | temporal_tolerance | smoothing_sigma |
|:--------------|:------------------|:-------------------|----------------:|
| 0             | 5e-05             | 5e-05              |           0.035 |

![](man/figures/README-unnamed-chunk-5-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-20.png)<!-- -->

### TODO: run the in-depth tolerance searches again for M3, M6 and P8

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

| multicolored_line_sigma | green_line_sigma | spatial_tolerance | temporal_tolerance |
|------------------------:|-----------------:|:------------------|:-------------------|
|                     0.2 |                2 | 0.02              | 0.02               |

![](man/figures/README-unnamed-chunk-34-1.png)<!-- -->

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
values.](./man/tolerance_search_plots/M3.png)

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
    #>  1     63.8                 0.251
    #>  2     63.8                 0.251
    #>  3     63.8                 0.251
    #>  4     63.8                 0.251
    #>  5     63.8                 0.251
    #>  6     63.8                 0.251
    #>  7     63.8                 0.251
    #>  8     63.8                 0.251
    #>  9     63.8                 0.251
    #> 10     63.8                 0.251
    #> # ℹ 990 more rows

###### The JT M3 has the highest consonance

    #> [1] 63.83569

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                 0.251

###### Frequency ratios of the JT M3

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2   5   4  1.248020  326.5138       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4   5   2  2.496039  653.0276       261.6256      0.02
    #> 5      5   3   1  3.000000  784.8767       261.6256      0.02
    #> 6      6  15   4  3.744059  979.5414       261.6256      0.02
    #> 7      7   4   1  4.000000 1046.5023       261.6256      0.02
    #> 8      8   5   1  4.992078 1306.0553       261.6256      0.02
    #> 9      9   5   1  5.000000 1308.1278       261.6256      0.02
    #> 10    10   6   1  6.000000 1569.7534       261.6256      0.02
    #> 11    11  25   4  6.240098 1632.5690       261.6256      0.02
    #> 12    12   7   1  7.000000 1831.3790       261.6256      0.02
    #> 13    13  15   2  7.488117 1959.0829       261.6256      0.02
    #> 14    14   8   1  8.000000 2093.0045       261.6256      0.02
    #> 15    15  35   4  8.736137 2285.5967       261.6256      0.02
    #> 16    16   9   1  9.000000 2354.6301       261.6256      0.02
    #> 17    17  10   1  9.984156 2612.1105       261.6256      0.02
    #> 18    18  10   1 10.000000 2616.2556       261.6256      0.02
    #> 19    19  45   4 11.232176 2938.6243       261.6256      0.02
    #> 20    20  25   2 12.480195 3265.1381       261.6256      0.02

##### Intervals near the major third ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     63.6             0.0000111
    #>  2     63.7             0.0000111
    #>  3     63.7             0.0000111
    #>  4     63.7             0.0000111
    #>  5     63.7             0.0000111
    #>  6     63.7             0.0000111
    #>  7     63.7             0.0000111
    #>  8     63.7             0.0000111
    #>  9     63.7             0.0000111
    #> 10     63.7             0.0000111
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 63.65

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.6             0.0000111

###### The lowest consonance ratios

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2   5   4  1.234705  323.0305       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4  27  11  2.469410  646.0609       261.6256      0.02
    #> 5      5   3   1  3.000000  784.8767       261.6256      0.02
    #> 6      6  26   7  3.704116  969.0914       261.6256      0.02
    #> 7      7   4   1  4.000000 1046.5023       261.6256      0.02
    #> 8      8  64  13  4.938821 1292.1218       261.6256      0.02
    #> 9      9   5   1  5.000000 1308.1278       261.6256      0.02
    #> 10    10   6   1  6.000000 1569.7534       261.6256      0.02
    #> 11    11  37   6  6.173526 1615.1523       261.6256      0.02
    #> 12    12   7   1  7.000000 1831.3790       261.6256      0.02
    #> 13    13  37   5  7.408231 1938.1827       261.6256      0.02
    #> 14    14   8   1  8.000000 2093.0045       261.6256      0.02
    #> 15    15  69   8  8.642937 2261.2132       261.6256      0.02
    #> 16    16   9   1  9.000000 2354.6301       261.6256      0.02
    #> 17    17  79   8  9.877642 2584.2436       261.6256      0.02
    #> 18    18  10   1 10.000000 2616.2556       261.6256      0.02
    #> 19    19  89   8 11.112347 2907.2741       261.6256      0.02
    #> 20    20  37   3 12.347052 3230.3045       261.6256      0.02

###### The Pythagorean third is the second highest consonance

MIDI:

    #> [1] 63.83619

Cents:

    #> [1] 383.6186

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.8                 0.251

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2   5   4  1.248056  326.5232       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4   5   2  2.496111  653.0465       261.6256      0.02
    #> 5      5   3   1  3.000000  784.8767       261.6256      0.02
    #> 6      6  15   4  3.744167  979.5697       261.6256      0.02
    #> 7      7   4   1  4.000000 1046.5023       261.6256      0.02
    #> 8      8   5   1  4.992222 1306.0930       261.6256      0.02
    #> 9      9   5   1  5.000000 1308.1278       261.6256      0.02
    #> 10    10   6   1  6.000000 1569.7534       261.6256      0.02
    #> 11    11  25   4  6.240278 1632.6162       261.6256      0.02
    #> 12    12   7   1  7.000000 1831.3790       261.6256      0.02
    #> 13    13  15   2  7.488333 1959.1395       261.6256      0.02
    #> 14    14   8   1  8.000000 2093.0045       261.6256      0.02
    #> 15    15  35   4  8.736389 2285.6627       261.6256      0.02
    #> 16    16   9   1  9.000000 2354.6301       261.6256      0.02
    #> 17    17  10   1  9.984445 2612.1859       261.6256      0.02
    #> 18    18  10   1 10.000000 2616.2556       261.6256      0.02
    #> 19    19  45   4 11.232500 2938.7092       261.6256      0.02
    #> 20    20  25   2 12.480556 3265.2324       261.6256      0.02

###### References for the Pythagorean third

- “19/15 409.2443014 (good approximation of Pythagorean 3rd)”
  - from [M3 in the Encyclopedia of Microtonal Music
    Theory](http://www.tonalsoft.com/enc/m/major-3rd.aspx)
- [Pythagorean ditone](https://en.wikipedia.org/wiki/Ditone)

#### M6 ~ Major Sixth

Plot of M6 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![M6 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/M6.png)

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
    #>  1     68.9                 0.335
    #>  2     68.9                 0.335
    #>  3     68.9                 0.335
    #>  4     68.9                 0.335
    #>  5     68.9                 0.335
    #>  6     68.9                 0.335
    #>  7     68.9                 0.335
    #>  8     68.9                 0.335
    #>  9     68.9                 0.335
    #> 10     68.9                 0.335
    #> # ℹ 990 more rows

###### The JT M6 has the highest consonance

    #> [1] 68.85771

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.9                 0.335

###### Frequency ratios of the JT M6

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2   5   3  1.668027  436.3984       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4   3   1  3.000000  784.8767       261.6256      0.02
    #> 5      5  10   3  3.336053  872.7968       261.6256      0.02
    #> 6      6   4   1  4.000000 1046.5023       261.6256      0.02
    #> 7      7   5   1  5.000000 1308.1278       261.6256      0.02
    #> 8      8   5   1  5.004080 1309.1952       261.6256      0.02
    #> 9      9   6   1  6.000000 1569.7534       261.6256      0.02
    #> 10    10  20   3  6.672107 1745.5937       261.6256      0.02
    #> 11    11   7   1  7.000000 1831.3790       261.6256      0.02
    #> 12    12   8   1  8.000000 2093.0045       261.6256      0.02
    #> 13    13  25   3  8.340133 2181.9921       261.6256      0.02
    #> 14    14   9   1  9.000000 2354.6301       261.6256      0.02
    #> 15    15  10   1 10.000000 2616.2556       261.6256      0.02
    #> 16    16  10   1 10.008160 2618.3905       261.6256      0.02
    #> 17    17  35   3 11.676186 3054.7889       261.6256      0.02
    #> 18    18  40   3 13.344213 3491.1873       261.6256      0.02
    #> 19    19  15   1 15.012240 3927.5857       261.6256      0.02
    #> 20    20  50   3 16.680266 4363.9841       261.6256      0.02

##### Intervals near the major sixth ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     69.1             0.0000139
    #>  2     69.1             0.0000139
    #>  3     69.1             0.0000139
    #>  4     69.1             0.0000139
    #>  5     69.1             0.0000139
    #>  6     69.1             0.0000139
    #>  7     69.1             0.0000139
    #>  8     69.1             0.0000139
    #>  9     69.1             0.0000139
    #> 10     69.1             0.0000139
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 69.12197

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     69.1             0.0000139

###### The lowest consonance ratios

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2  17  10  1.693684  443.1109       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4   3   1  3.000000  784.8767       261.6256      0.02
    #> 5      5  17   5  3.387367  886.2218       261.6256      0.02
    #> 6      6   4   1  4.000000 1046.5023       261.6256      0.02
    #> 7      7   5   1  5.000000 1308.1278       261.6256      0.02
    #> 8      8  51  10  5.081051 1329.3327       261.6256      0.02
    #> 9      9   6   1  6.000000 1569.7534       261.6256      0.02
    #> 10    10  61   9  6.774734 1772.4437       261.6256      0.02
    #> 11    11   7   1  7.000000 1831.3790       261.6256      0.02
    #> 12    12   8   1  8.000000 2093.0045       261.6256      0.02
    #> 13    13  93  11  8.468418 2215.5545       261.6256      0.02
    #> 14    14   9   1  9.000000 2354.6301       261.6256      0.02
    #> 15    15  10   1 10.000000 2616.2556       261.6256      0.02
    #> 16    16  61   6 10.162101 2658.6655       261.6256      0.02
    #> 17    17  83   7 11.855785 3101.7764       261.6256      0.02
    #> 18    18 122   9 13.549468 3544.8873       261.6256      0.02
    #> 19    19  61   4 15.243152 3987.9982       261.6256      0.02
    #> 20    20 220  13 16.936835 4431.1091       261.6256      0.02

###### The grave major sixth is the second highest consonance

MIDI:

    #> [1] 68.85821

Cents:

    #> [1] 885.8208

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.9                 0.335

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio      tone reference_tone tolerance
    #> 1      1   1   1  1.000000  261.6256       261.6256      0.02
    #> 2      2   5   3  1.668075  436.4110       261.6256      0.02
    #> 3      3   2   1  2.000000  523.2511       261.6256      0.02
    #> 4      4   3   1  3.000000  784.8767       261.6256      0.02
    #> 5      5  10   3  3.336150  872.8220       261.6256      0.02
    #> 6      6   4   1  4.000000 1046.5023       261.6256      0.02
    #> 7      7   5   1  5.000000 1308.1278       261.6256      0.02
    #> 8      8   5   1  5.004224 1309.2331       261.6256      0.02
    #> 9      9   6   1  6.000000 1569.7534       261.6256      0.02
    #> 10    10  20   3  6.672299 1745.6441       261.6256      0.02
    #> 11    11   7   1  7.000000 1831.3790       261.6256      0.02
    #> 12    12   8   1  8.000000 2093.0045       261.6256      0.02
    #> 13    13  25   3  8.340374 2182.0551       261.6256      0.02
    #> 14    14   9   1  9.000000 2354.6301       261.6256      0.02
    #> 15    15  10   1 10.000000 2616.2556       261.6256      0.02
    #> 16    16  10   1 10.008449 2618.4661       261.6256      0.02
    #> 17    17  35   3 11.676524 3054.8771       261.6256      0.02
    #> 18    18  40   3 13.344599 3491.2881       261.6256      0.02
    #> 19    19  15   1 15.012673 3927.6992       261.6256      0.02
    #> 20    20  50   3 16.680748 4364.1101       261.6256      0.02

###### References for the grave major sixth

- [List of Pitch
  Intervals](https://en.wikipedia.org/wiki/List_of_pitch_intervals)
- [Grave major sixth on
  C](https://en.m.wikipedia.org/wiki/File:Grave_major_sixth_on_C.png)

#### P8 Octave

Plot of P8 with MaMi.CoDi tolerance values varying from 1e-08 to 0.1:
![P8 with a range of MaMi.CoDi tolerance
values.](./man/tolerance_search_plots/P8.png)

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
