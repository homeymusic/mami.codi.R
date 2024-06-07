search_label = 'Harmonic'
heisenberg   = F

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

# Detailed
from_prec   = 0.06
to_prec     = 0.08
by_prec     = 0.001
variances = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
              mami.codi.R::default_variance()))

# Orders of Magnitude
# variances   = sort(c(1:9 %o% 10^(-2:-1),
#                       mami.codi.R::default_variance()))


source('./freq_trials.R')
run_trials(search_label, variances, heisenberg)
