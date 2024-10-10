library(tidyverse)

tone_sweep <- function(
    duration,
    components
) {
  fs <- 44100
  time <- seq(from = 0, to = duration, length.out = floor(duration * fs))
  tones <- map(components, ~ .(time))
  wave <-
    tones %>%
    map(~ mutate(., freq = hrep::midi_to_freq(midi))) %>%
    map(~ mutate(., phase = get_instantaneous_phase(freq, time))) %>%
    map(~ mutate(., value = get_wave_value(amplitude_lower_bound, phase))) %>%
    map("value") %>%
    do.call(cbind, .) %>%
    rowSums()
  attr(wave, "sample_rate") <- fs
  wave
}

get_wave_value <- function(amplitude_lower_bound, phase) {
  amplitude_lower_bound * sin(phase)
}

get_instantaneous_phase <- function(freq, time) {
  n_samples <- length(time)
  timesteps <- diff(time)
  phases <- numeric(n_samples)
  phases[1] <- 0
  for (i in 1:(n_samples - 1)) {
    time_increment <- timesteps[i]
    frequency <- freq[i]
    phase_increment <- 2 * pi * frequency * time_increment
    phases[i + 1] <- phases[i] + phase_increment
  }
  phases
}

map_to_range <- function(x, input_low, input_high, output_low, output_high) {
  frac <- (x - input_low) / (input_high - input_low)
  output_low + frac * (output_high - output_low)
}


static_pure_tone <- function(amplitude_lower_bound, midi) {
  list(
    function(time) {
      tibble(time, amplitude_lower_bound, midi)
    }
  )
}

linear_freq_sweep_pure_tone <- function(
    amplitude_lower_bound,
    start_midi,
    end_midi,
    duration
) {
  function(time) {
    tibble(
      time,
      amplitude_lower_bound,
      midi = map_to_range(
        time,
        input_low = 0,
        input_high = duration,
        output_low = start_midi,
        output_high = end_midi
      )
    )
  }
}

frequency_ratios_to_midi_intervals <- function(ratios) {
  ref_frequency <- hrep::midi_to_freq(0)
  hrep::freq_to_midi(ref_frequency * ratios)
}

static_complex_tone <- function(
    midi_root,
    spectrum_frequency_ratios,
    spectrum_amplitude_lower_bounds
) {
  linear_freq_sweep_complex_tone(
    start_midi_root = midi_root,
    end_midi_root = midi_root,
    duration = 1,
    spectrum_frequency_ratios = spectrum_frequency_ratios,
    spectrum_amplitude_lower_bounds = spectrum_amplitude_lower_bounds
  )
}

linear_freq_sweep_complex_tone <- function(
    start_midi_root,
    end_midi_root,
    duration,
    spectrum_frequency_ratios,
    spectrum_amplitude_lower_bounds
) {
  spectrum_midi_intervals <-
    frequency_ratios_to_midi_intervals(spectrum_frequency_ratios)

  map2(
    spectrum_midi_intervals,
    spectrum_amplitude_lower_bounds,
    function(midi_interval, amplitude_lower_bound) {
      linear_freq_sweep_pure_tone(
        amplitude_lower_bound = amplitude_lower_bound,
        start_midi = start_midi_root + midi_interval,
        end_midi = end_midi_root + midi_interval,
        duration = duration
      )
    }
  ) %>%
    do.call(c, .)
}

static_basic_harmonic_complex_tone <- function(
    midi,
    amplitude_lower_bound,
    n_harmonics,
    decay_dB_per_octave,
    octave_definition = 2
) {
  linear_freq_sweep_basic_harmonic_complex_tone(
    start_midi_root = midi,
    end_midi_root = midi,
    duration = 1,
    amplitude_lower_bound = amplitude_lower_bound,
    n_harmonics = n_harmonics,
    decay_dB_per_octave = decay_dB_per_octave,
    octave_definition = octave_definition
  )
}

