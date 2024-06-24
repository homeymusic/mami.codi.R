MaMi.CoDi: A Quantum Model of Consonance Perception at the Heisenberg
Uncertainty Limit
================

# Outline

## Traveling Wave Equation

$$e ^ {-i \left( \omega t - k x \right)}$$

## Middle C Wavelength Plot

Consider the fundamental tone of middle C playing from $-\infty$ to
$\infty$. If we freeze time at $t=0$, then we have a plane wave
$e ^ {i k x}$. Assuming room temperature air at sea level, the
wavelength $\lambda$ is 1.31m.

![](man/figures/README-unnamed-chunk-2-1.png)<!-- -->

## The Cochlea Diagram

The human cochlea is $\sim 33 mm$ long.

<figure>
<img src="man/scrapbook/cochlea.png"
alt="The physics of hearing: fluid mechanics and the active process of the inner ear, Tobias Reichenbach and A J Hudspeth 2014 Rep. Prog. Phys. 77 076601" />
<figcaption aria-hidden="true">The physics of hearing: fluid mechanics
and the active process of the inner ear, Tobias Reichenbach and A J
Hudspeth 2014 Rep. Prog. Phys. 77 076601</figcaption>
</figure>

## hrep Plots of Cochlea %

How does a 1.3m wave fit in the cochlea?

<figure>
<img src="man/scrapbook/bekesy.png"
alt="Elizabeth S. Olson, Hendrikus Duifhuis, Charles R. Steele, Von Békésy and cochlear mechanics, Hearing Research, Volume 293, Issues 1–2, 2012, Pages 31-43" />
<figcaption aria-hidden="true">Elizabeth S. Olson, Hendrikus Duifhuis,
Charles R. Steele, Von Békésy and cochlear mechanics, Hearing Research,
Volume 293, Issues 1–2, 2012, Pages 31-43</figcaption>
</figure>

``` r
midi=24
C1 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C1 %>% plot(cochlea=T,ggplot=T,xlim=c(0,100))
```

![](man/figures/README-unnamed-chunk-3-1.png)<!-- -->

``` r
midi=60
C4 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C4 %>% plot(cochlea=T,ggplot=T,xlim=c(0,100))
```

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->

``` r
midi=97
C7 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C7 %>% plot(cochlea=T,ggplot=T,xlim=c(0,100))
```

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

## Diagram of Phases in Cochlea

then unpause for a moment

t=0+deltas

from Loeb paper 80s

when time runs we get some blurring / uncertainty of the wavelength

<figure>
<img src="man/scrapbook/loeb.png"
alt="Loeb, G.E., White, M.W. and Merzenich, M.M., Spatial cross-correlation: a proposed mechanism for acoustic pitch perception, Biol. Cybern., 47 (1983) 149-163." />
<figcaption aria-hidden="true">Loeb, G.E., White, M.W. and Merzenich,
M.M., Spatial cross-correlation: a proposed mechanism for acoustic pitch
perception, Biol. Cybern., 47 (1983) 149-163.</figcaption>
</figure>

## Diagram of Oscilliscopes at every hair cell

when t=0 there is no oscilliscope

when we unpause time the oscilliscope runs and we have information

<figure>
<img src="man/scrapbook/rudnicki.png"
alt="Cell Tissue Res (2015) 361:159–175 DOI 10.1007/s00441-015-2202-z Modeling auditory coding: from sound to spikes Marek Rudnicki, Oliver Schoppe, Michael Isik, Florian Volk, Werner Hemmert" />
<figcaption aria-hidden="true">Cell Tissue Res (2015) 361:159–175 DOI
10.1007/s00441-015-2202-z Modeling auditory coding: from sound to spikes
Marek Rudnicki, Oliver Schoppe, Michael Isik, Florian Volk, Werner
Hemmert</figcaption>
</figure>

## Phase locking diagram

now we have frequency information

the more time runs the more frequency information we have

