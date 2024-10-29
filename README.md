MaMi.CoDi: A Model of Harmony Perception
================

# Harmony Perception Overview

![](man/scrapbook/harmony_perception_schematic.png)

(The information design of this diagram is intended as a respectful
homage to a hero, [Claude
Shannon](https://en.wikipedia.org/wiki/Claude_Shannon), and his seminal
work [The Mathematical Theory of
Communication](https://www.google.com/books/edition/The_Mathematical_Theory_of_Communication/IZ77BwAAQBAJ).)

## 2D Harmony: Major-Minor and Consonance-Dissonance

``` math
\mathbf{H} = (h_f - h_\lambda) \mathbf{i} + (h_f + h_\lambda) \mathbf{j}
```

``` math
\mathbf{H_{{P1}_{pure}}} = 0 \mathbf{i} + 0 \mathbf{j} \ Sz
```

``` math
\mathbf{H_{{M3}_{10}}} = 2.32 \mathbf{i} + 9.49 \mathbf{j} \ Sz
```

``` math
\mathbf{H_{{m3}_{10}}} = -2.32 \mathbf{i} + 9.49 \mathbf{j} \ Sz
```

\[Introducing Stolzenburgs (Sz), a psychophysical unit of perceived
dissonance.\]

``` math
{MaMi} = (h_f - h_\lambda)
```

``` math
{CoDi} = (h_f + h_\lambda)
```

``` math
p(x,t) = \sum_{n=1}^{N} A_n(x,t) e^{-i \left( 2 \pi n f t - \frac{2 \pi n}{\lambda} x \right)}
```

``` math
h_f = \log_2 \left( \text{LCD}\left( \left\{ \frac{f_n}{f_{\text{min}}} \pm \sigma_t \sigma_f \right\}_{n=1}^{N} \right) \right)
```

``` math
h_\lambda = \log_2 \left( \text{LCD}\left( \left\{ \frac{\lambda_n}{\lambda_{\text{min}}} \pm \sigma_x \sigma_\lambda \right\}_{n=1}^{N} \right) \right)
```

## 2D Signals: Space-Time and Wavelength-Frequency

In signal processing, the fundamental frequency of a set of frequencies
$f_1, \ldots, f_N$ is determined by the formula
$\text{GCD}(f_1, \ldots, f_N) / \text{LCD}(f_1, \ldots, f_N)$. We apply
this principle in multiple ways. First, following Stolzenburg, we treat
the log of the least common denominator (LCD) component as a
psychophysical quantity, measured in a unit we introduce called
Stolzenburg (Sz), to quantify dissonance perception.

Since our model uses ratios that always include one of the partials in
the denominator, the greatest common divisor (GCD) is always unity. By
multiplying $1/\text{LCD}$ by a reference tone’s frequency or wavelength
we can derive the fundamental frequency or the fundamental wavelength of
the complex wave. When the fundamental values $f_0$ or $\lambda_0$ are
converted to a common dimension (e.g., temporal period, $T$), they will
not necessarily provide the same value. That is to say, spatial and
temporal measures of the cycle length of a complex wave will usually be
different, even when uncertainty is zero. We identify this inherent
difference (or modulation) as the source of major-minor tonality
perception.

Consider the case of a 1 Hz wave with three harmonics, where
$f = 1, 2, 3$ Hz. The least common denominator (LCD) of the frequency
ratios is given by

``` math
\text{LCD}\left(\frac{1}{1}, \frac{2}{1}, \frac{3}{1}\right) = 1
```

For simplicity, assume natural units where the speed of sound
$c_{\text{sound}} = 1$ m/s. The wavelengths are
$\lambda = \frac{1}{1}, \frac{1}{2}, \frac{1}{3}$ with
$\lambda_{\text{min}} = \frac{1}{3}$. Now, calculating

``` math
\text{LCD}\left( \frac{1}{1/3}, \frac{1/2}{1/3}, \frac{1/3}{1/3} \right) = \text{LCD}\left(\frac{3}{1}, \frac{3}{2}, \frac{1}{1}\right) = 2
```

Thus, even with three harmonics that can be easily expressed as rational
fraction ratios for frequency and wavelength, we obtain two different
estimates of cycle length of the complex wave.

The temporal cycle estimate is
$log_2(\text{LCD}_f) = \log_2(1) = 0 \ \text{Sz}$, and the spatial cycle
estimate is $log_2(\text{LCD}_\lambda) = log_2(2) = 1 \ \text{Sz}$.

We believe that these space-time discrepancies in cycle length are the
source of major-minor tonality perception.

### Uncertainty

Our approach must also address two issues concerning uncertainty. The
first challenge is that our GCD/LCD approach necessitates rational
fractions. If we only considered just-intoned intervals that would not
be a problem. But our model will accommodate equal-tempered intervals,
micro-tuning, and timbre manipulation. We will need to convert real
numbers into rational fractions. To accomplish this, we introduce a
controlled measure of uncertainty to find a rational fraction that
approximates the actual number.

The second uncertainty issue stems from the nature of waves and auditory
processing: the auditory system transforms stimuli signals from the
space-time physical domain into the space-time frequency domain.

> ”… daß kanonisch konjugierte Größen simultan nur mit einer
> charakteristischen Ungenauigkeit bestimmt werden können.” — Heisenberg
>
> (… that canonically conjugate quantities can only be determined
> simultaneously with a characteristic uncertainty.)

Accurately modeling this transformation requires accounting for Gabor
uncertainty in both the time-frequency and space-wavelength forms. When
addressing similar uncertainty constraints in quantum mechanics, Max
Born introduced the probabilistic interpretation of the wave function,
linking the wave amplitude to probability density. In our case, however,
we seek a deterministic model of cycle perception and aim to avoid
reliance on probabilistic interpretations. To approximate rational
fractions, Stolzenburg employed the Stern-Brocot tree, enabling rational
approximation within a relative deviation from a target number.
Following this method, we also use the Stern-Brocot tree, but apply
fixed deviations.

Remarkably, when aligning our model with extensive human behavioral data
on consonance perception, we found that the closest matches between
theory and experiment emerged at the product of the Gabor’s uncertainty
limit, $\frac{1}{4 \pi}$, for both the space-wavelength and
time-frequency uncertainties. If our model evaluated one frequency at a
time we would likely need to compute the $\Delta f$ from the $\Delta t$
(or the reverse) for each frequency partial and then the equivalent for
the space-wavelength uncertainty. But our model computes all the
partials as simultaneous ratios. One can imagine that whatever temporal
window $\Delta t$ was used to transform from time to frequency would be
accounted for in the uncertainty product $\Delta t \Delta x$. Therefore
it is not a surprise that it is this product that aligned best with the
experimental data.

Although we do not explicitly use the Fourier transform in our model, it
serves as a clear reminder of how uncertainty is introduced when
transitioning from the physical domain to the frequency domain.

``` math
F(f, \lambda) = \iint f(x, t) \, e^{-i \left(2 \pi f t - 2 \pi \frac{x}{\lambda}\right)} \, dx \, dt
```

``` math
\sigma_x \sigma_\lambda \geq \frac{1}{4 \pi}, \ \sigma_t\sigma_f \geq \frac{1}{4 \pi}
```

Note 1: We have previously considered each uncertainty
product—space-wavelength and time-frequency—as independent. However, in
a 2D space-time context, these uncertainties likely interrelate. Let’s
explore how they might connect.

Assuming that $\sigma_x$ is constant due to cochlear geometry, and that
$\sigma_t$ relates to the temporal window for recognizing repeating
patterns in complex waves, we might find that as $\sigma_t$ narrows,
$\sigma_\lambda$ decreases. This continues until $\Delta t = 0$,
allowing precise identification of the displaced inner hair cell for
each wave partial. Of course, the opposite is true for frequency. As
$\Delta t$ shrinks, frequency uncertainty grows.

Let’s start with a simple question whether the two uncertainty products
are equal to one another.

``` math
\frac{1}{4 \pi} = \sigma_x \sigma_\lambda \stackrel{?}{=} \sigma_t \sigma_f = \frac{1}{4 \pi}
```

Given the fixed spatial geometry of the cochlea, we set
$\sigma_x = \kappa_{cochlea}$. Considering the variability of
integration times used by the auditory system, we let
$\sigma_t \equiv \Delta t_{integration}$.

``` math
\Delta t_{integration} \propto \frac{\sigma_{\lambda}}{\sigma_f} \kappa_{cochlea}
```

As the integration time increases, both wavelength and frequency
uncertainty must change. A narrow window provides precise wavelength
information but poor frequency data, while a wider window yields more
frequency data at the expense of wavelength detail. Specifically, when
the temporal window increases, frequency uncertainty improves, while
wavelength uncertainty decreases.

After reviewing the literature, it seems that proofs for an uncertainty
principle emerging from the 2D spatiotemporal Fourier transform are
elusive. This remains an interesting area for future exploration.

Note 2: Based on the bimodal shape of the Stern-Brocot distribution
below, explore modeling the two-slit experiment using the deterministic
SB method instead of a probabilistic curve; consult Bohmian researchers,
who may find the Stern-Brocot’s deterministic approach relevant to
quantum mechanics.

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
alt="Loeb, G.E., White, M.W. and Merzenich, M.M., space cross-correlation: a proposed mechanism for acoustic pitch perception, Biol. Cybern., 47 (1983) 149-163." />
<figcaption aria-hidden="true">Loeb, G.E., White, M.W. and Merzenich,
M.M., space cross-correlation: a proposed mechanism for acoustic pitch
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
alt="Revisiting place and time theories of pitch, Andrew J. Oxenham, Acoust Sci Technol. 2013; 34(6): 388–396." />
<figcaption aria-hidden="true">Revisiting place and time theories of
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

$${\sigma_t} {\sigma_f} \ge \frac{1} {4 \pi}$$

$${\sigma_x} {\sigma_k} \ge \frac{1} {4 \pi}$$

We have:  

$$\frac{1}{4 \pi} \approx 0.08$$

Because we are dealing with ratios of an entire complex wave the
assertion is that we are accounting for the entire system. So for our
temporal uncertainty we use the uncertainty product at the limit:
${\sigma_t} {\sigma_f} = \frac{1} {4 \pi}$

And we do the same for our spatial uncertainty:
${\sigma_x} {\sigma_k} = \frac{1} {4 \pi}$

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
localized probability distribution with standard_deviation $\sigma^2$.

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
alt="Vision Res. Vol. 24, No. 9. pp. 891-910. 1984, space VISUAL CHANNELS IN THE FOURIER PLANE, JOHN G. DAUGMAN, Harvard University, Division of Applied Sciences, Cambridge. ,MA 02 138, U.S.A" />
<figcaption aria-hidden="true">Vision Res. Vol. 24, No. 9. pp. 891-910.
1984, space VISUAL CHANNELS IN THE FOURIER PLANE, JOHN G. DAUGMAN,
Harvard University, Division of Applied Sciences, Cambridge. ,MA 02 138,
U.S.A</figcaption>
</figure>

# Major-Minor Tonality

## Hypothesis

We aim to test whether humans identify major-minor tonality using only
the first two harmonics while framing the chord with an octave above or
below the tonic, depending on pitch direction.

For harmonic experiments, stimuli can frame the dyad within an octave,
allowing differentiation between M3 and m6, for example.

For melodic experiments, stimuli will present upward or downward pitch
contours, using the framing only in the model to compare results.

### Framed Dyads with 2 Harmonics

| Interval |  Majorness | Chord      | Dissonance |
|:---------|-----------:|:-----------|-----------:|
| M3       |  1.0000000 | 60, 64, 72 |   6.169925 |
| m6       | -1.0000000 | 60, 68, 72 |   6.169925 |
| M6       |  2.0000000 | 60, 69, 72 |   5.169925 |
| m3       | -2.0000000 | 60, 63, 72 |   5.169925 |
| P5       |  0.5849625 | 60, 67, 72 |   2.584963 |
| P4       | -0.5849625 | 60, 65, 72 |   2.584963 |
| P1       |  0.0000000 | 60, 60, 72 |   0.000000 |
| P8       |  0.0000000 | 60, 72, 72 |   0.000000 |
| tt       |  0.0000000 | 60, 66, 72 |   8.643856 |
| M7       | -1.0000000 | 60, 71, 72 |   6.169925 |
| m2       |  1.0000000 | 60, 61, 72 |   6.169925 |
| M2       | -2.3219281 | 60, 62, 72 |   6.321928 |
| m7       |  2.3219281 | 60, 70, 72 |   6.321928 |

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

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-1.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-2.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-3.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-4.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-5.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-6.png)<!-- -->

##### Harmonic ~ Partials: 10

For 10 harmonics, behavioral results and theoretical predictions agree.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-7.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-8.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-9.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-10.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-11.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-12.png)<!-- -->

##### 5Partials ~ Partials: 5

For 5 harmonics, behavioral results and theoretical predictions agree.
For comparison with the study below (5 partils with the third partial
deleted), notice that the m3 peak is only slightly lower than the M3
peak.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-13.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-14.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-15.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-16.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-17.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-18.png)<!-- -->