linear_freq_sweep_basic_harmonic_complex_tone <- function(
    start_midi_root,
    end_midi_root,
    duration,
    amplitude_lower_bound,
    n_harmonics,
    decay_dB_per_octave,
    octave_definition = 2
) {
  harmonic_number <- 1:n_harmonics
  dB <- - decay_dB_per_octave * log2(harmonic_number)
  amplitude_lower_bounds <- amplitude_lower_bound * 10 ^ (dB / 20)
  spectrum_frequency_ratios <- octave_definition ^ log2(1:n_harmonics)

  linear_freq_sweep_complex_tone(
    start_midi_root,
    end_midi_root,
    duration,
    spectrum_frequency_ratios = spectrum_frequency_ratios,
    spectrum_amplitude_lower_bounds = amplitude_lower_bounds
  )
}

linear_freq_sweep_bonang_tone <- function(
    start_midi_root,
    end_midi_root,
    duration,
    amplitude_lower_bound
) {
  linear_freq_sweep_complex_tone(
    start_midi_root = start_midi_root,
    end_midi_root = end_midi_root,
    duration = duration,
    spectrum_frequency_ratios = c(1, 1.52, 3.46, 3.92),
    spectrum_amplitude_lower_bounds = c(1, 1, 1, 1)
  )
}

add_fades <- function(
    wave,
    rise_time = 0.05,
    fade_time = 0.05,
    sample_rate = attr(wave, "sample_rate")
) {
  num_samples <- length(wave)
  if (rise_time != 0) {
    rise_n_samples <- round(rise_time * sample_rate)
    stopifnot(rise_n_samples <= num_samples)
    if (rise_n_samples > 0) {
      ind <- 1:rise_n_samples
      wave[ind] <- wave[ind] * seq(from = 0, to = 1, length.out = rise_n_samples)
    }
  }
  if (fade_time != 0) {
    fade_n_samples <- round(fade_time * sample_rate)
    stopifnot(fade_n_samples <= num_samples)
    if (fade_n_samples > 0) {
      ind <- seq(to = num_samples, length.out = fade_n_samples)
      wave[ind] <- wave[ind] * seq(from = 1, to = 0, length.out = fade_n_samples)
    }
  }
  wave
}

export <- function(
    wave,
    path,
    rise_time = 0.05,
    fade_time = 0.05,
    bit_rate = 16,
    sample_rate = attr(wave, "sample_rate")
) {
  wave %>%
    add_fades(rise_time, fade_time, sample_rate = sample_rate) %>%
    quantize_wave(bit_rate) %>%
    {tuneR::Wave(left = ., right = ., samp.rate = sample_rate, bit = bit_rate)} %>%
    tuneR::writeWave(path)
}

quantize_wave <- function(wave, bit_rate) {
  max_int <- 2 ^ (bit_rate - 1) - 1
  map_to_range(
    wave,
    input_low = - max(abs(wave)),
    input_high = max(abs(wave)),
    output_low = - max_int,
    output_high = max_int
  ) %>%
    round()
}

