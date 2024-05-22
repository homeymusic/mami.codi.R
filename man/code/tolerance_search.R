search_label = 'P8'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # Detailed
  # from_tol   = 4e-05
  # to_tol     = 6e-05
  # by_tol     = 1e-06
  # tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  tolerances   = c(1:9 %o% 10^(-6:-1))
} else {

  # Detailed
  # from_tol   = 0.009
  # to_tol     = 0.04
  # by_tol     = 0.001
  # tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  # Orders of Magnitude
  tolerances   = c(1:9 %o% 10^(-4:-1))
}

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./trials.R')
run_trials(search_label, tolerances)
