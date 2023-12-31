% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{ratios}
\alias{ratios}
\title{ratios}
\usage{
ratios(x, reference_freq, tolerance, pseudo_octave)
}
\arguments{
\item{x}{Chord frequency ratios}

\item{reference_freq}{Reference frequency ratios}

\item{tolerance}{A vector with two values for the upper and lower tolerance.}

\item{pseudo_octave}{Factor for calculating stretched and compressed ratios.}
}
\value{
A data frame of numerators and denominators
}
\description{
Creates a list of frequency ratios as rational fractions
}
