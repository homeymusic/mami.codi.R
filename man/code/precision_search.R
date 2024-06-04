search_label = 'P8'

devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='heisenberg')

# Detailed
# from_prec   = 0.01
# to_prec     = 0.03
# by_prec     = 0.001
# variances = seq(from=from_prec, to=to_prec, by=by_prec)

# Orders of Magnitude
variances   = sort(c(1:9 %o% 10^(-5:1),
                      mami.codi.R::default_variance()))


source('./freq_trials.R')
run_trials(search_label, variances)