##### 5PartialsNo3 ~ Partials: 5

For 5 harmonics with the 3rd partial deleted, behavioral results and
theoretical predictions mostly agree. As expected, the m3 peak without
the third partial is now lower than the m3 peak with all 5 harmonics
while the M3 peak is slightly higher without the 3rd partial.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-19.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-20.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-21.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-22.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-23.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-24.png)<!-- -->

##### Bonang ~ Partials: 4

For gamalan dyads with a harmonic bass pitch and bonang upper pitch,
behavioral results and theoretical predictions mostly agree. MaMi.CoDi
predicts a dissonance trough with minor polarity at P4 that is not in
the behavioral results. MaMi.CoDi predicts P5 to have minor polarity and
be relatively higher than the behavioral results.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-25.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-26.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-27.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-28.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-29.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-30.png)<!-- -->

##### Stretched ~ Partials: 10

For stretched harmonics, behavioral results and theoretical predictions
mostly agree. MaMi.Codi predicts peaks with minor polarity just above m3
and m7 that do not exist in the behavioral results.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-31.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-32.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-33.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-34.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-35.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-36.png)<!-- -->

##### Compressed ~ Partials: 10

For compressed harmonics, the pronounced behavioral peaks mostly agree
with the theoretical peaks.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.2 | 2 |

