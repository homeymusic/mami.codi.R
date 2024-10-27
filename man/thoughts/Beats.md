Beats
================

tone_1 = hrep::sparse_fr_spectrum(60, num_harmonics=1) N = 3 for (i in
1:N) { tone_1 %\>% hrep::play_wav(player = ‘/usr/bin/afplay’) }

tone_1 = hrep::sparse_fr_spectrum(-3.77, num_harmonics=1)

tone_1 %\>% hrep::play_wav(player = ‘/usr/bin/afplay’)

tone_1 = hrep::sparse_fr_spectrum(120, num_harmonics=1) tone_2 =
hrep::sparse_fr_spectrum(120.03, num_harmonics=1)

tone_1 %\>% hrep::play_wav(player = ‘/usr/bin/afplay’) tone_2 %\>%
hrep::play_wav(player = ‘/usr/bin/afplay’)
