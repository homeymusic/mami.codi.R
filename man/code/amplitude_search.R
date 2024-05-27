search_label = 'Rolloff12'

# Detailed
from_amp   = 0.01
to_amp     = 0.9
by_amp     = 0.01
amplitudes = c(0,seq(from=from_amp, to=to_amp, by=by_amp))

# Orders of Magnitude
# amplitudes   = c(0,c(1 %o% 10^(-3:-1)))

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./amp_trials.R')
run_trials(search_label, amplitudes)