![](man/figures/README-unnamed-chunk-15-37.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-38.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-39.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-40.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-41.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-42.png)<!-- -->

#### Dyads spanning 1 quarter tone

##### M3 ~ Partials: 10

Description is below.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.035 | 2 |

![](man/figures/README-unnamed-chunk-15-43.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-44.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-45.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-46.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-47.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-48.png)<!-- -->

##### M6 ~ Partials: 10

Description is below.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.035 | 2 |

![](man/figures/README-unnamed-chunk-15-49.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-50.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-51.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-52.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-53.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-54.png)<!-- -->

##### P8 ~ Partials: 10

Description is below.

| sfoae_num_harmonics | time_standard_deviation | space_standard_deviation | smoothing_sigma | pseudo_octave |
|---:|:---|:---|---:|---:|
| 10 | 0.07958 | 0.07958 | 0.035 | 2 |

![](man/figures/README-unnamed-chunk-15-55.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-56.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-57.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-58.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-59.png)<!-- -->  
![](man/figures/README-unnamed-chunk-15-60.png)<!-- -->

### Manipulating amplitudes

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
Stern-Brocot tree with standard_deviations at the Heisenberg limit and
then compute the least common denominator (LCD) for each. Using the LCD
we will find the overall cycle.  

But a quick glance at the normalized wavelength and frequency values,
above, will show us that we are headed for a disagreement: the
denominators of those ratios will not be the same (even with complete
precision) and ultimately we will have two different values for the
overall cycle.  