<figure>
<img src="man/scrapbook/winter.png"
alt="Winter, I.M., 2005. The neurophysiology of pitch. In: Plack, C.J., Oxenham, A.J., Fay, R.R., Popper, A.N. (Eds.), Pitch: Neural Coding and Perception. Springer, New York, NY, p. 364." />
<figcaption aria-hidden="true">Winter, I.M., 2005. The neurophysiology
of pitch. In: Plack, C.J., Oxenham, A.J., Fay, R.R., Popper, A.N.
(Eds.), Pitch: Neural Coding and Perception. Springer, New York, NY,
p. 364.</figcaption>
</figure>

## hrep Plots of freq spectrum Hz

``` r
midi=24
C1 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C1 %>% plot(ggplot=T,xlim=c(10,12000),trans='log10')
```

![](man/figures/README-unnamed-chunk-6-1.png)<!-- -->

``` r
midi=60
C4 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C4 %>% plot(ggplot=T,xlim=c(10,12000),trans='log10')
```

![](man/figures/README-unnamed-chunk-7-1.png)<!-- -->

``` r
midi=97
C7 = c(midi) %>% hrep::sparse_fr_spectrum(num_harmonics=5)
C7 %>% plot(ggplot=T,xlim=c(10,12000),trans='log10')
```

![](man/figures/README-unnamed-chunk-8-1.png)<!-- -->

## screenshot of calculating f0 from ratios and LCD

<figure>
<img src="man/scrapbook/sundararajan.png"
alt="D. Sundararajan, Fourier Analysis—A Signal Processing Approach, 2018" />
<figcaption aria-hidden="true">D. Sundararajan, Fourier Analysis—A
Signal Processing Approach, 2018</figcaption>
</figure>

## math equations of f0 and l0 from lcd

### Fundamental Frequency

$$f_{0} = \frac{f_{min}}{{ LCD}\left(r_{f 1},..., r_{f N}\right)}$$
$LCD()$ is the least common denominator.  

$$r_{f i} = \frac{f_{i}}{f_{min}} \pm \sigma_{f}^{2} = \frac{a_{i}}{b_{i}}$$

$\sigma^2$ is the tolerance for converting a real number into a rational
fraction. Later we will treat the Stern-Brocot function as a strictly
localized probability distribution with variance $\sigma^2$.

$${GCD}(a_{i}, b_{i}) = 1$$

$GCD()$ is the greatest common divisor.  

### Fundamental Wavelength

$$\lambda_{0} = \lambda_{max} { LCD}\left(r_{\lambda 1},..., r_{\lambda N}\right)$$

$$r_{\lambda i} = \frac{\lambda_{i}}{\lambda_{min}} \pm \sigma_{\lambda}^{2} = \frac{c_{i}}{d_{i}}$$

$${ GCD}(c_{i}, d_{i}) = 1$$

## Stern-Brocot Tree diagram

<figure>
<img src="man/scrapbook/forisek.png"
alt="Approximating Rational Numbers by Fraction, Michal Forisek, Fun with Algorithms, 4th International Conference, FUN 2007 Castiglioncello, Italy, June 2007 Proceedings" />
<figcaption aria-hidden="true">Approximating Rational Numbers by
Fraction, Michal Forisek, Fun with Algorithms, 4th International
Conference, FUN 2007 Castiglioncello, Italy, June 2007
Proceedings</figcaption>
</figure>

## Periodicity plot of frequencies 1 cycle each 1, 20, 10 harmonics

## Periodicity plot of frequencies full cycles 1, 20, 10 harmonics

## Table show outputs for 1, 20, 10 harmonics

The lcd machinery gives us fundamental frequency and wavelength

we hear these waves log based

## Table of shifting the frequency up or down

## Equation of consonance log2(lcd(…))

now we have two measures of consonance that work even when we shift the
chords up or down

<figure>
<img src="man/scrapbook/stolzenburg.png"
alt="Harmony Perception by Periodicity Detection∗ Frieder Stolzenburg, Journal of Mathematics and Music, 9(3):215–238, 2015" />
<figcaption aria-hidden="true">Harmony Perception by Periodicity
Detection∗ Frieder Stolzenburg, Journal of Mathematics and Music,
9(3):215–238, 2015</figcaption>
</figure>

## Periodicity plot of wavelengths 1 cycle each 1, 20, 10 harmonics

