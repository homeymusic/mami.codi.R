search_label = 'P8'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # Detailed
  # from_prec   = 3e-14
  # to_prec     = 5e-14
  # by_prec     = 1e-15
  # precisions = seq(from=from_prec, to=to_prec, by=by_prec)

  precisions   = c(1:9 %o% 10^(-7:-1))
} else {

  # Detailed
  from_prec   = 0.01
  to_prec     = 0.03
  by_prec     = 0.001
  precisions = seq(from=from_prec, to=to_prec, by=by_prec)

  # Orders of Magnitude
  # precisions   = c(1:9 %o% 10^(-2:-1))
}

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./trials.R')
run_trials(search_label, precisions)
