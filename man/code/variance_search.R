search_label = 'Harmonic'
devtools::install_github('git@github.com:homeymusic/mami.codi.R',
                         ref='beats')

# options(timeout = max(1000, getOption("timeout")))

# Detailed
# from_prec   = 0.08
# to_prec     = 0.09
# by_prec     = 0.001
# standard_deviations = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
#               mami.codi.R::default_standard_deviation()))

# Orders of Magnitude
standard_deviations   = c(1:9 %o% 10^(-3:-1), 1)

source('./freq_trials.R')
run_trials(search_label, standard_deviations,
           include_time_beats=T, include_space_beats=T)
