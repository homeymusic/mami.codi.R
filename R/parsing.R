#' Parse Input
#'
#' Parses the chord to analyse, coerced to hrep::sparse_fr_spectrum
#'
#'
#' @param x Chord to analyse specified in MIDI, coerced to hrep::sparse_fr_spectrum
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @rdname parse_input
#' @export
parse_input <- function(x, ...) {

  UseMethod('parse_input', x)

}

#' @rdname parse_input
#' @export
parse_input.default <- function(x, ...) {

  parse_input(hrep::sparse_fr_spectrum(x, ...), ...)

}

#' @rdname parse_input
#' @export
parse_input.sparse_fr_spectrum <- function(x, ...) {

  x

}

#' Format Output
#'
#' Allows the user to select which columns from the tibble are returned
#'
#'
#' @param x The output tibble with all the data
#' @param metadata Metadata that the user can include that will roundtrip from input to output
#' @param verbose If true then all the data will be included.
#' @param ... parameters for hrep::sparse_fr_spectrum
#'
#' @rdname format_output
#' @export
format_output <- function(x, metadata, verbose) {
  x <- x %>% tibble::add_column(
    metadata=list(metadata)
  )

  if (verbose) {
    x
  } else {
    x %>%
      dplyr::select('majorness',
                    'dissonance',
                    'metadata')
  }
}

# Parsing and marshaling helper functions

#' Helper function to create an empty spectrum
empty_wavelength_spectrum <- function() {
  tibble::tibble(
    wavelength = numeric(),
    amplitude  = numeric()
  )
}

empty_frequency_spectrum <- function() {
  tibble::tibble(
    frequency = numeric(),
    amplitude = numeric()
  )
}

#' Helper functions to combine spectra

combine_wavelength_spectra <- function(x,y) {
  x = sparse_fr_spectrum_from_wavelength_spectrum(x)
  y = sparse_fr_spectrum_from_wavelength_spectrum(y)
  wavelength_spectrum_from_sparse_fr_spectrum(hrep::combine_sparse_spectra(x,y))
}

combine_frequency_spectra <- function(x,y) {
  x = hrep::sparse_fr_spectrum(x %>% as.list())
  y = hrep::sparse_fr_spectrum(y %>% as.list())
  frequency_spectrum_from_sparse_fr_spectrum(hrep::combine_sparse_spectra(x,y))
}

sparse_fr_spectrum_from_wavelength_spectrum <- function(x) {
  hrep::sparse_fr_spectrum(list(
    frequency = C_SOUND / x$wavelength,
    amplitude = x$amplitude
  ))
}

wavelength_spectrum_from_sparse_fr_spectrum <- function(x) {
  tibble::tibble(
    wavelength = C_SOUND / x$x,
    amplitude  = x$y
  )
}

frequency_spectrum_from_sparse_fr_spectrum <- function(x) {
  tibble::tibble(
    frequency = x$x,
    amplitude = x$y
  )
}

