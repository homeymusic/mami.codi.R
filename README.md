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
estimate ratios (within an acceptable variance) between each of the
parts and a selected reference part. The greatest common divisor (LCD)
of those part ratios will be a measure of the periodicity of the
whole.  

Chords with short wavelengths relative to the component wavelengths
sound pleasant. And chords with long wavelengths relative to component
wavelengths sound unpleasant. MaMi.CoDi uses this measure of relative
wavelengths to predict the perceived spatial consonance of a chord.  

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
signal processing technique. It finds fractions, within a given
variance, for every tone in the chord (fundamental, harmonics, noise,
etc.) relative to a reference tone. The least common denominator of
those fractions is a measure of the cycle length, relative to the
reference tone. Long relative cycles are predicted to sound unpleasant
and short relative cycles are predicted to sound pleasant.  

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
1 harmonics per pitch. The MaMi.CoDi model is based on fractions of
tones - both frequency and wavelength fractions. The input to the model
is a sparse frequency spectrum. We convert frequencies to wavelengths by
dividing a speed of sound constant by the frequency.  

For tone ratios, the value of the speed of sound constant does not
impact the mathematics. We could choose any media for the speed of
sound: room temperature air at sea level, cochlear fluid, the basilar
membrane, etc.

We chose the speed of sound in room temperature air.

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 1

- Frequencies: 261.6, 329.6  

- Speed of Sound: 343.0

- Wavelengths: 1.3, 1.0  

###### MaMi.CoDi Predictions

| consonance_dissonance | major_minor | temporal_consonance | spatial_consonance |
|----------------------:|------------:|--------------------:|-------------------:|
|              96.83007 |           0 |            48.41504 |           48.41504 |

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|   3 | 1.584963 | 87.20852 |     343 | 3.933102 | 0.0114668 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-16-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-17-1.png)<!-- -->

##### Frequency fractions

| index | num | den |  tone_hz |     freq | midi | pseudo_rational_number |
|------:|----:|----:|---------:|---------:|-----:|-----------------------:|
|     1 |   1 |   1 | 261.6256 | 261.6256 |   60 |               1.000000 |
|     2 |   4 |   3 | 329.6276 | 329.6276 |   64 |               1.259921 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|   3 | 1.584963 | 87.20852 |     343 | 3.933102 | 0.0114668 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-20-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-21-1.png)<!-- -->

##### Wavelength fractions

| index | num | den |   tone_m |     freq | midi | pseudo_rational_number |
|------:|----:|----:|---------:|---------:|-----:|-----------------------:|
|     1 |   4 |   3 | 1.311034 | 261.6256 |   60 |               1.259921 |
|     2 |   1 |   1 | 1.040568 | 329.6276 |   64 |               1.000000 |

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 10

- Frequencies: 261.6, 329.6, 523.3, 659.3, 784.9, 988.9, 1046.5, 1308.1,
  1318.5, 1569.8, 1648.1, 1831.4, 1977.8, 2093.0, 2307.4, 2354.6,
  2616.3, 2637.0, 2966.6, 3296.3  

- Speed of Sound: 343.0

- Wavelengths: 1.3, 1.0, 0.7, 0.5, 0.4, 0.3, 0.3, 0.3, 0.3, 0.2, 0.2,
  0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1  

###### MaMi.CoDi Predictions

| consonance_dissonance | major_minor | temporal_consonance | spatial_consonance |
|----------------------:|------------:|--------------------:|-------------------:|
|              90.50815 |    2.321928 |            46.41504 |           44.09311 |

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|  12 | 3.584963 | 21.80213 |     343 | 15.73241 | 0.0458671 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-26-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-27-1.png)<!-- -->

##### Frequency fractions

| index | num | den |   tone_hz |      freq |      midi | pseudo_rational_number |
|------:|----:|----:|----------:|----------:|----------:|-----------------------:|
|     1 |   1 |   1 |  261.6256 |  261.6256 |  60.00000 |               1.000000 |
|     2 |   4 |   3 |  329.6276 |  329.6276 |  64.00000 |               1.259921 |
|     3 |   2 |   1 |  523.2511 |  523.2511 |  72.00000 |               2.000000 |
|     4 |   5 |   2 |  659.2551 |  659.2551 |  76.00000 |               2.519842 |
|     5 |   3 |   1 |  784.8767 |  784.8767 |  79.01955 |               3.000000 |
|     6 |  15 |   4 |  988.8827 |  988.8827 |  83.01955 |               3.779763 |
|     7 |   4 |   1 | 1046.5023 | 1046.5023 |  84.00000 |               4.000000 |
|     8 |   5 |   1 | 1308.1278 | 1308.1278 |  87.86314 |               5.000000 |
|     9 |   5 |   1 | 1318.5102 | 1318.5102 |  88.00000 |               5.039684 |
|    10 |   6 |   1 | 1569.7534 | 1569.7534 |  91.01955 |               6.000000 |
|    11 |  19 |   3 | 1648.1378 | 1648.1378 |  91.86314 |               6.299605 |
|    12 |   7 |   1 | 1831.3790 | 1831.3790 |  93.68826 |               7.000000 |
|    13 |  15 |   2 | 1977.7653 | 1977.7653 |  95.01955 |               7.559526 |
|    14 |   8 |   1 | 2093.0045 | 2093.0045 |  96.00000 |               8.000000 |
|    15 |  35 |   4 | 2307.3929 | 2307.3929 |  97.68826 |               8.819447 |
|    16 |   9 |   1 | 2354.6301 | 2354.6301 |  98.03910 |               9.000000 |
|    17 |  10 |   1 | 2616.2556 | 2616.2556 |  99.86314 |              10.000000 |
|    18 |  10 |   1 | 2637.0205 | 2637.0205 | 100.00000 |              10.079368 |
|    19 |  34 |   3 | 2966.6480 | 2966.6480 | 102.03910 |              11.339289 |
|    20 |  38 |   3 | 3296.2755 | 3296.2755 | 103.86314 |              12.599210 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|  60 | 5.906891 | 4.360426 |     343 | 78.66204 | 0.2293354 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-30-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-31-1.png)<!-- -->

