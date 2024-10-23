search_label = 'P8'
heisenberg   = F
# options(timeout = max(1000, getOption("timeout")))
devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref = 'tolerance')
                         # ,
                         # auth_token = Sys.getenv("GITHUBTOKEN"))

# Detailed
from_prec   = 0.007
to_prec     = 0.01
by_prec     = 0.0001
variances = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
              mami.codi.R::default_variance()))

# Orders of Magnitude
# variances   = c(1:9 %o% 10^(-3:-1))

source('./freq_trials.R')
run_trials(search_label, variances, heisenberg)
