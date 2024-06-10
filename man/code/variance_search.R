search_label = 'Harmonic'
heisenberg   = F

err = devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                               ref='gcd_lcm')

print(paste("github:", err))
if (is.na(err)) {
  stop('problem wit github')
}

# Detailed
# from_prec   = 0.1
# to_prec     = 0.2
# by_prec     = 0.01
# variances = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
#               mami.codi.R::default_variance()))

# Orders of Magnitude
variances   = sort(c(1:9 %o% 10^(-5:-2),
                      mami.codi.R::default_variance()))

source('./freq_trials.R')
run_trials(search_label, variances, heisenberg)