Frequency Ratios

| num | den |
|----:|----:|
|   2 |   1 |
|   3 |   1 |
|   1 |   1 |

Wavelength Ratios

| num | den |
|----:|----:|
|   3 |   2 |
|   3 |   1 |
|   1 |   1 |

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

space Consonance

$$C_{\lambda} = 50- \log_{2}\left({ ALCD}\left(r_{\lambda 1},..., r_{\lambda N}\right)\right)$$
time Consonance

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
signals along the auditory nerve. This space or rate-place arrangement
of hair cell positions and wavelengths of tones is known as tonotopy.  

### The Core Idea of MaMi.CoDi

If we play a chord, freeze time and observe which hair cells are
displaced, what are we observing? Are we observing frequencies? Periods?
No. Time is frozen. Frequency (1/s) and period (s) are time
observations. We are making a purely space observation about wavelengths
(m). We will come back to time observations shortly.  

When we combine all the component parts of a chord together into a
whole, we can estimate the overall wavelength for the whole chord. A
technique used in digital signal processing and bricklaying is to
estimate ratios (within an acceptable standard_deviation) between each
of the parts and a selected reference part. The greatest common divisor
(LCD) of those part ratios will be a measure of the periodicity of the
whole.  

Chords with short wavelengths relative to the component wavelengths
sound pleasant. And chords with long wavelengths relative to component
wavelengths sound unpleasant. MaMi.CoDi uses this measure of relative
wavelengths to predict the perceived space consonance of a chord.  

