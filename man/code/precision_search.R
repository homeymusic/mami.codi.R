search_label = 'M3'

# Detailed
# from_prec   = 0.01
# to_prec     = 0.03
# by_prec     = 0.001
# precisions = seq(from=from_prec, to=to_prec, by=by_prec)

# Orders of Magnitude
precisions   = sort(c(1:9 %o% 10^(-2:-1),
                      mami.codi.R::rational_fraction_precision()))


devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='upward')

source('./freq_trials.R')
run_trials(search_label, precisions)
