MaMi.CoDi: A Model of Harmony Perception
================

# Harmony Perception Overview

Below is a schematic diagram of the MaMi.CoDi model of harmony
perception.

<figure>
<img src="man/scrapbook/schematic_diagram.png"
alt="Schematic Diagrm of Harmony Perception" />
<figcaption aria-hidden="true">Schematic Diagrm of Harmony
Perception</figcaption>
</figure>

# The Traveling Wave

$$e ^ {-i \left( \omega t - k x \right)}$$

# Wavelengths

Consider the fundamental tone of middle C playing from $t=-\infty$ to
$t=\infty$.

Assuming room temperature air at sea level, the wavelength $\lambda$ is
1.31m.

![](man/figures/README-unnamed-chunk-2-1.png)<!-- -->

The human cochlea is $\sim 33 mm$ long.

<figure>
<img src="man/scrapbook/reichenbach_cochlea.png"
alt="The physics of hearing: fluid mechanics and the active process of the inner ear, Tobias Reichenbach and A J Hudspeth 2014 Rep. Prog. Phys. 77 076601" />
<figcaption aria-hidden="true">The physics of hearing: fluid mechanics
and the active process of the inner ear, Tobias Reichenbach and A J
Hudspeth 2014 Rep. Prog. Phys. 77 076601</figcaption>
</figure>

How does a 1.3m wave fit in the cochlea?

<figure>
<img src="man/scrapbook/reichenbach_wave.png"
alt="The physics of hearing: fluid mechanics and the active process of the inner ear, Tobias Reichenbach and A J Hudspeth 2014 Rep. Prog. Phys. 77 076601" />
<figcaption aria-hidden="true">The physics of hearing: fluid mechanics
and the active process of the inner ear, Tobias Reichenbach and A J
Hudspeth 2014 Rep. Prog. Phys. 77 076601</figcaption>
</figure>

## t=0

If we freeze time at $t=0$, then we have a plane wave:

$$e ^ {i k x}$$

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

## t=0+deltas

If we briefly unfreeze time for a few times $t=0+0\delta$,
$t=0+1\delta$, $t=0+2\delta$, $t=0+3\delta$ we get a changes of phase.
Our uncertainty increases.

<figure>
<img src="man/scrapbook/bekesy.png"
alt="Elizabeth S. Olson, Hendrikus Duifhuis, Charles R. Steele, Von Békésy and cochlear mechanics, Hearing Research, Volume 293, Issues 1–2, 2012, Pages 31-43" />
<figcaption aria-hidden="true">Elizabeth S. Olson, Hendrikus Duifhuis,
Charles R. Steele, Von Békésy and cochlear mechanics, Hearing Research,
Volume 293, Issues 1–2, 2012, Pages 31-43</figcaption>
</figure>

<figure>
<img src="man/scrapbook/loeb.png"
alt="Loeb, G.E., White, M.W. and Merzenich, M.M., Spatial cross-correlation: a proposed mechanism for acoustic pitch perception, Biol. Cybern., 47 (1983) 149-163." />
<figcaption aria-hidden="true">Loeb, G.E., White, M.W. and Merzenich,
M.M., Spatial cross-correlation: a proposed mechanism for acoustic pitch
perception, Biol. Cybern., 47 (1983) 149-163.</figcaption>
</figure>

# Frequencies

Imagine an oscilloscope attached to every hair cell bundle, each $x$
position.

When $t=0$ there is no time. So there is no frequency. We have complete
uncertainty.

## x=0

$$e ^ {-i \left( \omega t\right)}$$

For a fixed location, say $x=0$ is the hair cell bundle with resonant
frequency at 300 Hz, we will have a better idea about frequency as time
unfolds.

<figure>
<img src="man/scrapbook/rudnicki.png"
alt="Cell Tissue Res (2015) 361:159–175 DOI 10.1007/s00441-015-2202-z Modeling auditory coding: from sound to spikes Marek Rudnicki, Oliver Schoppe, Michael Isik, Florian Volk, Werner Hemmert" />
<figcaption aria-hidden="true">Cell Tissue Res (2015) 361:159–175 DOI
10.1007/s00441-015-2202-z Modeling auditory coding: from sound to spikes
Marek Rudnicki, Oliver Schoppe, Michael Isik, Florian Volk, Werner
Hemmert</figcaption>
</figure>

