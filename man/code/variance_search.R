search_label = 'P8'
heisenberg   = T

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

# Detailed
# from_prec   = 0.09
# to_prec     = 0.2
# by_prec     = 0.001
# variances = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
#               mami.codi.R::default_variance()))

# Orders of Magnitude
variances   = sort(c(1:9 %o% 10^(-2:-1),
                      mami.codi.R::default_variance()))


source('./freq_trials.R')
run_trials(search_label, variances, heisenberg)
