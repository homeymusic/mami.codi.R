devtools::load_all(".")
source('./man/code/plot.R')
source('./man/code/utils.R')
source('./man/code/sine_sweep.R')

BEHAVIOURAL_SMOOTH_BROAD  <- 0.2

timbre_paper = readRDS('./man/data/readme.rds')

dyads <- timbre_paper %>% dplyr::rowwise() %>% dplyr::mutate(
  type          = metadata$type,
  num_harmonics = metadata$num_harmonics,
  octave_ratio  = metadata$octave_ratio,
  semitone      = metadata$semitone,
  timbre        = metadata$timbre,
  label         = round(metadata$semitone),
  chord_max     = max(frequencies),
  chord_min     = min(frequencies),
  .before=1
)

h=10
o=2.0
t='Harmonic'
gray_vlines = c()
black_vlines  = c(2,3,4,5,7,8,9,12)

sigma = BEHAVIOURAL_SMOOTH_BROAD

chords <- dyads %>% dplyr::filter(timbre == t)
chords$dissonance_z = z_scores(chords$dissonance)
chords$major_z = z_scores(chords$major)
chords$spatial_dissonance_z = z_scores(chords$spatial_dissonance)
chords$temporal_dissonance_z = z_scores(chords$temporal_dissonance)

experiment.rds = paste0('./man/data/',
                        t,
                        '.rds')

experiment_all = readRDS(experiment.rds)

experiment = experiment_all$profile %>%
  dplyr::rename(semitone=interval)

experiment <- experiment %>% dplyr::mutate(
  dissonance = rating
)

experiment_raw = experiment_all$data %>%
  dplyr::rename(semitone=interval,
                dissonance_z=rating)

p1 = plot_semitone_codi(chords, paste('Consonance-Dissonance'),
                        goal=experiment,sigma=sigma,include_points=T,
                        black_vlines=black_vlines,gray_vlines=gray_vlines)
title = paste0(t,'CoDi')

# p1 = plot_semitone_spatial_temporal(chords, paste(t, '~ Spatial and Temporal Consonance'),
#                                goal=NULL,sigma=sigma,include_points=T,
#                                black_vlines=black_vlines,gray_vlines=gray_vlines)
# title = paste0(t,'WavelengthFrequency')

R.utils::mkdirs("output/videos")
sweep_v_line_over_plot(
  p1,
  x_start = 0,
  x_end = 15,
  duration = 75,
  path = paste0('output/videos/',title,'.mp4'),
  fps = 30,
  dpi = 300,
  audio_components = c(
    static_basic_harmonic_complex_tone(
      midi = 60,
      amplitude = 1,
      n_harmonics = 11,
      decay_dB_per_octave = 3
    ),
    linear_freq_sweep_basic_harmonic_complex_tone(
      start_midi_root = 60,
      end_midi_root = 75,
      duration = 75,
      amplitude = 1,
      n_harmonics = 11,
      decay_dB_per_octave = 3
    )
  )
)