<figure>
<img src="man/scrapbook/winter.png"
alt="Winter, I.M., 2005. The neurophysiology of pitch. In: Plack, C.J., Oxenham, A.J., Fay, R.R., Popper, A.N. (Eds.), Pitch: Neural Coding and Perception. Springer, New York, NY, p. 364." />
<figcaption aria-hidden="true">Winter, I.M., 2005. The neurophysiology
of pitch. In: Plack, C.J., Oxenham, A.J., Fay, R.R., Popper, A.N.
(Eds.), Pitch: Neural Coding and Perception. Springer, New York, NY,
p. 364.</figcaption>
</figure>

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

# 2D: Wavelengths and Frequencies

## Shamma

<figure>
<img src="man/scrapbook/shamma.png"
alt="S. Shamma On the role of space and time in auditory processing, Trends Cogn. Sci., 5 (2001), pp. 340-348" />
<figcaption aria-hidden="true">S. Shamma On the role of space and time
in auditory processing, Trends Cogn. Sci., 5 (2001),
pp. 340-348</figcaption>
</figure>

## Oxenham

<figure>
<img src="man/scrapbook/oxenham.png"
alt="Revisiting place and temporal theories of pitch, Andrew J. Oxenham, Acoust Sci Technol. 2013; 34(6): 388–396." />
<figcaption aria-hidden="true">Revisiting place and temporal theories of
pitch, Andrew J. Oxenham, Acoust Sci Technol. 2013; 34(6):
388–396.</figcaption>
</figure>

## Gabor

<figure>
<img src="man/scrapbook/gabor_reeds.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

# Uncertainty

<figure>
<img src="man/scrapbook/gabor_artificial.png"
alt="Gabor, D. (1946). Theory of communication. Part 1: the analysis of information. Electrical Engineers-Part III: Journal of the Institution of Radio and Communication Engineering, 93(26), 429–441." />
<figcaption aria-hidden="true">Gabor, D. (1946). Theory of
communication. Part 1: the analysis of information. Electrical
Engineers-Part III: Journal of the Institution of Radio and
Communication Engineering, 93(26), 429–441.</figcaption>
</figure>

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

<figure>
<img src="man/scrapbook/benedetto.png"
alt="Benedetto. (1990). Uncertainty principle inequalities and spectrum estimation. Recent Advances in Fourier Analysis and Its Applications (J. S. Bymes and J. L. Byrnes, eds.). Kluwer Acad. Publ., Dordrecht. MR 91i:94010" />
<figcaption aria-hidden="true">Benedetto. (1990). Uncertainty principle
inequalities and spectrum estimation. Recent Advances in Fourier
Analysis and Its Applications (J. S. Bymes and J. L. Byrnes, eds.).
Kluwer Acad. Publ., Dordrecht. MR 91i:94010</figcaption>
</figure>

$${\sigma_f}^2 {\sigma_\lambda}^2 \ge \frac{1} {16 \pi^2}$$

The uncertainty equality holds if the wave functions behave like a
sinusoidal gaussian.  

$${\sigma_f}^2 {\sigma_\lambda}^2 = \frac{1} {16 \pi^2}$$

When wavelength and frequency variance are the same:  

$$\sigma^2 = {\sigma_f}^2 = {\sigma_\lambda}^2$$

We have:  

$$\sigma^2 = \sqrt{\frac{1} {16 \pi^2}} = \frac{1}{4 \pi} \approx 0.08$$

Otherwise the variances are constrained by the relationship:

$${\sigma_f}^2 = \frac{\frac{1} {16 \pi^2}}{{\sigma_\lambda}^2} \approx \frac{0.006}{{\sigma_\lambda}^2}$$

# Computing Fundamentals

### Least Common Denominator of Ratios

<figure>
<img src="man/scrapbook/sundararajan.png"
alt="D. Sundararajan, Fourier Analysis—A Signal Processing Approach, 2018" />
<figcaption aria-hidden="true">D. Sundararajan, Fourier Analysis—A
Signal Processing Approach, 2018</figcaption>
</figure>

## Fundamental Frequency

$$f_{0} = \frac{f_{min}}{{ LCD}\left(r_{f 1},..., r_{f N}\right)}$$
$LCD()$ is the least common denominator.  

