timbres=c('Pure','5PartialsNo3','5Partials','Bonang','Harmonic','Stretched','Compressed')

devtools::load_all(".")
source('./man/code/plot.R')
source('./man/code/utils.R')
source('./man/code/sine_sweep.R')

sigma  <- 0.2

timbre_paper = readRDS('./man/data/output/readme.rds')

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

audio_components <- function(t) {
  if (t=='Pure') {
    .spectrum_frequency_ratios = 1
    .spectrum_amplitudes = 1
    audio_components = c(
      static_complex_tone(
        midi_root = 60,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      ),
      linear_freq_sweep_complex_tone(
        start_midi_root = 60,
        end_midi_root = 60 + 15,
        duration = 75,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      )
    )
  } else if (t=='Bonang') {
    audio_components = c(
      static_basic_harmonic_complex_tone(
        midi = 60,
        amplitude = 1,
        n_harmonics = 5L,
        decay_dB_per_octave = 0,
        octave_definition = 2
      ),
      linear_freq_sweep_bonang_tone(
        start_midi_root = 60,
        end_midi_root = 75,
        duration = 75,
        amplitude = 1
      )
    )
  } else if (t=='5Partials') {
    .spectrum_frequency_ratios = 1:5
    .spectrum_amplitudes = c(1, 1, 1, 1, 1)
    audio_components = c(
      static_complex_tone(
        midi_root = 60,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      ),
      linear_freq_sweep_complex_tone(
        start_midi_root = 60,
        end_midi_root = 60 + 15,
        duration = 75,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      )
    )
  } else if (t=='5PartialsNo3') {
    .spectrum_frequency_ratios = 1:5
    .spectrum_amplitudes = c(1, 1, 0, 1, 1)
    audio_components = c(
      static_complex_tone(
        midi_root = 60,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      ),
      linear_freq_sweep_complex_tone(
        start_midi_root = 60,
        end_midi_root = 60 + 15,
        duration = 75,
        spectrum_frequency_ratios = .spectrum_frequency_ratios,
        spectrum_amplitudes = .spectrum_amplitudes
      )
    )
  } else if (t=='Harmonic') {
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
  } else if (t=='Stretched') {
    audio_components = c(
      static_basic_harmonic_complex_tone(
        midi = 60,
        amplitude = 1,
        n_harmonics = 10,
        decay_dB_per_octave = 3,
        octave_definition = 2.1
      ),
      linear_freq_sweep_basic_harmonic_complex_tone(
        start_midi_root = 60,
        end_midi_root = 75,
        duration = 75,
        amplitude = 1,
        n_harmonics = 10,
        decay_dB_per_octave = 3,
        octave_definition = 2.1
      )
    )
  } else if (t=='Compressed') {
    audio_components = c(
      static_basic_harmonic_complex_tone(
        midi = 60,
        amplitude = 1,
        n_harmonics = 10,
        decay_dB_per_octave = 3,
        octave_definition = 1.9
      ),
      linear_freq_sweep_basic_harmonic_complex_tone(
        start_midi_root = 60,
        end_midi_root = 75,
        duration = 75,
        amplitude = 1,
        n_harmonics = 10,
        decay_dB_per_octave = 3,
        octave_definition = 1.9
      )
    )
  } else {
    stop(paste('Not implemented yet:', t))
  }
}

results <- purrr::map(timbres, function(t) {
  print(paste('Timbre:', t))

  chords <- dyads %>% dplyr::filter(timbre == t)
  chords$dissonance_z = z_scores(chords$dissonance)
  chords$major_z = z_scores(chords$majorness)
  chords$space_dissonance_z = z_scores(chords$space_dissonance)
  chords$time_dissonance_z = z_scores(chords$time_dissonance)

  p2 = plot_semitone_beating(chords, paste(t, ': Beating'))
  title = paste0(t,'_Beating')

  R.utils::mkdirs("man/videos")

  sweep_v_line_over_plot(
    p2,
    x_start = 0,
    x_end = 15,
    duration = 75,
    path = paste0('man/videos/',title,'.mp4'),
    fps = 30,
    dpi = 300,
    audio_components = audio_components(t)
  )

  p1 = plot_semitone_space_time(chords, paste(t, ': Space Time Consonance'))
  title = paste0(t,'_Space_Time_Consonance')

  R.utils::mkdirs("man/videos")

  sweep_v_line_over_plot(
    p1,
    x_start = 0,
    x_end = 15,
    duration = 75,
    path = paste0('man/videos/',title,'.mp4'),
    fps = 30,
    dpi = 300,
    audio_components = audio_components(t)
  )
  return(paste("Processed timbre:", t))
})
