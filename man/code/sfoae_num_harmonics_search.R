github_result = devtools::install('/Users/homeymusic/Documents/git/homeymusic/mami.codi.R')

if (is.na(github_result)) {
  stop("Fatal error: Unable to install the package from GitHub. Please check the repository and branch name.")
} else {
  message("Repo looks good: ", github_result)
}

cochlear_amplifier_num_harmonics = c(1:20)

source('./man/code/cochlear_amplifier_num_harmonics_trials.R')

timbres=c('Pure','5PartialsNo3','5Partials','Bonang','Harmonic','Stretched','Compressed')
results <- purrr::map(timbres, function(t) {
  print(paste('Timbre:', t))
  run_trials(t, cochlear_amplifier_num_harmonics)
  return(paste("Processed timbre:", t))
})
