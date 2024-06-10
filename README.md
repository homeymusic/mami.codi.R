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

#### Example Dyad: Major Third

Below, we estimate the periodicity of the C4, E4 major third with 1, 10
and 20 harmonics per pitch. The MaMi.CoDi model is based on fractions of
tones - both frequency and wavelength fractions. The input to the model
is a sparse frequency spectrum. We convert frequencies to wavelengths by
dividing a speed of sound constant by the frequency.  

For tone ratios, the value of the speed of sound constant does not
impact the mathematics. We could choose any media for the speed of
sound: room temperature air at sea level, cochlear fluid, the basilar
membrane, etc.

We chose the speed of sound in room temperature air.

#### 1 Harmonic

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 1

- Frequencies: 261.626, 329.628  

- Wavelengths: 1.311, 1.041  

- Speed of Sound: 343.000

- f0: 87.209

- l0: 3.933

- Quantum Speed of Sound: 343.000

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

#### 10 Harmonics

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 10

- Frequencies: 261.626, 329.628, 523.251, 659.255, 784.877, 988.883,
  1046.502, 1308.128, 1318.510, 1569.753, 1648.138, 1831.379, 1977.765,
  2093.005, 2307.393, 2354.630, 2616.256, 2637.020, 2966.648, 3296.276  

- Wavelengths: 1.311, 1.041, 0.656, 0.520, 0.437, 0.347, 0.328, 0.262,
  0.260, 0.219, 0.208, 0.187, 0.173, 0.164, 0.149, 0.146, 0.131, 0.130,
  0.116, 0.104  

- Speed of Sound: 343.000

- f0: 21.802

- l0: 78.662

- Quantum Speed of Sound: 1715.000

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

#### 20 Harmonics

- Fundamentals in MIDI: 60, 64  

- Number of Harmonics: 20

- Frequencies: 261.626, 329.628, 523.251, 659.255, 784.877, 988.883,
  1046.502, 1308.128, 1318.510, 1569.753, 1648.138, 1831.379, 1977.765,
  2093.005, 2307.393, 2354.630, 2616.256, 2637.020, 2877.881, 2966.648,
  3139.507, 3296.276, 3401.132, 3625.903, 3662.758, 3924.383, 3955.531,
  4186.009, 4285.158, 4447.635, 4614.786, 4709.260, 4944.413, 4970.886,
  5232.511, 5274.041, 5603.668, 5933.296, 6262.924, 6592.551  

- Wavelengths: 1.311, 1.041, 0.656, 0.520, 0.437, 0.347, 0.328, 0.262,
  0.260, 0.219, 0.208, 0.187, 0.173, 0.164, 0.149, 0.146, 0.131, 0.130,
  0.119, 0.116, 0.109, 0.104, 0.101, 0.095, 0.094, 0.087, 0.087, 0.082,
  0.080, 0.077, 0.074, 0.073, 0.069, 0.069, 0.066, 0.065, 0.061, 0.058,
  0.055, 0.052  

- Speed of Sound: 343.000

- f0: 4.360

- l0: 78.662

- Quantum Speed of Sound: 343.000

###### MaMi.CoDi Predictions

| consonance_dissonance | major_minor | temporal_consonance | spatial_consonance |
|----------------------:|------------:|--------------------:|-------------------:|
|              88.18622 |           0 |            44.09311 |           44.09311 |

#### Temporal Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|  60 | 5.906891 | 4.360426 |     343 | 78.66204 | 0.2293354 |

##### Partial Periods

