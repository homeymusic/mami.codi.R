search_label = 'Bonang'

if (search_label == 'M3' || search_label == 'M6' || search_label == 'P8') {
  # Detailed
  from_prec   = 0.07
  to_prec     = 0.09
  by_prec     = 0.001
  precisions = sort(c(seq(from=from_prec, to=to_prec, by=by_prec), 1 / (4*pi)))

  # precisions   = c(1:9 %o% 10^(-7:-1))
} else {

  # Detailed
  # from_prec   = 0.01
  # to_prec     = 0.03
  # by_prec     = 0.001
  # precisions = seq(from=from_prec, to=to_prec, by=by_prec)

  # Orders of Magnitude
  precisions   = sort(c(0.063, 1:9 %o% 10^(-2:-1)))
}

devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='fundamentals')

source('./freq_trials.R')
run_trials(search_label, precisions)
