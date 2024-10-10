# devtools::install_github('git@github.com:homeymusic/mami.codi.R')
devtools::load_all(".")
source('./utils.R')

samples = 1000000
variance = 0.4
print(paste('samples:',samples))
print(paste('variance:',variance))
rationals = seq(from=1/samples, to=1, by=1/samples)
plan(multisession, workers=parallelly::availableCores())
fractions = rationals %>%
  furrr::future_map(\(r) {
    approximate_rational_fractions(r, variance=variance, approximate_lcm_sd=default_approximate_lcm_sd())
  }, .progress=TRUE, .options = furrr::furrr_options(seed = T)) %>%
  purrr::list_rbind()

rds = paste0('../data/stern_brocot_',variance,'.rds')
saveRDS(fractions,rds)