![](man/figures/README-unnamed-chunk-36-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-37-1.png)<!-- -->

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
|    19 |  11 |   1 | 2877.8811 | 2877.8811 | 101.51318 |              11.000000 |
|    20 |  34 |   3 | 2966.6480 | 2966.6480 | 102.03910 |              11.339289 |
|    21 |  12 |   1 | 3139.5068 | 3139.5068 | 103.01955 |              12.000000 |
|    22 |  38 |   3 | 3296.2755 | 3296.2755 | 103.86314 |              12.599210 |
|    23 |  13 |   1 | 3401.1324 | 3401.1324 | 104.40528 |              13.000000 |
|    24 |  69 |   5 | 3625.9030 | 3625.9030 | 105.51318 |              13.859131 |
|    25 |  14 |   1 | 3662.7579 | 3662.7579 | 105.68826 |              14.000000 |
|    26 |  15 |   1 | 3924.3834 | 3924.3834 | 106.88269 |              15.000000 |
|    27 |  91 |   6 | 3955.5307 | 3955.5307 | 107.01955 |              15.119053 |
|    28 |  16 |   1 | 4186.0090 | 4186.0090 | 108.00000 |              16.000000 |
|    29 |  49 |   3 | 4285.1583 | 4285.1583 | 108.40528 |              16.378974 |
|    30 |  17 |   1 | 4447.6346 | 4447.6346 | 109.04955 |              17.000000 |
|    31 |  53 |   3 | 4614.7858 | 4614.7858 | 109.68826 |              17.638895 |
|    32 |  18 |   1 | 4709.2602 | 4709.2602 | 110.03910 |              18.000000 |
|    33 | 113 |   6 | 4944.4133 | 4944.4133 | 110.88269 |              18.898816 |
|    34 |  19 |   1 | 4970.8857 | 4970.8857 | 110.97513 |              19.000000 |
|    35 |  20 |   1 | 5232.5113 | 5232.5113 | 111.86314 |              20.000000 |
|    36 | 101 |   5 | 5274.0409 | 5274.0409 | 112.00000 |              20.158737 |
|    37 | 107 |   5 | 5603.6684 | 5603.6684 | 113.04955 |              21.418658 |
|    38 |  68 |   3 | 5933.2960 | 5933.2960 | 114.03910 |              22.678579 |
|    39 |  24 |   1 | 6262.9235 | 6262.9235 | 114.97513 |              23.938500 |
|    40 | 101 |   4 | 6592.5511 | 6592.5511 | 115.86314 |              25.198421 |

#### Spatial Periodicity

| lcd | chord_Sz | chord_Hz | c_sound |  chord_m |   chord_s |
|----:|---------:|---------:|--------:|---------:|----------:|
|  60 | 5.906891 | 4.360426 |     343 | 78.66204 | 0.2293354 |

##### Partial Wavelengths

![](man/figures/README-unnamed-chunk-40-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-41-1.png)<!-- -->

##### Wavelength fractions

