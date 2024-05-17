source('./trials.R')

search_label = 'Harmonic'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  tolerances   = c(1 %o% 10^(-8:-1))
} else {

  # Detailed
  # from_tol   = 0.0008
  # to_tol     = 0.001
  # by_tol     = 0.00001
  # tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  # Orders of Magnitude
  tolerances   = c(1:9 %o% 10^(-5:-1))
}

run_trials(search_label, tolerances)