$$r_{f i} = \frac{f_{i}}{f_{min}} \pm \sigma_{f}^{2} = \frac{a_{i}}{b_{i}}$$

$\sigma^2$ is the tolerance for converting a real number into a rational
fraction. Later we will treat the Stern-Brocot function as a strictly
localized probability distribution with variance $\sigma^2$.

$${GCD}(a_{i}, b_{i}) = 1$$

$GCD()$ is the greatest common divisor.  

## Fundamental Wavelength

$$\lambda_{0} = \lambda_{max} { LCD}\left(r_{\lambda 1},..., r_{\lambda N}\right)$$

$$r_{\lambda i} = \frac{\lambda_{i}}{\lambda_{min}} \pm \sigma_{\lambda}^{2} = \frac{c_{i}}{d_{i}}$$

$${ GCD}(c_{i}, d_{i}) = 1$$

## Least Common Denominator as Relative Periodicity

<figure>
<img src="man/scrapbook/stolzenburg.png"
alt="Harmony Perception by Periodicity Detection∗ Frieder Stolzenburg, Journal of Mathematics and Music, 9(3):215–238, 2015" />
<figcaption aria-hidden="true">Harmony Perception by Periodicity
Detection∗ Frieder Stolzenburg, Journal of Mathematics and Music,
9(3):215–238, 2015</figcaption>
</figure>

# Stern-Brocot

## Stern-Brocot as Rational Number Finder

