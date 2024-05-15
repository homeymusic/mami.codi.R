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

Consider, though, that the fundamental tone of middle C is 1.31 meters
long. The basilar membrane is only 33mm long. How can the hair cells of
the inner ear detect wavelengths that are longer than the basilar
membrane?  

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

#### Example Chord: C4 Major Third Dyad

Below, we estimate the periodicity of the C4 and E4 major third dyad
with 5 harmonics per pitch. The MaMi.CoDi model is based on ratios of
tones - both frequency and wavelength ratios. The input to the model is
a sparse frequency spectrum. We convert frequencies to wavelengths by
dividing a speed of sound constant by the frequency.  

For tone ratios, the value of the speed of sound constant does not
impact the mathematics. Ideally, we could choose any media for the speed
of sound: air, cochlear fluid, basilar membrane, etc.

However, for calculations in a computer, the constant does make a
difference because of the way computers handle very small and very large
numbers. So, we chose a constant for each chord that ensures the
wavelength and frequency values are in the same range. Choosing a
constant that gives similar ranges for frequencies and wavelengths makes
it easier to see how different the ratios for the two signals will be.

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 5

- Frequencies: 261.6, 329.6, 523.3, 659.3, 784.9, 988.9, 1046.5, 1308.1,
  1318.5, 1648.1  

- Speed of Sound: 431195.0

- Wavelengths: 1648.1, 1308.1, 824.1, 654.1, 549.4, 436.0, 412.0, 329.6,
  327.0, 261.6  

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |       tol |
|----:|---------:|---------:|--------:|---------:|----------:|----------:|
|  12 | 3.584963 | 21.80213 |  431195 | 19777.65 | 0.0458671 | 0.0666667 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-12-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-13-1.png)<!-- -->

##### Frequency Ratios

| index | num | den |    ratio |   tone_hz | reference_tone_hz |
|------:|----:|----:|---------:|----------:|------------------:|
|     1 |   1 |   1 | 1.000000 |  261.6256 |          261.6256 |
|     2 |   5 |   4 | 1.259921 |  329.6276 |          261.6256 |
|     3 |   2 |   1 | 2.000000 |  523.2511 |          261.6256 |
|     4 |   5 |   2 | 2.519842 |  659.2551 |          261.6256 |
|     5 |   3 |   1 | 3.000000 |  784.8767 |          261.6256 |
|     6 |  15 |   4 | 3.779763 |  988.8827 |          261.6256 |
|     7 |   4 |   1 | 4.000000 | 1046.5023 |          261.6256 |
|     8 |   5 |   1 | 5.000000 | 1308.1278 |          261.6256 |
|     9 |   5 |   1 | 5.039684 | 1318.5102 |          261.6256 |
|    10 |  19 |   3 | 6.299605 | 1648.1378 |          261.6256 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |  chord_s |       tol |
|----:|---------:|---------:|--------:|---------:|---------:|----------:|
| 420 | 8.714246 | 0.622918 |  431195 | 692217.9 | 1.605348 | 0.0666667 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-16-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-17-1.png)<!-- -->

##### Wavelength Ratios

| index | num | den |    ratio |    tone_m | reference_tone_m |
|------:|----:|----:|---------:|----------:|-----------------:|
|    10 |   1 |   1 | 1.000000 |  261.6256 |         261.6256 |
|     9 |   5 |   4 | 1.250000 |  327.0320 |         261.6256 |
|     8 |   5 |   4 | 1.259921 |  329.6276 |         261.6256 |
|     7 |   8 |   5 | 1.574901 |  412.0344 |         261.6256 |
|     6 |   5 |   3 | 1.666667 |  436.0426 |         261.6256 |
|     5 |  15 |   7 | 2.099868 |  549.3793 |         261.6256 |
|     4 |   5 |   2 | 2.500000 |  654.0639 |         261.6256 |
|     3 |  16 |   5 | 3.149803 |  824.0689 |         261.6256 |
|     2 |   5 |   1 | 5.000000 | 1308.1278 |         261.6256 |
|     1 |  19 |   3 | 6.299605 | 1648.1378 |         261.6256 |

#### Example Chord: C4 Minor Third Dyad

Below, we estimate the periodicity of the C4 and Eb4 minor third dyad
with 5 harmonics per pitch.  

For tone ratios, the value of the speed of sound constant does not
impact the

- Fundamentals in MIDI: 60, 63, 67  

- Number of Harmonics: 5

- Frequencies: 261.6, 311.1, 392.0, 523.3, 622.3, 784.0, 784.9, 933.4,
  1046.5, 1176.0, 1244.5, 1308.1, 1555.6, 1568.0, 1960.0  

- Speed of Sound: 512780.1

