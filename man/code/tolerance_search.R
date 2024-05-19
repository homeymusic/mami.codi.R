source('./trials.R')

search_label = 'Stretched'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  tolerances   = c(1:9 %o% 10^(-6:-5))
} else {

  # Detailed
  from_tol   = 0.01
  to_tol     = 0.03
  by_tol     = 0.001
  tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  # Orders of Magnitude
  # tolerances   = c(1:9 %o% 10^(-4:-1))
}

run_trials(search_label, tolerances)