[![Number Systems Adapted from
Wikipedia](man/scrapbook/numbers.png)](https://en.wikipedia.org/wiki/Rational_number)

<figure>
<img src="man/scrapbook/forisek.png"
alt="Approximating Rational Numbers by Fraction, Michal Forisek, Fun with Algorithms, 4th International Conference, FUN 2007 Castiglioncello, Italy, June 2007 Proceedings" />
<figcaption aria-hidden="true">Approximating Rational Numbers by
Fraction, Michal Forisek, Fun with Algorithms, 4th International
Conference, FUN 2007 Castiglioncello, Italy, June 2007
Proceedings</figcaption>
</figure>

## Stern-Brocot as Strictly Localized Probability Distribution

![](man/figures/README-unnamed-chunk-10-1.png)<!-- -->  
Number of Samples: 1,000,000  
Number of Bins: 21  
[Additional Stern-Brocot Plots](/man/thoughts/SternBrocotCurve.md)

## Some Thoughts on Uncertainty

### An Evolution of Gabor Uncertainty

While Gabor’s analogy to Heisenberg’s uncertainty was innovative in its
application to signal processing, it is important to note that
Heisenberg’s uncertainty applies to a purely spatial component
(position) and a time-dependent component (momentum). Gabor’s framework,
however, modifies this principle such that both variables are temporal:
a purely temporal component (time) and a time-dependent component
(frequency), inviting us to re-explore the power and applicability of
this analogy.

”… daß kanonisch konjugierte Größen simultan nur mit einer
charakteristischen Ungenauigkeit bestimmt werden können.” — Heisenberg
(”… that canonically conjugate quantities can only be determined
simultaneously with a characteristic uncertainty.”)

In his borrowing of the principle for signal processing, Gabor’s idea of
time (as one component of the uncertainty pair) is actually closer to
Heisenberg’s idea of observational simultaneity: for Heisenberg, elapsed
time was not one of the components of the conjugate pair but instead
framed the observation.

In contrast to Gabor, our model returns to the original spirit of
Heisenberg’s principle, describing an uncertainty relation that involves
a purely spatial component (wavelength) and a time-dependent component
(frequency) in the context of a sample interval, $\Delta t$. This brings
us closer to the original insights of Heisenberg by maintaining the
trade-off between a purely spatial and a time-dependent conjugate pair.

By combining spatial and temporal uncertainties in a way that aligns
more closely with Heisenberg’s original intent, our model introduces
wavelength as a spatial counterpart to frequency. This provides a novel
uncertainty framework for classical systems governed by wave behavior.

The MaMi.CoDi model is quantized and uncertainty introduced when
transforming wavelength and frequency ratios to rational fractions using
the Stern-Brocot tree with variance $\sigma^2$. In our model, the more
we know about the wavelength of a wave, the less we know about its
frequency.  

$$\lambda=\frac{2 \pi}{k}$$

$$f=\frac{\omega}{2 \pi}$$

Uncertainty in our model is not the time duration and frequency
uncertainty $\Delta t \Delta f \simeq 1$ of Gabor or Wiener’s famous
quantum physics and music analogy. If in Gabor (1946) Fig. 1.4 (b) the
bank of reeds measured wavelengths in a stationary state at $t=0$
instead of frequencies then his 2D model would be akin to ours. Our
model is frequency and wavelength uncertainty $\Delta f \Delta \lambda$
that is mediated by $\Delta t$, closer to the original quantum ideas of
Einstein and de Broglie.  

$$\lambda=\frac{2 \pi}{k}=\frac{h}{p}$$

$$f=\frac{\omega}{2 \pi}=\frac{E}{h}$$

## 2D Variance Searches

<figure>
<img src="man/scrapbook/Harmonic2D.png" alt="2D Variance Searches" />
<figcaption aria-hidden="true">2D Variance Searches</figcaption>
</figure>

## M3 Variance Search: Frequency and Wavelength Equal

<figure>
<img src="man/scrapbook/M3VarianceSearch.png"
alt="M3 Variance Search - Equal Values" />
<figcaption aria-hidden="true">M3 Variance Search - Equal
Values</figcaption>
</figure>

## M3 Variance Search: Frequency and Wavelength Equal

<figure>
<img src="man/scrapbook/M6VarianceSearch.png"
alt="M6 Variance Search - Equal Values" />
<figcaption aria-hidden="true">M6 Variance Search - Equal
Values</figcaption>
</figure>

# Stretching and Compressing

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

![IEEE TRANSACTIONS ON INSTRUMENTATION AND MEASUREMENT, VOL. 63, NO. 2,
FEBRUARY 2014 267, A Practical Fundamental Frequency Extraction,
Algorithm for Motion Parameters Estimation of Moving Targets, Jingchang
Huang, Xin Zhang, Qianwei Zhou, Enliang Song, and Baoqing
Li](man/scrapbook/huang1.png) ![IEEE TRANSACTIONS ON INSTRUMENTATION AND
MEASUREMENT, VOL. 63, NO. 2, FEBRUARY 2014 267, A Practical Fundamental
Frequency Extraction, Algorithm for Motion Parameters Estimation of
Moving Targets, Jingchang Huang, Xin Zhang, Qianwei Zhou, Enliang Song,
and Baoqing Li](man/scrapbook/huang2.png)

# Attention

<figure>
<img src="man/scrapbook/cohen.png"
alt="Attention improves performance primarily by reducing interneuronal correlations, Marlene R Cohen &amp; John H R Maunsell, VOLUME 12 | NUMBER 12 | december 2009 nature NEUROSCIENCE" />
<figcaption aria-hidden="true">Attention improves performance primarily
by reducing interneuronal correlations, Marlene R Cohen &amp; John H R
Maunsell, VOLUME 12 | NUMBER 12 | december 2009 nature
NEUROSCIENCE</figcaption>
</figure>

<figure>
<img src="man/scrapbook/bernardino.png"
alt="A Real-Time Gabor Primal Sketch for Visual Attention, IBPRIA - 2nd Iberian Conference on Pattern Recognition and Image Analysis, Estoril, Portugal, June 7-9, 2005" />
<figcaption aria-hidden="true">A Real-Time Gabor Primal Sketch for
Visual Attention, IBPRIA - 2nd Iberian Conference on Pattern Recognition
and Image Analysis, Estoril, Portugal, June 7-9, 2005</figcaption>
</figure>

# Gabor Signals in Neuroscience

<figure>
<img src="man/scrapbook/daugman.png"
alt="Vision Res. Vol. 24, No. 9. pp. 891-910. 1984, SPATIAL VISUAL CHANNELS IN THE FOURIER PLANE, JOHN G. DAUGMAN, Harvard University, Division of Applied Sciences, Cambridge. ,MA 02 138, U.S.A" />
<figcaption aria-hidden="true">Vision Res. Vol. 24, No. 9. pp. 891-910.
1984, SPATIAL VISUAL CHANNELS IN THE FOURIER PLANE, JOHN G. DAUGMAN,
Harvard University, Division of Applied Sciences, Cambridge. ,MA 02 138,
U.S.A</figcaption>
</figure>

# Behavioral

## Manipulating Harmonic Frequencies

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

![](man/figures/README-unnamed-chunk-13-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-5.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-13-6.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-10.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-13-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-12.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-15.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-13-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-18.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-20.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.03979           | 0.15915          |             0.2 |

![](man/figures/README-unnamed-chunk-13-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-24.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-25.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-13-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-30.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |             0.2 |

![](man/figures/README-unnamed-chunk-13-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-35.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-13-36.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-40.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-13-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-42.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-44.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-45.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 0.07958           | 0.07958          |           0.035 |

![](man/figures/README-unnamed-chunk-13-46.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-47.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-48.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-49.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-50.png)<!-- -->

##### P8ZoomedTemporal ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(temporal) is akin to shutting off the other (spatial).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 5e-05             | 126.65148        |           0.035 |

![](man/figures/README-unnamed-chunk-13-51.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-52.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-53.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-54.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-55.png)<!-- -->

##### P8ZoomedSpatial ~ Partials: 10

Due to the Heisenberg uncertainty principle, focusing on one signal
(spatial) is akin to shutting off the other (temporal).

| temporal_variance | spatial_variance | smoothing_sigma |
|:------------------|:-----------------|----------------:|
| 126.65148         | 5e-05            |           0.035 |

![](man/figures/README-unnamed-chunk-13-56.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-57.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-58.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-59.png)<!-- -->  
![](man/figures/README-unnamed-chunk-13-60.png)<!-- -->

### Manipulating amplitudes

##### Harmonic ~ Roll Off: 12

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.013         |             0.2 |

![](man/figures/README-unnamed-chunk-17-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-17-2.png)<!-- -->

##### Harmonic ~ Roll Off: 7

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0.08          |             0.2 |

![](man/figures/README-unnamed-chunk-17-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-17-4.png)<!-- -->

##### Harmonic ~ Roll Off: 2

| temporal_variance | spatial_variance | min_amplitude | smoothing_sigma |
|:------------------|:-----------------|:--------------|----------------:|
| 0.07958           | 0.07958          | 0             |             0.2 |

![](man/figures/README-unnamed-chunk-17-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-17-6.png)<!-- -->

# Some Videos

## Pure

[![Pure Wavelength and Frequency
Consonance](https://img.youtube.com/vi/Q24nZNuPuTU/0.jpg)](https://www.youtube.com/watch?v=Q24nZNuPuTU)

## Bonang

[![Bonang Wavelength and Frequency
Consonance](https://img.youtube.com/vi/UupIS6A6m0I/0.jpg)](https://www.youtube.com/watch?v=UupIS6A6m0I)

## Harmonic results

[![Harmonic Wavelength and Frequency
Consonance](https://img.youtube.com/vi/H3RO3NYzVJ8/0.jpg)](https://www.youtube.com/watch?v=H3RO3NYzVJ8)

## 5 Partials

[![5 Partials Wavelength and Frequency
Consonance](https://img.youtube.com/vi/zzvs3_MsIZQ/0.jpg)](https://www.youtube.com/watch?v=zzvs3_MsIZQ)

## 5 Partials No 3

[![5 Partials No 3 Wavelength and Frequency
Consonance](https://img.youtube.com/vi/ustqdAdhc_U/0.jpg)](https://www.youtube.com/watch?v=ustqdAdhc_U)

# Fourier Transform Between Wavelength and Frequency Probability Waves

A fourier transform from wavenumber to angular frequency.

$$\psi(\omega, t) = \int \phi(k) e^{-i \left( \omega t - k x \right) } dk$$

A fourier transform from angular frequency to wavenumber.

$$\phi(k, t) = \int \psi(\omega, t) e^{-i \left( k x \right) } d\omega$$

# Frequency and Wavelength Patterns

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

### The Math

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

![](man/figures/README-unnamed-chunk-51-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-52-1.png)<!-- -->

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

![](man/figures/README-unnamed-chunk-55-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-56-1.png)<!-- -->

##### Wavelength fractions

| index | num | den |   tone_m |     freq | midi | pseudo_rational_number |
|------:|----:|----:|---------:|---------:|-----:|-----------------------:|
|     1 |   4 |   3 | 1.311034 | 261.6256 |   60 |               1.259921 |
|     2 |   1 |   1 | 1.040568 | 329.6276 |   64 |               1.000000 |

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

![](man/figures/README-unnamed-chunk-61-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-62-1.png)<!-- -->

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

![](man/figures/README-unnamed-chunk-65-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-66-1.png)<!-- -->

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

![](man/figures/README-unnamed-chunk-71-1.png)<!-- -->

##### Chord Period

![](man/figures/README-unnamed-chunk-72-1.png)<!-- -->

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

![](man/figures/README-unnamed-chunk-75-1.png)<!-- -->

##### Chord Wavelength

![](man/figures/README-unnamed-chunk-76-1.png)<!-- -->

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

### Difference between Stern-Brocot Rational Fraction Approximations and Floating Point Values

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

\#’ We are dealing with frequency and wavelength ratios. The speed of
sound \#’ constant will disappear. We could estimate the speed of sound
as: \#’ \* room temperature air at sea level (343 m/s) \#’ \* the fluid
of the inner ear (1,522 m/s, ocean water at room temperature) \#’ \* the
basilar membrane (1,640 m/s, human cartilage) \#’ No matter which one we
pick we will get the same consonance results. \#’ \#’ For giggles,
though, consider a speed of sound that normalizes the range of \#’ the
two signals: \#’ \#’ c_sound = max(f) \* min(f) \#’ \#’ For a pitch with
a 100Hz fundamental and 10 harmonics, our speed of sound would be: \#’
\#’ c_sound = 1000 \* 100 -\> 1e+05 \#’ \#’ That is a fast material. The
advantage, though, for our analysis is that our \#’ wavelength and
frequency numbers have the same range. \#’ \#’ frequencies: 100 200 300
400 500 600 700 800 900 1000 \#’ fractions f/f_min: 1/1 2/1 3/1 4/1 5/1
6/1 7/1 8/1 9/1 10/1 \#’ LCD: 1 \#’ \#’ wavelengths = l = c_sound / f
\#’ wavelengths: 100 111.11 125.00 142.85 166.66 200.00 250.00 333.33
500.00 1000 \#’ fractions l/l_min: 1/1 7/6 5/4 3/2 5/3 2/1 5/2 10/3 5/1
10/1 \#’ LCD: 12 \#’ \#’ The frequency and wavelength vectors have the
same range 100 to 1,000 but \#’ only 4 of the same values: 100, 200, 500
and 1,000. The other 6 values are \#’ different. And so the pattern
recognition machinery of the auditory system, \#’ which we approximate
with the LCD, will perceive different cycle lengths: \#’ 1 cycle for
frequencies but 12 cycles for wavelengths. \#’ \#’ Many of the
wavelength ratios will look familiar to those who know their \#’ just
intoned music intervals. However, the familiar ratios are not for the
\#’ familiar intervals \#’ For example, 5/4 is the major third ratio of
the high fundamental frequency \#’ relative to the low fundamental
frequency. However, 5/4 above is \#’ the ratio of the 8th harmonic’s
wavelength relative to the 10th harmonic’s \#’ wavelength. And the ratio
isn’t just an approximation: \#’ 125.00 / 100.00 is precisely 5 / 4. \#’
\#’ The two cycle estimates for the same set of harmonics are different.
\#’ Because the wavelength values were precisely calculated from the
frequency \#’ values, our model indicates that the disparity in the two
estimates isn’t the \#’ result of a lack of precision from the hair cell
locations of the basilar \#’ membrane or the phase-locking speed of the
auditory neurons. \#’ \#’ Instead, the difference in cycle estimates
seems be a fundamental uncertainty \#’ that is built into the conjugate
relationship between frequencies \#’ and wavelengths. See Gabor 1946.
\#’ \#’ see: \#’
<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6662181/#>:~:text=The%20speed%20of%20sound%20in,%2Fs)%20for%20image%20reconstruction.
\#’
<https://itis.swiss/virtual-population/tissue-properties/database/acoustic-properties/speed-of-sound/>
\#’ <https://www.engineeringtoolbox.com/sound-speed-water-d_598.html>
\#’ <https://www.engineeringtoolbox.com/air-speed-sound-d_603.html> \#’