| index | num | den |    tone_m |      freq |      midi | pseudo_rational_number |
|------:|----:|----:|----------:|----------:|----------:|-----------------------:|
|     1 | 101 |   4 | 1.3110340 |  261.6256 |  60.00000 |              25.198421 |
|     2 |  20 |   1 | 1.0405683 |  329.6276 |  64.00000 |              20.000000 |
|     3 |  38 |   3 | 0.6555170 |  523.2511 |  72.00000 |              12.599210 |
|     4 |  10 |   1 | 0.5202842 |  659.2551 |  76.00000 |              10.000000 |
|     5 |  25 |   3 | 0.4370113 |  784.8767 |  79.01955 |               8.399474 |
|     6 |  20 |   3 | 0.3468561 |  988.8827 |  83.01955 |               6.666667 |
|     7 |  19 |   3 | 0.3277585 | 1046.5023 |  84.00000 |               6.299605 |
|     8 |   5 |   1 | 0.2622068 | 1308.1278 |  87.86314 |               5.039684 |
|     9 |   5 |   1 | 0.2601421 | 1318.5102 |  88.00000 |               5.000000 |
|    10 |  17 |   4 | 0.2185057 | 1569.7534 |  91.01955 |               4.199737 |
|    11 |   4 |   1 | 0.2081137 | 1648.1378 |  91.86314 |               4.000000 |
|    12 |  11 |   3 | 0.1872906 | 1831.3790 |  93.68826 |               3.599774 |
|    13 |  10 |   3 | 0.1734281 | 1977.7653 |  95.01955 |               3.333333 |
|    14 |  16 |   5 | 0.1638792 | 2093.0045 |  96.00000 |               3.149803 |
|    15 |  14 |   5 | 0.1486526 | 2307.3929 |  97.68826 |               2.857143 |
|    16 |  11 |   4 | 0.1456704 | 2354.6301 |  98.03910 |               2.799825 |
|    17 |   5 |   2 | 0.1311034 | 2616.2556 |  99.86314 |               2.519842 |
|    18 |   5 |   2 | 0.1300710 | 2637.0205 | 100.00000 |               2.500000 |
|    19 |   7 |   3 | 0.1191849 | 2877.8811 | 101.51318 |               2.290766 |
|    20 |   9 |   4 | 0.1156187 | 2966.6480 | 102.03910 |               2.222222 |
|    21 |  13 |   6 | 0.1092528 | 3139.5068 | 103.01955 |               2.099868 |
|    22 |   2 |   1 | 0.1040568 | 3296.2755 | 103.86314 |               2.000000 |
|    23 |   2 |   1 | 0.1008488 | 3401.1324 | 104.40528 |               1.938340 |
|    24 |   7 |   4 | 0.0945971 | 3625.9030 | 105.51318 |               1.818182 |
|    25 |   7 |   4 | 0.0936453 | 3662.7579 | 105.68826 |               1.799887 |
|    26 |   5 |   3 | 0.0874023 | 3924.3834 | 106.88269 |               1.679895 |
|    27 |   5 |   3 | 0.0867140 | 3955.5307 | 107.01955 |               1.666667 |
|    28 |   3 |   2 | 0.0819396 | 4186.0090 | 108.00000 |               1.574901 |
|    29 |   3 |   2 | 0.0800437 | 4285.1583 | 108.40528 |               1.538461 |
|    30 |   3 |   2 | 0.0771196 | 4447.6346 | 109.04955 |               1.482260 |
|    31 |   3 |   2 | 0.0743263 | 4614.7858 | 109.68826 |               1.428571 |
|    32 |   4 |   3 | 0.0728352 | 4709.2602 | 110.03910 |               1.399912 |
|    33 |   4 |   3 | 0.0693712 | 4944.4133 | 110.88269 |               1.333333 |
|    34 |   4 |   3 | 0.0690018 | 4970.8857 | 110.97513 |               1.326233 |
|    35 |   4 |   3 | 0.0655517 | 5232.5113 | 111.86314 |               1.259921 |
|    36 |   5 |   4 | 0.0650355 | 5274.0409 | 112.00000 |               1.250000 |
|    37 |   5 |   4 | 0.0612099 | 5603.6684 | 113.04955 |               1.176471 |
|    38 |   7 |   6 | 0.0578094 | 5933.2960 | 114.03910 |               1.111111 |
|    39 |   1 |   1 | 0.0547668 | 6262.9235 | 114.97513 |               1.052632 |
|    40 |   1 |   1 | 0.0520284 | 6592.5511 | 115.86314 |               1.000000 |

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
![](man/figures/README-unnamed-chunk-5-4.png)<!-- -->\$breaks \[1\]
-0.035 -0.030 -0.025 -0.020 -0.015 -0.010 -0.005 0.000 0.005 0.010
\[11\] 0.015 0.020 0.025 0.030 0.035

\$counts \[1\] 24 76 69 66 69 68 1071 64 70 69 80 98 130 45

\$density \[1\] 2.401201 7.603802 6.903452 6.603302 6.903452 6.803402
\[7\] 107.153577 6.403202 7.003502 6.903452 8.004002 9.804902 \[13\]
13.006503 4.502251

\$mids \[1\] -0.0325 -0.0275 -0.0225 -0.0175 -0.0125 -0.0075 -0.0025
0.0025 0.0075 \[10\] 0.0125 0.0175 0.0225 0.0275 0.0325

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-8.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 647 701 733 640 608 517 586 3361 5722 557 500 606 645
1750 753 \[16\] 1664

\$density \[1\] 3.236618 3.506753 3.666833 3.201601 3.041521 2.586293
2.931466 \[8\] 16.813407 28.624312 2.786393 2.501251 3.031516 3.226613
8.754377 \[15\] 3.766883 8.324162

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-10.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-12.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 335 363 379 327 310 267 298 1821 3716 268 240 294 308 368
370 \[16\] 331

\$density \[1\] 3.351676 3.631816 3.791896 3.271636 3.101551 2.671336
2.981491 \[8\] 18.219110 37.178589 2.681341 2.401201 2.941471 3.081541
3.681841 \[15\] 3.701851 3.311656

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-15.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-16.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 261 280 293 257 242 214 237 1638 2794 222 197 240 250 302
300 \[16\] 269

\$density \[1\] 3.264132 3.501751 3.664332 3.214107 3.026513 2.676338
2.963982 \[8\] 20.485243 34.942471 2.776388 2.463732 3.001501 3.126563
3.776888 \[15\] 3.751876 3.364182

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.03979           | 0.15915          |             0.2 |

