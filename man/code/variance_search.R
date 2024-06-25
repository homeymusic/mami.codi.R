search_label = 'M6'
heisenberg   = F
# options(timeout = max(1000, getOption("timeout")))
# devtools::install_github('git@github.com:homeymusic/mami.codi.R',
#                          auth_token = Sys.getenv("GITHUBTOKEN"))

# Detailed
# from_prec   = 0.08
# to_prec     = 0.09
# by_prec     = 0.001
# variances = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
#               mami.codi.R::default_variance()))

# Orders of Magnitude
variances   = c(1:9 %o% 10^(-2:-1))

source('./freq_trials.R')
run_trials(search_label, variances, heisenberg)
