search_label = 'Harmonic'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # Detailed
  # from_prec   = 4e-05
  # to_prec     = 6e-05
  # by_prec     = 1e-06
  # precisions = seq(from=from_prec, to=to_prec, by=by_prec)

  precisions   = c(1:9 %o% 10^(-6:-1))
} else {

  # Detailed
  # from_prec   = 0.1
  # to_prec     = 1.0
  # by_prec     = 0.01
  # precisions = seq(from=from_prec, to=to_prec, by=by_prec)

  # Orders of Magnitude
  precisions   = c(1:9 %o% 10^(-4:-1))
}

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./trials.R')
run_trials(search_label, precisions)