## Periodicity plot of wavelengths full cycles 1, 20, 10 harmonics

## Table show outputs for 1, 20, 10 harmonics

## comparison Table show outputs for 1, 20, 10 harmonics

## Shamma 2D consonance

<figure>
<img src="man/scrapbook/shamma.png"
alt="S. Shamma On the role of space and time in auditory processing, Trends Cogn. Sci., 5 (2001), pp. 340-348" />
<figcaption aria-hidden="true">S. Shamma On the role of space and time
in auditory processing, Trends Cogn. Sci., 5 (2001),
pp. 340-348</figcaption>
</figure>

## Oxenham mathematically equivalent

<figure>
<img src="man/scrapbook/oxenham.png"
alt="Revisiting place and temporal theories of pitch, Andrew J. Oxenham, Acoust Sci Technol. 2013; 34(6): 388–396." />
<figcaption aria-hidden="true">Revisiting place and temporal theories of
pitch, Andrew J. Oxenham, Acoust Sci Technol. 2013; 34(6):
388–396.</figcaption>
</figure>

## 2D plots of variance searching ???

## Gabor reed oscillisciope figure

<figure>
<img src="man/scrapbook/gabor_reeds.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

## Gabor words about artifical flipping

<figure>
<img src="man/scrapbook/gabor_artificial.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

What is S-B variance?

## Gabor Elemtary Signal

<figure>
<img src="man/scrapbook/gabor_elementary_words.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

<figure>
<img src="man/scrapbook/gabor_elementary_gaussian.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

<figure>
<img src="man/scrapbook/gabor_elementary_wavelet.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

## Benedetto screenshot

<figure>
<img src="man/scrapbook/benedetto.png"
alt="Benedetto. (1990). Uncertainty principle inequalities and spectrum estimation. Recent Advances in Fourier Analysis and Its Applications (J. S. Bymes and J. L. Byrnes, eds.). Kluwer Acad. Publ., Dordrecht. MR 91i:94010" />
<figcaption aria-hidden="true">Benedetto. (1990). Uncertainty principle
inequalities and spectrum estimation. Recent Advances in Fourier
Analysis and Its Applications (J. S. Bymes and J. L. Byrnes, eds.).
Kluwer Acad. Publ., Dordrecht. MR 91i:94010</figcaption>
</figure>

## Stern-Brocot as probability waves

## Equation of freq and wavelength variance

## M3 variance search

## M6 variance search

## Harmonic results

## 5 Partials

## 5 Partials No 3

## Screenshot of feynman stretching consonance

