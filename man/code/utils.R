devtools::load_all(".")

library(mami.codi.R)
library(furrr)
library(purrr)
library(parallelly)

prepare <- function(rds) {
  if (file.exists(rds)) {
    file.remove(rds)
  }
  saveRDS('test',rds)
  test = readRDS(rds)
  checkmate::assert_true(test == 'test')
  file.remove(rds)
}
rad_to_deg <- function(rad) {
  rad * 180 / pi
}
GOLDEN_RATIO   = (1+sqrt(5)) / 2

type = c(rep('Dual Dyads',12),rep('Dyads',13))
mono_label = c('m2', 'M2','m3','M3','P4','tt','P5', 'm6', 'M6','m7','M7','P8')
dual_label = paste0('d.',rev(mono_label))
label = c(dual_label,'P1',mono_label)

dyads = tibble::tibble(
  pitches = -12:12 %>% purrr::map(\(i) {c(60,60+i, 72)}),
  tonic   = NA,
  metadata = purrr::map2(label, type, \(l,t) {list(label=l,type=t)})
)

major_triad      = c(60,64,67)
minor_triad      = c(60,63,67)
diminished_triad = c(60,63,66)

triads = tibble::tibble(
  pitches = list(
    major_triad,
    c(60,64-12,67-12),
    c(60,64,67-12),
    c(60,65,69),
    c(60,60-4,60-7),
    minor_triad,
    c(60,63-12,67-12),
    c(60,63,67-12),
    c(60,65,68),
    c(60,60-3,60-7)),
  tonic   = 60,
  metadata = list(
    list(label='Major',type='Triads'),
    list(label='Major 1st Inv',type='Triads'),
    list(label='Major 2nd Inv',type='Triads'),
    list(label='Major 6:4',type='Triads'),
    list(label='Phrygian',type='Triads'),
    list(label='Minor',type='Triads'),
    list(label='Minor 1st Inv',type='Triads'),
    list(label='Minor 2nd Inv',type='Triads'),
    list(label='Minor 6:4',type='Triads'),
    list(label='Mixolydian',type='Triads')
  )
)
progressions = tibble::tibble(
  pitches = list(
    # major chord progression
    major_triad,
    minor_triad+2,
    minor_triad+4,
    major_triad+5,
    major_triad+7,
    minor_triad+9,
    diminished_triad+11,
    major_triad,
    # minor chord progression
    minor_triad,
    diminished_triad+2,
    major_triad+3,
    minor_triad+5,
    minor_triad+7,
    major_triad+8,
    major_triad+10,
    minor_triad
  ),
  tonic   = 60,
  metadata = list(
    # major chord progression
    list(label='I',    type='Major Triad Progressions'),
    list(label='ii',   type='Major Triad Progressions'),
    list(label='iii',  type='Major Triad Progressions'),
    list(label='IV',   type='Major Triad Progressions'),
    list(label='V',    type='Major Triad Progressions'),
    list(label='vi',   type='Major Triad Progressions'),
    list(label='vii*', type='Major Triad Progressions'),
    list(label='',     type='Major Triad Progressions'),
    # minor chord progression
    list(label='i',    type='Minor Triad Progressions'),
    list(label='ii*',  type='Minor Triad Progressions'),
    list(label='III',  type='Minor Triad Progressions'),
    list(label='iv',   type='Minor Triad Progressions'),
    list(label='v',    type='Minor Triad Progressions'),
    list(label='VI',   type='Minor Triad Progressions'),
    list(label='VII',  type='Minor Triad Progressions'),
    list(label='',     type='Minor Triad Progressions')
  )
)

mono_label = c('Ionian','Phrygian','Aeolian','Mixolydian',
               'Dorian',
               'Locrian', 'Lydian', 'Chromatic')
dual_label = paste0('d.',rev(mono_label))
label = c(mono_label,dual_label)
type = c(rep('Scales',length(label)/2),rep('Dual Scales',length(label)/2))
pitches = rep(list(60+c(0,2,4,5,7,9,11,12), 60+c(0,1,3,5,7,8,10,12),
                   60+c(0,2,3,5,7,8,10,12), 60+c(0,2,4,5,7,9,10,12),
                   60+c(0,2,3,5,7,9,10,12),
                   60+c(0,1,3,5,6,8,10,12), 60+c(0,2,4,6,7,9,11,12),
                   60+0:12),2)
tonic = c(rep(60,length(label)/2),rep(72,length(label)/2))

scales = tibble::tibble(
  pitches,
  tonic,
  metadata = purrr::map2(label, type, \(l,t) {list(label=l,type=t)})
)

chords = dplyr::bind_rows(dyads, triads, progressions, scales)

chords = chords %>% dplyr::rowwise() %>% dplyr::mutate(
  label = metadata$label,
  type  = metadata$type,
  .before=1
)

z_scores <- function(x) {
  sd = sd(x)
  if (sd == 0) {
    0
  }  else {
    (x-mean(x)) / sd(x)
  }
}

