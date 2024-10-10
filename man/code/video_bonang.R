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
t='Bonang'
black_vlines = c(2.60, 4.80, 12.0)
gray_vlines  = c(7.2, 9.6)
sigma = BEHAVIOURAL_SMOOTH_BROAD

chords <- dyads %>% dplyr::filter(timbre == t)
chords$consonance_dissonance_z = z_scores(chords$consonance_dissonance)
chords$major_minor_z = z_scores(chords$major_minor)
chords$spatial_consonance_z = z_scores(chords$spatial_consonance)
chords$temporal_consonance_z = z_scores(chords$temporal_consonance)

experiment.rds = paste0('./man/data/',
                        t,
                        '.rds')

experiment_all = readRDS(experiment.rds)

experiment = experiment_all$profile %>%
  dplyr::rename(semitone=interval)

experiment <- experiment %>% dplyr::mutate(
  consonance_dissonance = rating
)

experiment_raw = experiment_all$data %>%
  dplyr::rename(semitone=interval,
                consonance_dissonance_z=rating)

p1 = plot_semitone_codi(chords, paste(t, '~ Consonance-Dissonance'),
                   goal=experiment,sigma=sigma,include_points=T,
                   black_vlines=black_vlines,gray_vlines=gray_vlines)
title = paste0(t,'CoDi')

# p1 = plot_semitone_spatial_temporal(chords, paste(t, '~ Wavelength and Frequency Consonance'),
#                                goal=NULL,sigma=sigma,include_points=T,
#                                black_vlines=black_vlines,gray_vlines=gray_vlines)
# title = paste0(t,'WavelengthFrequency')

R.utils::mkdirs("output/videos")

sweep_v_line_over_plot(
  plot = p1,
  x_start = 0,
  x_end = 15,
  duration = 75,
  path = paste0('output/videos/',title,'.mp4'),
  width = 8,
  height = 5.5,
  fps = 30,
  dpi = 300,
  audio_components = c(
    static_basic_harmonic_complex_tone(
      midi = 60,
      amplitude_lower_bound = 1,
      n_harmonics = 5L,
      decay_dB_per_octave = 0,
      octave_definition = 2
    ),
    linear_freq_sweep_bonang_tone(
      start_midi_root = 60,
      end_midi_root = 75,
      duration = 75,
      amplitude_lower_bound = 1
    )
  )
)
