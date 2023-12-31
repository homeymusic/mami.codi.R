# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' ratios
#'
#' Creates a list of frequency ratios as rational fractions
#'
#' @param x Chord frequency ratios
#' @param reference_freq Reference frequency ratios
#' @param tolerance A vector with two values for the upper and lower tolerance.
#' @param pseudo_octave Factor for calculating stretched and compressed ratios.
#'
#' @return A data frame of numerators and denominators
#'
#' @export
ratios <- function(x, reference_freq, tolerance, pseudo_octave, invert = FALSE) {
    .Call(`_mami_codi_R_ratios`, x, reference_freq, tolerance, pseudo_octave, invert)
}

#' analyze_harmonics
#'
#' Determine pseudo octave of all frequencies relative to lowest frequency
#'
#' @param x Chord frequencies
#'
#' @return A data frame of frequencies and pseudo_octaves
#'
#' @export
analyze_harmonics <- function(x) {
    .Call(`_mami_codi_R_analyze_harmonics`, x)
}

