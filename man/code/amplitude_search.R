search_label = 'Rolloff2'

if (search_label == 'Rolloff2') {
  roll_off = 2
} else if (search_label == 'Rolloff7') {
  roll_off = 7
} else if (search_label == 'Rolloff12') {
  roll_off = 12
}

amplitudes = c(hrep::amp(hrep::sparse_fr_spectrum(60, num_harmonics=10, roll_off_dB = roll_off))[-1],0)

github_result = devtools::install('/Users/homeymusic/Documents/git/homeymusic/mami.codi.R',
                                  dependencies = F,
                                  ref='main')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

source('./amp_trials.R')
run_trials(search_label, amplitudes)
