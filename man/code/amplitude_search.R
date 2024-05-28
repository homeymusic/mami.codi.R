search_label = 'Rolloff12'

if (search_label == 'Rolloff2') {
  roll_off = 2
} else if (search_label == 'Rolloff7') {
  roll_off = 7
} else if (search_label == 'Rolloff12') {
  roll_off = 12
}

amplitudes = c(hrep::amp(hrep::sparse_fr_spectrum(60, num_harmonics=10, roll_off_dB = roll_off))[-1],0)

devtools::install_github('git@github.com:homeymusic/mami.codi.R')

source('./amp_trials.R')
run_trials(search_label, amplitudes)
