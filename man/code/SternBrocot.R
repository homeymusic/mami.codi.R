# devtools::install_github('git@github.com:homeymusic/mami.codi.R')
devtools::load_all(".")
source('./utils.R')

samples = 1000000
standard_deviation = 0.4
print(paste('samples:',samples))
print(paste('standard_deviation:',standard_deviation))
rationals = seq(from=1/samples, to=1, by=1/samples)
plan(multisession, workers=parallelly::availableCores())
fractions = rationals %>%
  furrr::future_map(\(r) {
    approximate_rational_fractions(r, standard_deviation=standard_deviation, deviation=default_harmonics_deviation())
  }, .progress=TRUE, .options = furrr::furrr_options(seed = T)) %>%
  purrr::list_rbind()

rds = paste0('../data/stern_brocot_',standard_deviation,'.rds')
saveRDS(fractions,rds)
