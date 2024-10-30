search_label = 'Harmonic'
# Attempt to install the package from GitHub
github_result = devtools::install_github('homeymusic/mami.codi.R',
                                         ref='main')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}


sfoae_num_harmonics = c(1:20)

source('./sfoae_num_harmonics_trials.R')
run_trials(search_label, sfoae_num_harmonics)