sweep_v_line_over_plot <- function(
    plot,
    x_start,
    x_end,
    duration,
    path,
    audio_components = NULL,
    fps = 30,
    width = 6,
    height = 4,
    edit_plot = function(plot, interval, plot_data, ...) plot,
    pars = list(),
    # get_pleasantness = function(interval, plot_data) NULL,
    ...
) {
  tmp_dir <- tempfile(pattern = "")
  R.utils::mkdirs(tmp_dir)

  n_frames <- round(duration * fps)

  x_vals <- seq(from = x_start, to = x_end, length.out = n_frames)
  ind <- seq_along(x_vals)
  tmp_path_format <- "img%07d.png"
  tmp_paths <- file.path(tmp_dir, sprintf(tmp_path_format, ind))

  audio <- NULL
  if (!is.null(audio_components)) {
    message("Synthesising audio...")
    audio_path <- tempfile(fileext = ".wav")
    print(audio_path)
    tone_sweep(duration, audio_components) %>% export(audio_path)
    audio <- audio_path
  }

  message("Creating plots...")
  plan(multisession, workers=parallelly::availableCores())

  furrr::future_map(
    ind,
    function(i) {
      tmp_path <- tmp_paths[i]
      x <- x_vals[i]

      tmp_plot <-
        plot +
        geom_vline(xintercept = x)

      tmp_plot <- edit_plot(tmp_plot, interval = x, plot_data = plot$data, pars = pars)

      ggsave(
        plot = tmp_plot,
        filename = tmp_path,
        width = width,
        height = height,
        ...
      )
    }, .progress=TRUE, .options = furrr::furrr_options(seed = T))
  message("Encoding video...")

  suppressWarnings(file.remove(path))

  audio_bit_rate <- "600k"
  cmd <- glue::glue(
    "ffmpeg -r {fps} -f image2 -i {tmp_dir}/{tmp_path_format} -i {audio} -vcodec libx264 -crf 25  -pix_fmt yuv420p -acodec aac -b:a {audio_bit_rate} '{path}'"
  )
  print(cmd)
  exit <- suppressWarnings(system(cmd))
  if (exit == 127) {
    ffmpeg_path <- "/opt/homebrew/bin/"
    cmd_2 <- paste0(ffmpeg_path, cmd)
    exit_2 <- system(cmd_2)
    if (exit_2 == 127) {
      stop(
        "An error occurred when running the ffmpeg command. ",
        "You may need to install ffmpeg before continuing. ",
        "If you have ffmpeg installed, find its path by running 'where ffmpeg', ",
        "and edit the R code in sine_sweep.R to put it as the new value of ",
        "ffmpeg_path."
      )
    }
  }

  # av::av_encode_video(
  #   input = tmp_paths,
  #   output = path,
  #   framerate = fps,
  #   audio = audio, codec = "h263b"
  # )
  # system(sprintf(
  #   "ffmpeg -i test.mp4 -i %s -map 0:v -map 1:a -c:v copy -shortest output.mp4",
  #   audio
  # ))
}

if (FALSE) {
  library(furrr)
  plan(multisession)
}

# sweep_v_line_over_plot(
#   p1,
#   x_start = 0,
#   x_end = 15,
#   duration = 75,
#   path = "harmonic-dyads.mp4",
#   fps = 30,
#   dpi = 300,
#   audio_components = c(
#     static_basic_harmonic_complex_tone(
#       midi = 60,
#       amplitude_lower_bound = 1,
#       n_harmonics = 11,
#       decay_dB_per_octave = 3
#     ),
#     linear_freq_sweep_basic_harmonic_complex_tone(
#       start_midi_root = 60,
#       end_midi_root = 75,
#       duration = 75,
#       amplitude_lower_bound = 1,
#       n_harmonics = 11,
#       decay_dB_per_octave = 3
#     )
#   )
# )


if (FALSE) {
  # Example usage
  tone_sweep(
    duration = 20,

    components = c(
      static_basic_harmonic_complex_tone(
        midi = 60, amplitude_lower_bound = 1, n_harmonics = 4, decay_dB_per_octave = 0
      ),
      linear_freq_sweep_bonang_tone(
        start_midi_root = 60,
        end_midi_root = 72,
        duration = 20
      )

      #
      # linear_freq_sweep_basic_harmonic_complex_tone(
      #   start_midi_root = 60,
      #   end_midi_root = 60,
      #   duration = 5,
      #   n_harmonics = 10,
      #   decay_dB_per_octave = 3
      # )
      # # linear_freq_sweep_complex_tone(
      # #   start_midi_root = 60,
      # #   end_midi_root = 72,
      # #   duration = 5,
      # #   spectrum_frequency_ratios = 1:5,
      # #   spectrum_amplitude_lower_bounds = 1 / (1:5) ^ 2
      # # )
    )
  ) %>%
    export("test.wav")

}
