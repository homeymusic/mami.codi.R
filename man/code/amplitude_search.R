search_label = 'Rolloff2'

# Detailed
# from_amp   = 0.01
# to_amp     = 0.1
# by_amp     = 0.001
# amplitudes = seq(from=from_amp, to=to_amp, by=by_amp)

# Orders of Magnitude
amplitudes   = c(1:9 %o% 10^(-2:-1))

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./amp_trials.R')
run_trials(search_label, amplitudes)
