search_label = 'M3'
# Attempt to install the package from GitHub
github_result = devtools::install_github('homeymusic/mami.codi.R', ref='wavelength_beats')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

# options(timeout = max(1000, getOption("timeout")))

# Detailed
# from_prec   = 0.08
# to_prec     = 0.09
# by_prec     = 0.001
# standard_deviations = sort(c(seq(from=from_prec, to=to_prec, by=by_prec),
#               mami.codi.R::default_standard_deviation()))

# Orders of Magnitude
# standard_deviations = c(1:9 %o% 10^(-2:-2), 1)

standard_deviations = c(1/(4 * pi))

source('./freq_trials.R')
run_trials(search_label, standard_deviations, include_beats=T)
