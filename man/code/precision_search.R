search_label = 'Bonang'

# Detailed
# from_prec   = 0.01
# to_prec     = 0.03
# by_prec     = 0.001
# variances = seq(from=from_prec, to=to_prec, by=by_prec)

# Orders of Magnitude
variances   = sort(c(1:9 %o% 10^(-2:-1),
                      mami.codi.R::rational_fraction_variance()))


devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./freq_trials.R')
run_trials(search_label, variances)
