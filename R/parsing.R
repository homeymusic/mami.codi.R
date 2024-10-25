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

  tibble::tibble_row(
    spectrum = list(x)
  )

}