![](man/figures/README-unnamed-chunk-5-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-18.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-20.png)<!-- -->\$breaks \[1\]
-0.16 -0.14 -0.12 -0.10 -0.08 -0.06 -0.04 -0.02 0.00 0.02 0.04 0.06
\[13\] 0.08 0.10 0.12 0.14 0.16

\$counts \[1\] 234 1220 242 281 1238 245 248 1375 255 231 232 1079 424
231 237 \[16\] 227

\$density \[1\] 1.462683 7.625953 1.512689 1.756470 7.738467 1.531441
1.550194 8.594824 \[9\] 1.593949 1.443930 1.450181 6.744593 2.650331
1.443930 1.481435 1.418927

\$mids \[1\] -0.15 -0.13 -0.11 -0.09 -0.07 -0.05 -0.03 -0.01 0.01 0.03
0.05 0.07 \[13\] 0.09 0.11 0.13 0.15

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-24.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 644 701 720 609 601 511 587 5651 3427 557 498 608 671
1753 757 \[16\] 1695

\$density \[1\] 3.221611 3.506753 3.601801 3.046523 3.006503 2.556278
2.936468 \[8\] 28.269135 17.143572 2.786393 2.491246 3.041521 3.356678
8.769385 \[15\] 3.786893 8.479240

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-5-25.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-28.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 653 708 713 627 612 517 585 5783 3302 564 496 604 640
1766 742 \[16\] 1678

\$density \[1\] 3.266633 3.541771 3.566783 3.136568 3.061531 2.586293
2.926463 \[8\] 28.929465 16.518259 2.821411 2.481241 3.021511 3.201601
8.834417 \[15\] 3.711856 8.394197

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-30.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-32.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 639 797 756 679 451 420 406 3188 5764 680 408 449 537
1801 980 \[16\] 2045

\$density \[1\] 3.195 3.985 3.780 3.395 2.255 2.100 2.030 15.940 28.820
3.400 \[11\] 2.040 2.245 2.685 9.005 4.900 10.225

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### M6 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-35.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-36.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 762 832 796 825 723 733 732 3433 5715 565 356 415 414
1586 569 \[16\] 1544

\$density \[1\] 3.810 4.160 3.980 4.125 3.615 3.665 3.660 17.165 28.575
2.825 \[11\] 1.780 2.075 2.070 7.930 2.845 7.720

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### P8 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-5-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-40.png)<!-- -->\$breaks \[1\]
-0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0.00 0.01 0.02 0.03
\[13\] 0.04 0.05 0.06 0.07 0.08

\$counts \[1\] 530 559 623 571 605 676 709 3621 6058 888 833 639 568
1535 328 \[16\] 1257

\$density \[1\] 2.650 2.795 3.115 2.855 3.025 3.380 3.545 18.105 30.290
4.440 \[11\] 4.165 3.195 2.840 7.675 1.640 6.285

\$mids \[1\] -0.075 -0.065 -0.055 -0.045 -0.035 -0.025 -0.015 -0.005
0.005 0.015 \[11\] 0.025 0.035 0.045 0.055 0.065 0.075

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

##### P8Zoomed ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(spatial) is akin to shutting off the other (temporal).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 126.65148         | 5e-05            |           0.035 |

![](man/figures/README-unnamed-chunk-5-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-42.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-5-44.png)<!-- -->\$breaks \[1\]
-9e-05 -8e-05 -7e-05 -6e-05 -5e-05 -4e-05 -3e-05 -2e-05 -1e-05 0e+00
\[11\] 1e-05 2e-05 3e-05 4e-05 5e-05 6e-05 7e-05 8e-05 9e-05

\$counts \[1\] 4 5 1 3 1351 1021 887 895 3859 7815 836 923 978 1409 3
\[16\] 1 5 4

\$density \[1\] 20 25 5 15 6755 5105 4435 4475 19295 39075 4180 4615
\[13\] 4890 7045 15 5 25 20

\$mids \[1\] -8.5e-05 -7.5e-05 -6.5e-05 -5.5e-05 -4.5e-05 -3.5e-05
-2.5e-05 -1.5e-05 \[9\] -5.0e-06 5.0e-06 1.5e-05 2.5e-05 3.5e-05 4.5e-05
5.5e-05 6.5e-05 \[17\] 7.5e-05 8.5e-05

\$xname \[1\] “errors”

\$equidist \[1\] TRUE

attr(,“class”) \[1\] “histogram”

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
