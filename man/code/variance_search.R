search_label = 'P8'
# Attempt to install the package from GitHub
github_result = devtools::install_github('homeymusic/mami.codi.R',
                                         ref='beats_filtered')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

# options(timeout = max(1000, getOption("timeout")))

# Detailed
# from_prec   = 0.07
# to_prec     = 0.09
# by_prec     = 0.01
# standard_deviations = sort(c(seq(from=from_prec, to=to_prec, by=by_prec)))

standard_deviations = c(1:9 %o% 10^(-3:-1))
# standard_deviations = c(1/(4 * pi))

# standard_deviations = c(5e-05)

source('./freq_trials.R')
run_trials(search_label, standard_deviations, include_beats=T)
