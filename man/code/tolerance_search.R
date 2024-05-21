source('./trials.R')

search_label = 'Harmonic'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # Detailed
  # from_tol   = 7e-05
  # to_tol     = 9e-05
  # by_tol     = 1e-06
  # tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  tolerances   = c(1:9 %o% 10^(-6:-1))
} else {

  # Detailed
  from_tol   = 0.06
  to_tol     = 0.08
  by_tol     = 0.001
  tolerances = seq(from=from_tol, to=to_tol, by=by_tol)

  # Harmonic Best Results Range
  # low:  0.072
  # pick: 0.0725
  # high: 0.073

  # Bonang Best Results Range
  # low:
  # pick:
  # high:

  # Orders of Magnitude
  # tolerances   = c(1:9 %o% 10^(-4:-1))
}

run_trials(search_label, tolerances)