- Wavelengths: 1960.0, 1648.1, 1308.1, 980.0, 824.1, 654.1, 653.3,
  549.4, 490.0, 436.0, 412.0, 392.0, 329.6, 327.0, 261.6  

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz |  c_sound |  chord_m |   chord_s |       tol |
|----:|---------:|---------:|---------:|---------:|----------:|----------:|
|  60 | 5.906891 | 4.360426 | 512780.1 | 117598.6 | 0.2293354 | 0.0666667 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-21-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-22-1.png)<!-- -->

##### Frequency Ratios

| index | num | den |    ratio |   tone_hz | reference_tone_hz |
|------:|----:|----:|---------:|----------:|------------------:|
|     1 |   1 |   1 | 1.000000 |  261.6256 |          261.6256 |
|     2 |   5 |   4 | 1.189207 |  311.1270 |          261.6256 |
|     3 |   3 |   2 | 1.498307 |  391.9954 |          261.6256 |
|     4 |   2 |   1 | 2.000000 |  523.2511 |          261.6256 |
|     5 |   7 |   3 | 2.378414 |  622.2540 |          261.6256 |
|     6 |   3 |   1 | 2.996614 |  783.9909 |          261.6256 |
|     7 |   3 |   1 | 3.000000 |  784.8767 |          261.6256 |
|     8 |  18 |   5 | 3.567621 |  933.3810 |          261.6256 |
|     9 |   4 |   1 | 4.000000 | 1046.5023 |          261.6256 |
|    10 |   9 |   2 | 4.494921 | 1175.9863 |          261.6256 |
|    11 |  19 |   4 | 4.756829 | 1244.5079 |          261.6256 |
|    12 |   5 |   1 | 5.000000 | 1308.1278 |          261.6256 |
|    13 |   6 |   1 | 5.946035 | 1555.6349 |          261.6256 |
|    14 |   6 |   1 | 5.993228 | 1567.9817 |          261.6256 |
|    15 |  15 |   2 | 7.491535 | 1959.9772 |          261.6256 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz |  c_sound |  chord_m |  chord_s |       tol |
|----:|---------:|---------:|---------:|---------:|---------:|----------:|
| 420 | 8.714246 | 0.622918 | 512780.1 | 823190.4 | 1.605348 | 0.0666667 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-25-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-26-1.png)<!-- -->

##### Wavelength Ratios

| index | num | den |    ratio |    tone_m | reference_tone_m |
|------:|----:|----:|---------:|----------:|-----------------:|
|    15 |   1 |   1 | 1.000000 |  261.6256 |         261.6256 |
|    14 |   5 |   4 | 1.250000 |  327.0320 |         261.6256 |
|    13 |   5 |   4 | 1.259921 |  329.6276 |         261.6256 |
|    12 |   3 |   2 | 1.498307 |  391.9954 |         261.6256 |
|    11 |   8 |   5 | 1.574901 |  412.0344 |         261.6256 |
|    10 |   5 |   3 | 1.666667 |  436.0426 |         261.6256 |
|     9 |  11 |   6 | 1.872884 |  489.9943 |         261.6256 |
|     8 |  15 |   7 | 2.099868 |  549.3793 |         261.6256 |
|     7 |   5 |   2 | 2.497178 |  653.3257 |         261.6256 |
|     6 |   5 |   2 | 2.500000 |  654.0639 |         261.6256 |
|     5 |  16 |   5 | 3.149803 |  824.0689 |         261.6256 |
|     4 |  15 |   4 | 3.745768 |  979.9886 |         261.6256 |
|     3 |   5 |   1 | 5.000000 | 1308.1278 |         261.6256 |
|     2 |  19 |   3 | 6.299605 | 1648.1378 |         261.6256 |
|     1 |  15 |   2 | 7.491535 | 1959.9772 |         261.6256 |

### Finding the Tolerance Values

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given tolerance. How do we find the best tolerance
values? For the MaMi.CoDi model we ran thousands of computations with
various tolerance values and compared the predictions with results from
six of the large-scale behavioral experiments.  

The best fits across the experiments were given by a tolerance of
0.0666667.  

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

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-2.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-4.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-6.png)<!-- -->

##### Pure ~ Partials: 1

For pure tones, the behavioral results and the theoretical predictions
mostly agree. Only P5 and P8 have pronounced two-sided peaks. The
behavioral results show subtle variations in consonance height across
the 15 semitones but the overall peak structure agrees with MaMi.CoDi
predictions. For futher comparison, the theoretical predictions for
major-minor versus the behavioral results are included in a plot below.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-8.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2.1                    | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-10.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 1.9                    | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-12.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 0.06667   |             0.2 |

