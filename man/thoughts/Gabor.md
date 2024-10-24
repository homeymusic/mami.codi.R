Gabor
================

![](../figures/gabor-unnamed-chunk-2-1.svg)<!-- -->

    #> Warning in xy.coords(x, y, xlabel, ylabel, log): imaginary parts discarded in
    #> coercion

![](../figures/gabor-unnamed-chunk-3-1.svg)<!-- -->

    #> Warning in xy.coords(x, y, xlabel, ylabel, log): imaginary parts discarded in
    #> coercion

![](../figures/gabor-unnamed-chunk-4-1.svg)<!-- -->

![](../figures/gabor-unnamed-chunk-5-1.svg)<!-- -->

The dimensions of Heisenberg’s Uncertainty Principle (HUP) are a purely
spatial dimension, position (s) measured in meters, and a
spatio-temporal mass dimension, momentum (p) measured in kg \* m / s.
One dimension includes time, the other does not.  

The dimensions of Gabor’s application of HUP to signal analysis are a
temporal dimension, time of the signal (t) measured in seconds, and
another temporal dimension, frequency of the signal (f), measured in 1 /
seconds. Both dimensions include time.  

The dimensions of MaMi.CoDis application of HUP to signal analysis are
a  
spatial dimension, wavelength (l) measured in meters, and a temporal
dimension, frequency (f) measured in 1 / seconds. One dimension includes
time, the other does not.  

Do sound waves have mass? See [Sound Waves Carry
Mass](https://physics.aps.org/articles/v12/23) and
[Phonons](https://en.wikipedia.org/wiki/Phonon)  

“sub specie aeternitatis” p 431  

The above makes me think of the contrast between the infinity of Fourier
versus me with my ruler in one hand, stopwatch in the other and a tally
counter around my neck.  

“We know that any instrument, or combination of instruments, cannot
obtain more than at most 2(f2 — f1)tau independent data from the area
(f2 — f1)tau in the diagram. But instead of rigorously independent data,
which can be obtained in general only by calculation from the instrument
readings, it will be more convenient for the moment to
consider”practically” independent data, which can be obtained by direct
readings.” -Gabor  

“Decay time x Tuning width = Number of the order one.”  

For MaMi.CoDi:  

Wavelength ratio standard_deviation x Frequency ratio standard_deviation = Number of the
order one  

One observation happens in a “characteristic rectangle” in the
space-time diagram.

The conventional language is a blocker for me. When time is frozen and
we measure the wavelength in the cochlea that is a purely spatial
observation. But the convention is to label that a frequency measured in
Hz, which is 1/s. But time is frozen. There are no seconds? What
gives?  

It should be a spatial length measured in meters. Can we abandon the
label of time-frequency domain and replace it with space-time domain?  

But this can be a problem too:  

    #> # A tibble: 4 × 2
    #>   space          time           
    #>   <chr>          <chr>          
    #> 1 spatial length temporal length
    #> 2 wavelength     period         
    #> 3 count in space count in time  
    #> 4 wavenumber     frequency

    #> # A tibble: 1 × 4
    #>      f1    f2   tau_s data_count
    #>   <dbl> <dbl>   <dbl>      <dbl>
    #> 1  262. 2616. 0.00382       9.00

Gabor’s model starts with the orthogonal sine and cosine functions. And
uses the set of those 2 coefficients to create a data set of size
2(f2-f1)tau.  

MaMi.CoDi starts with the wavelength (row of hair cells, bank of reeds)
and frequency (phase-locking, oscillograph) signals to create a data set
of size 2(f2-f1)tau.

## 2.1 Time and Frequency

### Equation 1.1

![](../figures/gabor-unnamed-chunk-8-1.svg)<!-- -->

![](../figures/gabor-unnamed-chunk-9-1.svg)<!-- -->

    #> Warning: `as.tibble()` was deprecated in tibble 2.0.0.
    #> ℹ Please use `as_tibble()` instead.
    #> ℹ The signature and semantics have changed, see `?as_tibble`.
    #> This warning is displayed once every 8 hours.
    #> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    #> generated.

![](../figures/gabor-unnamed-chunk-10-1.svg)<!-- -->

![](../figures/gabor-unnamed-chunk-12-1.svg)<!-- -->
