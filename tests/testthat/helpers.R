ONE_PERCENT <- 0.01
C4 <- 261.6256
C3  <- C4 / 2
C5  <- C4 * 2
G4  <- 392
A4  <- 440

LO_MIN_REG=-BUFFER
HI_MIN_REG=+BUFFER
LO_REG=LO_MIN_REG
HI_REG=HI_MIN_REG+4 # for 10 harmonics
LO_MIDI=60+12*LO_REG
LO_FREQ=hrep::midi_to_freq(LO_MIDI)
HI_MIDI=(hrep::sparse_fr_spectrum(60,num_harmonics=10)$x %>%
  min %>%
  hrep::freq_to_midi()) +
  12*HI_REG
HI_FREQ=hrep::midi_to_freq(HI_MIDI)