![](man/figures/README-unnamed-chunk-5-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-14.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 1e-04     |           0.035 |

![](man/figures/README-unnamed-chunk-5-15.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-16.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 1e-04     |           0.035 |

![](man/figures/README-unnamed-chunk-5-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-18.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| detected_pseudo_octave | ignore_amplitudes_below | tolerance | smoothing_sigma |
|:-----------------------|:------------------------|:----------|----------------:|
| 2                      | 0.03                    | 1e-04     |           0.035 |

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

| multicolored_line_sigma | green_line_sigma | pseudo_octave | tolerance |
|------------------------:|-----------------:|:--------------|:----------|
|                     0.2 |                2 | 2             | 0.06667   |

![](man/figures/README-unnamed-chunk-50-1.png)<!-- -->

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
    #>  1     63.9                  88.0
    #>  2     64.1                  84.2
    #>  3     63.7                  83.8
    #>  4     63.7                  83.8
    #>  5     63.7                  82.7
    #>  6     64.0                  81.8
    #>  7     63.8                  81.0
    #>  8     64.0                  80.7
    #>  9     64.0                  80.7
    #> 10     63.9                  80.5
    #> # ℹ 990 more rows

###### The JT M3 has the highest consonance

    #> [1] 63.86321

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.9                  88.0

###### Frequency ratios of the JT M3

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   4  1.250005     1.250005  327.0334       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   5   2  2.500011     2.500011  654.0668       261.6256
    #> 5      5   3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  15   4  3.750016     3.750016  981.1002       261.6256
    #> 7      7   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9   5   1  5.000022     5.000022 1308.1336       261.6256
    #> 10    10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  25   4  6.250027     6.250027 1635.1669       261.6256
    #> 12    12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  15   2  7.500033     7.500033 1962.2003       261.6256
    #> 14    14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15  35   4  8.750038     8.750038 2289.2337       261.6256
    #> 16    16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 18    18  10   1 10.000044    10.000044 2616.2671       261.6256
    #> 19    19  45   4 11.250049    11.250049 2943.3005       261.6256
    #> 20    20  25   2 12.500055    12.500055 3270.3339       261.6256

##### Intervals near the major third ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     63.7             4.45e-308
    #>  2     63.8             4.45e-308
    #>  3     63.9             4.45e-308
    #>  4     63.9             4.45e-308
    #>  5     63.9             4.45e-308
    #>  6     63.9             4.45e-308
    #>  7     63.9             4.45e-308
    #>  8     63.9             4.45e-308
    #>  9     63.9             4.45e-308
    #> 10     63.9             4.45e-308
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 63.69454

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     63.7             4.45e-308

###### The lowest consonance ratios

    #>    index  num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2  151 122  1.237886     1.237886  323.8627       261.6256
    #> 3      3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4  203  82  2.475772     2.475772  647.7254       261.6256
    #> 5      5    3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  661 178  3.713659     3.713659  971.5881       261.6256
    #> 7      7    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8  307  62  4.951545     4.951545 1295.4508       261.6256
    #> 9      9    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 10    10    6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  588  95  6.189431     6.189431 1619.3134       261.6256
    #> 12    12    7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  765 103  7.427317     7.427317 1943.1761       261.6256
    #> 14    14    8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15 1759 203  8.665204     8.665204 2267.0388       261.6256
    #> 16    16    9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  307  31  9.903090     9.903090 2590.9015       261.6256
    #> 18    18   10   1 10.000000    10.000000 2616.2556       261.6256
    #> 19    19  791  71 11.140976    11.140976 2914.7642       261.6256
    #> 20    20  817  66 12.378862    12.378862 3238.6269       261.6256

###### The Pythagorean third is the second highest consonance

MIDI:

    #> [1] 64.09244

Cents:

    #> [1] 409.2442

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     64.1                  84.2

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2  19  15  1.266667     1.266667  331.3924       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4  38  15  2.533333     2.533333  662.7847       261.6256
    #> 5      5   3   1  3.000000     3.000000  784.8767       261.6256
    #> 6      6  19   5  3.800000     3.800000  994.1771       261.6256
    #> 7      7   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9  76  15  5.066666     5.066666 1325.5695       261.6256
    #> 10    10   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 11    11  19   3  6.333333     6.333333 1656.9619       261.6256
    #> 12    12   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 13    13  38   5  7.600000     7.600000 1988.3542       261.6256
    #> 14    14   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 15    15 133  15  8.866667     8.866667 2319.7467       261.6256
    #> 16    16   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 17    17  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 18    18 152  15 10.133333    10.133333 2651.1389       261.6256
    #> 19    19  57   5 11.399999    11.399999 2982.5313       261.6256
    #> 20    20  38   3 12.666667    12.666667 3313.9238       261.6256

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
    #>  1     68.8                  88.9
    #>  2     68.7                  83.4
    #>  3     69.0                  82.7
    #>  4     69.0                  81.8
    #>  5     68.9                  81.4
    #>  6     68.8                  80.7
    #>  7     68.7                  80.6
    #>  8     69.0                  80.2
    #>  9     68.7                  79.3
    #> 10     68.8                  78.0
    #> # ℹ 990 more rows

###### The JT M6 has the highest consonance

    #> [1] 68.84369

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.8                  88.9

###### Frequency ratios of the JT M6

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2   5   3  1.666677     1.666677  436.0453       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  10   3  3.333354     3.333354  872.0906       261.6256
    #> 6      6   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 8      8   5   1  5.000031     5.000031 1308.1359       261.6256
    #> 9      9   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  20   3  6.666708     6.666708 1744.1812       261.6256
    #> 11    11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13  25   3  8.333385     8.333385 2180.2265       261.6256
    #> 14    14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 16    16  10   1 10.000062    10.000062 2616.2718       261.6256
    #> 17    17  35   3 11.666739    11.666739 3052.3171       261.6256
    #> 18    18  40   3 13.333416    13.333416 3488.3624       261.6256
    #> 19    19  15   1 15.000093    15.000093 3924.4077       261.6256
    #> 20    20  50   3 16.666769    16.666769 4360.4530       261.6256

##### Intervals near the major sixth ranked by lowest consonance

    #> # A tibble: 1,000 × 2
    #>    semitone consonance_dissonance
    #>       <dbl>                 <dbl>
    #>  1     68.7             4.45e-308
    #>  2     68.7             4.45e-308
    #>  3     68.7             4.45e-308
    #>  4     68.7             4.45e-308
    #>  5     68.7             4.45e-308
    #>  6     68.8             4.45e-308
    #>  7     68.8             4.45e-308
    #>  8     68.8             4.45e-308
    #>  9     68.8             4.45e-308
    #> 10     68.8             4.45e-308
    #> # ℹ 990 more rows

###### The lowest consonance

    #> [1] 68.66602

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.7             4.45e-308

###### The lowest consonance ratios

    #>    index  num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1    1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2  160  97  1.649659     1.649659  431.5930       261.6256
    #> 3      3    2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4    3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  386 117  3.299318     3.299318  863.1860       261.6256
    #> 6      6    4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7  292  59  4.948978     4.948978 1294.7791       261.6256
    #> 8      8    5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9    6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  871 132  6.598637     6.598637 1726.3721       261.6256
    #> 11    11    7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12    8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13 1097 133  8.248296     8.248296 2157.9651       261.6256
    #> 14    14    9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  485  49  9.897955     9.897955 2589.5581       261.6256
    #> 16    16   10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17    17  485  42 11.547614    11.547614 3021.1511       261.6256
    #> 18    18  937  71 13.197273    13.197273 3452.7441       261.6256
    #> 19    19 1262  85 14.846933    14.846933 3884.3372       261.6256
    #> 20    20 2293 139 16.496592    16.496592 4315.9301       261.6256

###### The grave major sixth is the second highest consonance

MIDI:

    #> [1] 68.66952

Cents:

    #> [1] 866.952

Consonance:

    #> # A tibble: 1 × 2
    #>   semitone consonance_dissonance
    #>      <dbl>                 <dbl>
    #> 1     68.7                  83.4

###### Frequency ratios of the second highest consonance

    #>    index num den     ratio pseudo_ratio      tone reference_tone
    #> 1      1   1   1  1.000000     1.000000  261.6256       261.6256
    #> 2      2  33  20  1.649993     1.649993  431.6804       261.6256
    #> 3      3   2   1  2.000000     2.000000  523.2511       261.6256
    #> 4      4   3   1  3.000000     3.000000  784.8767       261.6256
    #> 5      5  33  10  3.299986     3.299986  863.3608       261.6256
    #> 6      6   4   1  4.000000     4.000000 1046.5023       261.6256
    #> 7      7  99  20  4.949979     4.949979 1295.0411       261.6256
    #> 8      8   5   1  5.000000     5.000000 1308.1278       261.6256
    #> 9      9   6   1  6.000000     6.000000 1569.7534       261.6256
    #> 10    10  33   5  6.599972     6.599972 1726.7215       261.6256
    #> 11    11   7   1  7.000000     7.000000 1831.3790       261.6256
    #> 12    12   8   1  8.000000     8.000000 2093.0045       261.6256
    #> 13    13  33   4  8.249965     8.249965 2158.4019       261.6256
    #> 14    14   9   1  9.000000     9.000000 2354.6301       261.6256
    #> 15    15  99  10  9.899959     9.899959 2590.0823       261.6256
    #> 16    16  10   1 10.000000    10.000000 2616.2556       261.6256
    #> 17    17 231  20 11.549952    11.549952 3021.7626       261.6256
    #> 18    18  66   5 13.199945    13.199945 3453.4430       261.6256
    #> 19    19 297  20 14.849938    14.849938 3885.1234       261.6256
    #> 20    20  33   2 16.499931    16.499931 4316.8038       261.6256

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
