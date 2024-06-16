MaMi.CoDi: A Quantum Model of Consonance Perception at the Heisenberg
Uncertainty Limit
================

## Quantum Consonance Perception

### Temporal

$$\psi(\omega, t) = \int \phi(k) e^{-i \left( \omega t - k x \right) } dk$$

### Spatial

$$\phi(k, t) = \int \psi(\omega, t) e^{-i \left( k x \right) } d\omega$$

### Uncertainty

The model is quantized and the uncertainty is introduced when converting
wavelength and frequency ratios to rational fractions using the
Stern-Brocot tree with variance $\sigma^2$.

$$\Delta \omega \Delta k \ge \frac{1} {2}$$

$${\sigma_f}^2 {\sigma_\lambda}^2 \ge \frac{1} {16 \pi^2}$$

#### Some Thoughts on Uncertainty

Uncertainty in our model is not the time duration and frequency
uncertainty of Gabor (or Wiener’s famous quantum music analogy). It is
space (wavelength) and frequency uncertainty, closer to the original
ideas of Heisenberg and de Broglie.  

$$\lambda=\frac{h}{p}$$

$$f=\frac{E}{h}$$

Consider a $100$ Hz wave with $3$ harmonics:

$f_i=100.00, 200.00, 300.00$ Hz  

If we put those waves for an infinitely long time in a medium with a
wave speed of

$c = max(f) * min(f) = 3\times 10^{4}$

Then the range of values for the wavelengths $\lambda = \frac{c}{f}$
will be the same as the range for the frequencies:

$\lambda_i=300.00, 150.00, 100.00$ m  

We will calculate the overall period of the combined wave twice. We will
find the frequency and wavelength ratios as rational numbers at the
Heisenberg limit and then compute the least common denominator (LCD) for
each. With the LCD we will find the overall period. But a quick glance
at the normalized wavelength and frequency values, above, will show us
that we are headed for a problem: the denominators of those ratios will
not be the same (even with complete precision) and ultimately we will
have two different values for the overall period.

Frequency Ratios

| num | den |
|----:|----:|
|   1 |   1 |
|   2 |   1 |
|   3 |   1 |

Wavelength Ratios

| num | den |
|----:|----:|
|   1 |   1 |
|   3 |   2 |
|   3 |   1 |

And the period(s) is (are?):

| frequency_lcd | f_whole | T_from_f | wavelength_lcd | l_whole | T_from_l |
|--------------:|--------:|---------:|---------------:|--------:|---------:|
|             1 |     100 |     0.01 |              2 |     600 |     0.02 |

From the frequency perspective, the period of the whole wave is $0.01$
s.  

From the wavelength (space) perspective, the period of the whole wave is
$0.02$ s.  

The periods disagree. The disagreement is not due to a lack of precision
in the sensors or the time duration that the waves were in the medium or
even the rational fraction approximation ($3/2$ is precisely $150/100$).
The disagreement seems to be a fundamental uncertainty.  

## How MaMi.CoDi is Implemented

### The Math

#### Traveling Waves

$$s_{i}(x, t) = \sin \left( \frac{2\pi x}{\lambda_{i}} - 2 \pi f_{i} t \right)$$
$N$ is the number of traveling waves in the chord.

$$i=1...N$$

#### Fundamental Wavelength

$$\lambda_{0} = \lambda_{max} { ALCD}\left(r_{\lambda 1},..., r_{\lambda N}\right)$$
$ALCD()$ is an approximate least common denominator.  

#### Wavelength Ratios 

$$r_{\lambda i} = \frac{\lambda_{i}}{\lambda_{min}} \pm \sigma_{\lambda}^{2} = \frac{a_{i}}{b_{i}}$$

$${ GCD}(a_{i}, b_{i}) = 1$$ $GCD()$ is the greatest common divisor.  

#### Fundamental Frequency

$$f_{0} = f_{min} / { ALCD}\left(r_{f 1},..., r_{f N}\right)$$ Frequency
Ratios

$$r_{f i} = \frac{f_{i}}{f_{min}} \pm \sigma_{f}^{2} = \frac{c_{i}}{d_{i}}$$

$${GCD}(c_{i}, d_{i}) = 1$$

#### Heisenberg Uncertainty

$$\sigma_{\lambda}^{2} \sigma_{f}^{2} = \frac{1}{16\pi^{2}}$$

The Stern-Brocot approximation is 0 outside $\pm\sigma^{2}$ which
satisfies the exponential decay constraint and so we can presume
equality.

#### Consonance Perception

Spatial Consonance

$$C_{\lambda} = 50- \log_{2}\left({ ALCD}\left(r_{\lambda 1},..., r_{\lambda N}\right)\right)$$
Temporal Consonance

$$C_{f} = 50 - \log_{2}\left({ ALCD}\left(r_{f 1},..., r_{f N}\right)\right)$$

Total Consonance

$$C_{\lambda f} = C_{\lambda} + C_{f}$$

Pure tone will have a total consonance $C_{\lambda f}$ of 100.

Major-Minor

$$M_{\lambda f} = C_{f} - C_{\lambda}$$ Neutral chords will have a
major-minor value $M_{\lambda f}$ of 0.

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

# `{r, child=c('man/Spatiotemporal_Periodicity.Rmd')} #`

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

### Histogram of Stern-Brocot Approximation versus Actual

![](man/figures/README-unnamed-chunk-8-1.png)<!-- -->  
Number of Samples: 1,000,000  
A peak in a well?  

The Stern-Brocot curve is a repeatable, deterministic curve of where
rational fractions exist or do not exist within a given variance.  

However, we assert that the value is 0 outside $\sigma^{2}$ and the area
of the curve equals one so that we can treat it like a Gaussian
probability density function. 

When I see the shape of this curve of rational numbers at the Heisenberg
limit I can’t help but think about the double-slit experiment and chance
versus determinism, in general.  

Perhaps things are quantized but not probabilistic?  

Maybe God does not play dice with the universe. Whatever game He plays,
He keeps score with rational fractions at the Heisenberg limit.  

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

![](man/figures/README-unnamed-chunk-11-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-5.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-11-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-10.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-11-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-12.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-15.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-11-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-18.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-20.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.03979           | 0.15915          |             0.2 |

![](man/figures/README-unnamed-chunk-11-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-24.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-25.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-11-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-30.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-11-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-35.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-11-36.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-40.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-11-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-42.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-44.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-45.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-11-46.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-47.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-48.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-49.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-50.png)<!-- -->

##### P8ZoomedTemporal ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(temporal) is akin to shutting off the other (spatial).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 5e-05             | 126.65148        |           0.035 |

![](man/figures/README-unnamed-chunk-11-51.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-52.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-53.png)<!-- -->

##### P8ZoomedSpatial ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(spatial) is akin to shutting off the other (temporal).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 126.65148         | 5e-05            |           0.035 |

![](man/figures/README-unnamed-chunk-11-54.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-55.png)<!-- -->  
![](man/figures/README-unnamed-chunk-11-56.png)<!-- -->

### Manipulating amplitudes

##### Harmonic ~ Roll Off: 12

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.013         |             0.2 |

![](man/figures/README-unnamed-chunk-15-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-2.png)<!-- -->

##### Harmonic ~ Roll Off: 7

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.08          |             0.2 |

![](man/figures/README-unnamed-chunk-15-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-4.png)<!-- -->

##### Harmonic ~ Roll Off: 2

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0             |             0.2 |

![](man/figures/README-unnamed-chunk-15-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-6.png)<!-- -->

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