[![Feynman Lecture 50 Audio from 24:20 to
28:20](man/scrapbook/feynman.png)](https://www.feynmanlectures.caltech.edu/I_50.html)

## Approximate LCD

### Corrupted Harmonics

<figure>
<img src="man/scrapbook/sreenivas1.png"
alt="Pitch extraction from corrupted harmonics of the power spectrum, T. V. Sreenivas and P. V. S. Rao, ComputerGroup, Tata Institute of Fundamental Research,Bombay–400 005, India (Received 22 November 1977; revised 16 July 1978)" />
<figcaption aria-hidden="true">Pitch extraction from corrupted harmonics
of the power spectrum, T. V. Sreenivas and P. V. S. Rao, ComputerGroup,
Tata Institute of Fundamental Research,Bombay–400 005, India (Received
22 November 1977; revised 16 July 1978)</figcaption>
</figure>

<figure>
<img src="man/scrapbook/sreenivas2.png"
alt="Pitch extraction from corrupted harmonics of the power spectrum, T. V. Sreenivas and P. V. S. Rao, ComputerGroup, Tata Institute of Fundamental Research,Bombay–400 005, India (Received 22 November 1977; revised 16 July 1978)" />
<figcaption aria-hidden="true">Pitch extraction from corrupted harmonics
of the power spectrum, T. V. Sreenivas and P. V. S. Rao, ComputerGroup,
Tata Institute of Fundamental Research,Bombay–400 005, India (Received
22 November 1977; revised 16 July 1978)</figcaption>
</figure>

### Automotive Engine Harmonics

<figure>
<img src="man/scrapbook/amman.png"
alt="IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 48, NO. 1, FEBRUARY 2001 225 An Efficient Technique for Modeling and Synthesis of Automotive Engine Sounds Scott A. Amman and Manohar Das, Member, IEEE" />
<figcaption aria-hidden="true">IEEE TRANSACTIONS ON INDUSTRIAL
ELECTRONICS, VOL. 48, NO. 1, FEBRUARY 2001 225 An Efficient Technique
for Modeling and Synthesis of Automotive Engine Sounds Scott A. Amman
and Manohar Das, Member, IEEE</figcaption>
</figure>

### Moving Targets

<figure>
<img src="man/scrapbook/huang.png"
alt="IEEE TRANSACTIONS ON INSTRUMENTATION AND MEASUREMENT, VOL. 63, NO. 2, FEBRUARY 2014 267, A Practical Fundamental Frequency Extraction, Algorithm for Motion Parameters Estimation of Moving Targets, Jingchang Huang, Xin Zhang, Qianwei Zhou, Enliang Song, and Baoqing Li" />
<figcaption aria-hidden="true">IEEE TRANSACTIONS ON INSTRUMENTATION AND
MEASUREMENT, VOL. 63, NO. 2, FEBRUARY 2014 267, A Practical Fundamental
Frequency Extraction, Algorithm for Motion Parameters Estimation of
Moving Targets, Jingchang Huang, Xin Zhang, Qianwei Zhou, Enliang Song,
and Baoqing Li</figcaption>
</figure>

## Stretched

## Compressed

## Screenshot of Attention / inhibition studies

## Bonang

## Pure

## P8

## picture of concentric circles of N, Q, R, C numbers

## Gabor wavelets are “found” in neuron resreach

## screenshot of Gabor wavelet not being strictly local

but S-B is strictly local

## Back to Zarlino and Rameau

show ratios that are octave complements

## Double slit experiment

## Quantum Consonance Perception

### Angular Frequency

A fourier transform from wavenumber to angular frequency.

$$\psi(\omega, t) = \int \phi(k) e^{-i \left( \omega t - k x \right) } dk$$

### Wavenumber

A fourier transform from angular frequency to wavenumber.

$$\phi(k, t) = \int \psi(\omega, t) e^{-i \left( k x \right) } d\omega$$

### Uncertainty

The model is quantized and uncertainty introduced when transforming
wavelength and frequency ratios to rational fractions using the
Stern-Brocot tree with variance $\sigma^2$. In our model, the more we
know about the wavelength of a wave, the less we know about its
frequency.  

$$\lambda=\frac{2 \pi}{k}$$

$$f=\frac{\omega}{2 \pi}$$

$${\sigma_f}^2 {\sigma_\lambda}^2 \ge \frac{1} {16 \pi^2}$$

The uncertainty equality holds if the underlying function is normalized
to 1, like a probability distribution.  

Following Stolzenberg, our model uses the Stern-Brocot tree to
approximate rational fractions within a given variance. In that sense
the values are zero outside the variance and the probability of finding
an approximation is 100%. So we will assume the equality condition is
met, so that:  

$${\sigma_f}^2 {\sigma_\lambda}^2 = \frac{1} {16 \pi^2}$$

When wavelength and frequency variance are the same:  

$$\sigma^2 = {\sigma_f}^2 = {\sigma_\lambda}^2$$

We have:  

$$\sigma^2 = \sqrt{\frac{1} {16 \pi^2}} = \frac{1}{4 \pi} \approx 0.08$$

#### Some Thoughts on Uncertainty

Uncertainty in our model is not the time duration and frequency
uncertainty $\Delta t \Delta f \simeq 1$ of Gabor or Wiener’s famous
quantum physics and music analogy. If in Gabor (1946) Fig. 1.4 (b) the
bank of reeds measured wavelengths in a stationary state at $t=0$
instead of frequencies then his 2D model would be akin to ours. Our
model is frequency and wavelength  
uncertainty $\Delta f \Delta \lambda$, closer to the original quantum
ideas of Einstein and de Broglie.  

$$\lambda=\frac{2 \pi}{k}=\frac{h}{p}$$

$$f=\frac{\omega}{2 \pi}=\frac{E}{h}$$

#### Computing Fundamental Wavelength and Fundamental Frequency of a Chord

Consider a $100$ Hz wave with $3$ harmonics:

$f_i=100.00, 200.00, 300.00$ Hz  

If we put those waves in a medium with a wave speed of

$c = max(f) * min(f) = 3\times 10^{4}$

for an infinitely long time then the range of values for the wavelengths
$\lambda = \frac{c}{f}$ will be the same as the range for the
frequencies:

$\lambda_i=300.00, 150.00, 100.00$ m  

Lets calculate the overall cycle of the whole wave with harmonics twice,
using a traditional signal processing technique. We will find the
frequency and wavelength ratios as rational fractions using the
Stern-Brocot tree with variances at the Heisenberg limit and then
compute the least common denominator (LCD) for each. Using the LCD we
will find the overall cycle.  

But a quick glance at the normalized wavelength and frequency values,
above, will show us that we are headed for a disagreement: the
denominators of those ratios will not be the same (even with complete
precision) and ultimately we will have two different values for the
overall cycle.  

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
The disagreement seems to be a fundamental difference in the way the
pattern would be perceived between wavelength and frequency sensors.
This disagreement at the level of pattern recognition of the combined
wave is not the same as the uncertainty between the wavelength and
frequency of each partial in the wave, above.  

## How MaMi.CoDi is Implemented

\### The Math

#### Traveling Waves

$$s_{i}(x, t) = \sin \left( \frac{2\pi x}{\lambda_{i}} - 2 \pi f_{i} t \right)$$
$N$ is the number of traveling waves in the chord.

$$i=1...N$$

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

### Difference between Stern-Brocot Rational Fraction Approximations and Floating Point Values

![](man/figures/README-unnamed-chunk-15-1.png)<!-- -->  
Number of Samples: 1,000,000  

[Additional Stern-Brocot Plots](/man/thoughts/SternBrocotCurve.md)

The Stern-Brocot curve is a repeatable, deterministic curve of where
rational fractions exist or do not exist within a given variance.  

However, the value is 0 outside $\pm \sigma^{2}$ and the area of the
curve equals one so that we can use it like a probability density
function. 

When I see the shape of this curve of rational numbers at the Heisenberg
limit I can’t help but think about the double-slit experiment and chance
versus determinism, in general.  

Perhaps things are quantized but not probabilistic?  

Maybe God does not play dice with the universe. Whatever the game, God
keeps score with rational fractions at the Heisenberg limit.  

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
| 0.03              | 0.21109          |             0.2 |

![](man/figures/README-unnamed-chunk-18-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-5.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-18-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-10.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-18-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-12.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-15.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-18-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-18.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-20.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.03979           | 0.15915          |             0.2 |

![](man/figures/README-unnamed-chunk-18-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-24.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-25.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-18-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-30.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-18-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-35.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-18-36.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-40.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-18-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-42.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-44.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-45.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-18-46.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-47.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-48.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-49.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-50.png)<!-- -->

##### P8ZoomedTemporal ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(temporal) is akin to shutting off the other (spatial).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 5e-05             | 126.65148        |           0.035 |

![](man/figures/README-unnamed-chunk-18-51.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-52.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-53.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-54.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-55.png)<!-- -->

##### P8ZoomedSpatial ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(spatial) is akin to shutting off the other (temporal).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 126.65148         | 5e-05            |           0.035 |

![](man/figures/README-unnamed-chunk-18-56.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-57.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-58.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-59.png)<!-- -->  
![](man/figures/README-unnamed-chunk-18-60.png)<!-- -->

### Manipulating amplitudes

##### Harmonic ~ Roll Off: 12

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.013         |             0.2 |

![](man/figures/README-unnamed-chunk-22-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-22-2.png)<!-- -->

##### Harmonic ~ Roll Off: 7

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.08          |             0.2 |

![](man/figures/README-unnamed-chunk-22-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-22-4.png)<!-- -->

##### Harmonic ~ Roll Off: 2

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0             |             0.2 |

![](man/figures/README-unnamed-chunk-22-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-22-6.png)<!-- -->

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
