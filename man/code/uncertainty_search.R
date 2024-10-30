search_label = 'P8'
# Attempt to install the package from GitHub
github_result = devtools::install_github('homeymusic/mami.codi.R',
                                         ref='main')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

# options(timeout = max(1000, getOption("timeout")))

# Detailed
# from_prec   = 0.08
# to_prec     = 0.1
# by_prec     = 0.001
# uncertainties = sort(c(seq(from=from_prec, to=to_prec, by=by_prec)))

uncertainties = c(1:9 %o% 10^(-3:-1))

source('./uncertainty_trials.R')

timbres=c('Pure','5PartialsNo3','5Partials','Bonang','Harmonic','Stretched','Compressed')
results <- purrr::map(timbres, function(t) {
  print(paste('Timbre:', t))
  run_trials(t, uncertainties)
  return(paste("Processed timbre:", t))
})