Let us unfreeze time and start counting how often a hair cell moves due
to a pure tone of our sounded chord. If we count the number of movements
relative to a certain amount of time, we will be observing the frequency
of the partial. This would be a time observation. The auditory system
has a property called phase locking which allows it to encode the time
intervals, periods, between spikes from sound waves.  

When we combine the period components of a chord together, we can
estimate the overall period for the whole chord. That chord period will
be as long as or longer than the longest component period of the chord.
Short relative periods sound pleasant. Long relative periods sound
unpleasant. MaMi.CoDi uses this measure of chord period to predict the
perceived time consonance of a chord.  

MaMi.CoDi sums the space and time consonance predictions to create an
overall consonance-dissonance prediction. MaMi.CoDi subtracts the space
consonance from the time consonance to create a major-minor polarity
prediction. Positive values will sound major, negative values minor and
values around zero will sound neutral.  

Because wavelength and frequency are inverse of each other one might
imagine that the space and time signals would have the same values.
However, for complex pitches that is not the case. The pattern of the
two sets of components are different. See the example of the major triad
with 5 harmonics, below.

# `{r, child=c('man/Space_Time_Cycles.Rmd')} #`

### Finding the standard_deviation Values

“One difficulty with distinguishing between place and time (or
place-time) models of pitch is that spectral and time representations of
a signal are mathematically equivalent: any change in the spectral
representation is reflected by a change in the time representation, and
vice versa . Discovering what the auditory system does means focusing on
the physiological limits imposed by the cochlea and auditory nerve.  

“For instance, the place theory can be tested using known limits of
frequency selectivity: if pitch can be heard when only unresolved
harmonics are presented (eliminating place information), then place
information is not necessary for pitch. Similarly, if all the
frequencies within a stimulus are above the upper limits of phase
locking, and the time envelope information is somehow suppressed, then
time information is not necessary for pitch perception.”  

from “Revisiting place and time theories of pitch”, Andrew J. Oxenham,
2014.  

The MaMi.CoDi model, based on Stolzenburg (2015), has one one parameter:
standard_deviation. Variance is used by the Stern-Brocot algorithm to
find tone ratios as rational fractions that are then used to estimate
the relative periodicity of chords. standard_deviation acts as the
physiological limits mentioned by Oxenham, above.  

Considering that the space and time signals had two different
physiological origins, we searched a two-dimensional standard_deviation
space in order to match model predictions with the large-scale
behavioral results. It turned out that the values that best matched
large-scale behavioral results were always the same for time and space
standard_deviation. This might indicate that the physiological
limitations are not specific to place signals or time signals
separetely. But instead the limitation is higher in the auditory system
after the signals have been passed along.  

That is to say, the limits that creates differences between time and
space signals might not be frequency selectivity or phase locking but
instead a limit of higher-level perception or pattern recognition, where
estimates of the period of a complex signal is made from components.  

MaMi.CoDi uses the Stern-Brocot tree to find rational fractions for the
ratios within a given standard_deviation. How do we find the best
standard_deviation values? For the MaMi.CoDi model we ran thousands of
computations with various standard_deviation values and compared the
predictions with results from six of the large-scale behavioral
experiments.  

Because the space signal and the time signal have different origins we
initially did a two-dimensional standard_deviation search. However the
closest fits to the behavioral data came from space and
standard_deviation values being the same. Insofar as this model
represents processing in the auditory cortex, it would seem that
estimating the cyclicity of the two signals happens higher up in the
auditoray system after the space and time signals have been processed.  

### Difference between Stern-Brocot Rational Fraction Approximations and Floating Point Values

The Stern-Brocot curve is a repeatable, deterministic curve of where
rational fractions exist or do not exist within a given
standard_deviation.  

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