##### Wavelength fractions

| index | num | den |    tone_m |      freq |      midi | pseudo_rational_number |
|------:|----:|----:|----------:|----------:|----------:|-----------------------:|
|     1 |  38 |   3 | 1.3110340 |  261.6256 |  60.00000 |              12.599210 |
|     2 |  10 |   1 | 1.0405683 |  329.6276 |  64.00000 |              10.000000 |
|     3 |  19 |   3 | 0.6555170 |  523.2511 |  72.00000 |               6.299605 |
|     4 |   5 |   1 | 0.5202842 |  659.2551 |  76.00000 |               5.000000 |
|     5 |  17 |   4 | 0.4370113 |  784.8767 |  79.01955 |               4.199737 |
|     6 |  10 |   3 | 0.3468561 |  988.8827 |  83.01955 |               3.333333 |
|     7 |  16 |   5 | 0.3277585 | 1046.5023 |  84.00000 |               3.149803 |
|     8 |   5 |   2 | 0.2622068 | 1308.1278 |  87.86314 |               2.519842 |
|     9 |   5 |   2 | 0.2601421 | 1318.5102 |  88.00000 |               2.500000 |
|    10 |  13 |   6 | 0.2185057 | 1569.7534 |  91.01955 |               2.099868 |
|    11 |   2 |   1 | 0.2081137 | 1648.1378 |  91.86314 |               2.000000 |
|    12 |   7 |   4 | 0.1872906 | 1831.3790 |  93.68826 |               1.799887 |
|    13 |   5 |   3 | 0.1734281 | 1977.7653 |  95.01955 |               1.666667 |
|    14 |   3 |   2 | 0.1638792 | 2093.0045 |  96.00000 |               1.574901 |
|    15 |   3 |   2 | 0.1486526 | 2307.3929 |  97.68826 |               1.428571 |
|    16 |   4 |   3 | 0.1456704 | 2354.6301 |  98.03910 |               1.399912 |
|    17 |   4 |   3 | 0.1311034 | 2616.2556 |  99.86314 |               1.259921 |
|    18 |   5 |   4 | 0.1300710 | 2637.0205 | 100.00000 |               1.250000 |
|    19 |   7 |   6 | 0.1156187 | 2966.6480 | 102.03910 |               1.111111 |
|    20 |   1 |   1 | 0.1040568 | 3296.2755 | 103.86314 |               1.000000 |

### Finding the variance Values

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
variance. Variance is used by the Stern-Brocot algorithm to find tone
ratios as rational fractions that are then used to estimate the relative
periodicity of chords. variance acts as the physiological limits
mentioned by Oxenham, above.  

Considering that the spatial and temporal signals had two different
physiological origins, we searched a two-dimensional variance space in
order to match model predictions with the large-scale behavioral
results. It turned out that the values that best matched large-scale
behavioral results were always the same for temporal and spatial
variance. This might indicate that the physiological limitations are not
specific to place signals or time signals separetely. But instead the
limitation is higher in the auditory system after the signals have been
passed along.  

That is to say, the limits that creates differences between temporal and
spatial signals might not be frequency selectivity or phase locking but
instead a limit of higher-level perception or pattern recognition, where
estimates of the period of a complex signal is made from components.  

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given variance. How do we find the best variance values?
For the MaMi.CoDi model we ran thousands of computations with various
variance values and compared the predictions with results from six of
the large-scale behavioral experiments.  

Because the spatial signal and the temporal signal have different
origins we initially did a two-dimensional variance search. However the
closest fits to the behavioral data came from spatial and variance
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

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.2               | 0.03166          |             0.2 |

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-3.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-6.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-9.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-10.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-12.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.03979           | 0.15915          |             0.2 |

![](man/figures/README-unnamed-chunk-5-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-15.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-18.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-20.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-21.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-24.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-25.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-27.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-30.png)<!-- -->

##### P8Zoomed ~ Partials: 10

There are 3,500 inner hair cells along the basilar membrane. 1 / 3,500
is 0.00029.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 22.16401          | 0.00029          |           0.035 |

![](man/figures/README-unnamed-chunk-5-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-33.png)<!-- -->

### Manipulating amplitudes

##### Harmonic ~ Roll Off: 12

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.013         |             0.2 |

![](man/figures/README-unnamed-chunk-9-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-9-2.png)<!-- -->

##### Harmonic ~ Roll Off: 7

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.08          |             0.2 |

![](man/figures/README-unnamed-chunk-9-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-9-4.png)<!-- -->

##### Harmonic ~ Roll Off: 2

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0             |             0.2 |

![](man/figures/README-unnamed-chunk-9-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-9-6.png)<!-- -->

#### `{r, child=c('man/M3_M6_P8.Rmd')} ####`

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
