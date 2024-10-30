search_label = 'P8'
# Attempt to install the package from GitHub
github_result = devtools::install_github('homeymusic/mami.codi.R',
                                         ref='only_time')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

# options(timeout = max(1000, getOption("timeout")))

# Detailed
from_prec   = 0.08
to_prec     = 0.1
by_prec     = 0.001
uncertainties = sort(c(seq(from=from_prec, to=to_prec, by=by_prec)))

# uncertainties = c(1:9 %o% 10^(-5:0))

# Calculate integration_time values
integration_times <- sapply(uncertainties, function(uncertainty) {
  mami.codi.R::integration_time('space', uncertainty)
})

source('./freq_trials.R')
run_trials(search_label, integration_times, include_beats=T)
