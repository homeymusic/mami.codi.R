smoothing_file = '../code/smooth_2d_gaussian.cpp'
if (file.exists(smoothing_file)) {
  Rcpp::sourceCpp(smoothing_file)
} else {
  Rcpp::sourceCpp('./man/code/smooth_2d_gaussian.cpp')
}
smoothed <- function(x,val,sigma=0.2) {
  y = rep(0.0, times = length(x))
  smooth_2d_gaussian(
    data_x   = x,
    data_y   = y,
    data_val = val,
    probe_x  = x,
    probe_y  = y,
    sigma_x  = sigma,
    sigma_y  = sigma
  )
}
colors_homey <- list(
  'background'        = '#664433',
  'highlight'         = '#C18160',
  'foreground'        = '#291B14',
  'subtle_foreground' = '#7F745A',
  'minor'             = '#8AC5FF',
  'minor_dark'        = '#6894BF',
  'neutral'           = '#F3DDAB',
  'major'             = '#FFB000',
  'major_dark'        = '#BF8400',
  'light_neutral'     = '#FFF6E2',
  'fundamental'       = '#FF5500',
  'green'             = '#74DE7E',
  'gray'              = '#C0C0C0'
)
color_factor_homey <- function(x,column_name) {
  cut(x[[column_name]],c(-Inf,-1e-6,1e-6,Inf),labels=c("minor","neutral","major"))
}
color_values_homey <- function() {
  c("minor"=colors_homey$minor,
    "neutral"=colors_homey$fundamental,
    "major"=colors_homey$major,
    'behavioral'=colors_homey$neutral)
}
space_time_colors <- function() {
  c('spatial'=colors_homey$minor,
    'temporal'=colors_homey$major,
    'behavioral'=colors_homey$neutral)
}
theme_homey <- function(aspect.ratio=NULL){
  font <- "Helvetica"   #assign font family up front

  ggplot2::theme_minimal()

  ggplot2::`%+replace%`  #replace elements we want to change

  ggplot2::theme(
    plot.title = ggplot2::element_text(color=colors_homey$foreground),
    axis.title = ggplot2::element_text(color=colors_homey$foreground),
    axis.text = ggplot2::element_text(color=colors_homey$foreground),
    axis.ticks = ggplot2::element_blank(),
    plot.background = ggplot2::element_rect(fill = colors_homey$neutral),
    panel.background = ggplot2::element_rect(fill = colors_homey$background),
    panel.grid.major = ggplot2::element_line(color = colors_homey$foreground, linewidth=0.2),
    panel.grid.minor = ggplot2::element_line(color = colors_homey$foreground, linewidth=0.05, linetype ="dashed"),
    legend.background = ggplot2::element_rect(fill = colors_homey$light_neutral),
    legend.key = ggplot2::element_rect(fill = colors_homey$background, color = NA),
    legend.position='bottom',
    aspect.ratio = aspect.ratio
  )
}
theme_homey_minimal <- function(aspect.ratio=NULL){
  font <- "Helvetica"   #assign font family up front

  ggplot2::theme_minimal()

  ggplot2::`%+replace%`  #replace elements we want to change

  ggplot2::theme(
    plot.title = ggplot2::element_blank(),
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    plot.background = ggplot2::element_blank(),
    panel.background = ggplot2::element_rect(fill = colors_homey$background),
    panel.grid.major = ggplot2::element_line(color = colors_homey$foreground, linewidth=0.2),
    panel.grid.minor = ggplot2::element_line(color = colors_homey$foreground, linewidth=0.05, linetype ="dashed"),
    legend.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    aspect.ratio = aspect.ratio
  )
}
path_homey <- function() {
}
plot_mami.codi <- function(chords, title='', chords_to_label=NULL,include_labels=F,
                           include_path=FALSE, aspect.ratio=NULL,
                           minimal=F) {

  if (is_null(chords_to_label)) {
    chords_to_label = chords
  }

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$majorness,
                                       y = .data$dissonance)) +
    ggplot2::geom_vline(xintercept = 0, color = colors_homey$neutral) +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(chords,'majorness'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    {if (include_path) {
      ggplot2::geom_path(
        ggplot2::aes(group=1,
                     color=color_factor_homey(chords,'majorness')),
        arrow = grid::arrow(length = grid::unit(0.1, "inches"),
                            ends = "last", type = "closed")
      )
    }} +
    {  if (include_labels) {
      ggrepel::geom_text_repel(data=chords_to_label,
                               ggplot2::aes(label=label,
                                            color=color_factor_homey(
                                              chords_to_label,'majorness')),
                               segment.color = colors_homey$subtle_foreground,
                               max.overlaps = Inf,
                               family='Arial Unicode MS')}} +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(mult = 0.2),
      limits=c((0-max(abs(chords$majorness))),
               (0+max(abs(chords$majorness))))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_smoothed_mami.codi <- function(chords, title='', chords_to_label=NULL,
                                    include_path=FALSE, aspect.ratio=NULL,
                                    minimal=F, sigma=0.25) {

  chords$smoothed_dissonance = smoothed(chords$semitone,
                                                   chords$dissonance,
                                                   sigma)

  chords = chords %>% dplyr::filter(semitone %in% 0:12)

  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }

  ggplot2::ggplot(chords, ggplot2::aes(x = major,
                                       y = smoothed_dissonance)) +
    ggplot2::geom_vline(xintercept = 0, color = colors_homey$neutral) +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(chords,'majorness'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    {if (include_path) {
      ggplot2::geom_path(
        ggplot2::aes(group=1,
                     color=color_factor_homey(chords,'majorness')),
        arrow = grid::arrow(length = grid::unit(0.1, "inches"),
                            ends = "last", type = "closed")
      )
    }} +
    ggrepel::geom_text_repel(data=chords_to_label,
                             ggplot2::aes(label=label,
                                          color=color_factor_homey(
                                            chords_to_label,'majorness')),
                             segment.color = colors_homey$subtle_foreground,
                             max.overlaps = Inf) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(mult = 0.2),
      limits=c((0-max(abs(chords$majorness))),
               (0+max(abs(chords$majorness))))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_dilo.dihi <- function(chords, title, chords_to_label=NULL,
                           tonic_index=1, include_abline=F, aspect.ratio=NULL,
                           minimal=F) {
  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }
  slope = chords$spatial_dissonance[tonic_index] / chords$period_dissonance[tonic_index]
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$period_dissonance,
                                       y = .data$spatial_dissonance)) +
    { if(include_abline) ggplot2::geom_abline(slope = slope, color = colors_homey$neutral) } +
    ggplot2::geom_point(shape=21, stroke=NA, size=0.5, fill=colors_homey$neutral) +
    ggrepel::geom_text_repel(data=chords_to_label, color=colors_homey$neutral,
                             ggplot2::aes(label=label),
                             segment.color = colors_homey$subtle_foreground,
                             max.overlaps = Inf,
                             family='Arial Unicode MS') +
    ggplot2::scale_color_manual(guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(
      limits=c(0,max(c(chords$period_dissonance,chords$spatial_dissonance)))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_cofreq.cowave <- function(chords, title, chords_to_label=NULL,
                               tonic_index=1, include_abline=T, aspect.ratio=NULL,
                               minimal=F, include_labels=F) {
  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }
  slope = chords$spatial_dissonance[tonic_index] / chords$temporal_dissonance[tonic_index]
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$temporal_dissonance,
                                       y = .data$spatial_dissonance)) +
    { if(include_abline) ggplot2::geom_abline(slope = slope, color = colors_homey$neutral) } +
    ggplot2::geom_point(shape=21, stroke=NA, size=0.5, fill=colors_homey$neutral) +
    { if (include_labels)
      ggrepel::geom_text_repel(data=chords_to_label, color=colors_homey$neutral,
                               ggplot2::aes(label=label),
                               segment.color = colors_homey$subtle_foreground,
                               max.overlaps = Inf,
                               family='Arial Unicode MS')} +
    ggplot2::scale_color_manual(guide='none') +
    ggplot2::ggtitle(title) +
    # ggplot2::coord_fixed() +
    # ggplot2::scale_x_continuous(
    #   limits=c(min(c(chords$temporal_dissonance,chords$spatial_dissonance)),
    #            max(c(chords$temporal_dissonance,chords$spatial_dissonance)))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_error_hist <- function(errors, bins=21, signal, standard_deviation, title='') {
  px = pretty(c(-standard_deviation, errors, standard_deviation))
  ggplot2::ggplot(tibble::tibble(errors), ggplot2::aes(errors)) +
    ggplot2::geom_histogram(
      fill = colors_homey[signal],
      bins = bins
    ) +
    ggplot2::scale_x_continuous(
      breaks = px,
      limits = range(px)
    ) +
    ggplot2::geom_vline(
      xintercept = c(-standard_deviation, standard_deviation),
      color=colors_homey$highlight,
      linetype = 'dotted'
    ) +
    ggplot2::annotate(
      x=-standard_deviation,
      y=+Inf,
      label=round(-standard_deviation,5),
      vjust=2,
      geom='label',
      fill=colors_homey$neutral,
      color=colors_homey$background
    ) +
    ggplot2::annotate(
      x=standard_deviation,
      y=+Inf,
      label=round(standard_deviation,5),
      vjust=2,
      geom='label',
      fill=colors_homey$neutral,
      color=colors_homey$background
    ) +
    ggplot2::ggtitle(title) +
    theme_homey()
}

plot_semitone_codi <- function(chords, title='', include_line=T, sigma=0.2,
                               include_points=T,
                               include_linear_regression = F, goal=NULL,
                               black_vlines=c(),gray_vlines=c()) {


  color_factor_homey <- function(x,column_name) {
    cut(x[[column_name]],c(-Inf,-1e-6,1e-6,Inf),labels=c("minor","neutral","major"))
  }

  chords$smoothed.dissonance = smoothed(chords$semitone,
                                                   chords$dissonance_z,
                                                   sigma)

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$dissonance_z)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(shape=21, stroke=NA, size=1,
                          ggplot2::aes(fill=color_factor_homey(chords,'majorness')))
    } +
    { if (include_linear_regression) ggplot2::stat_smooth(method=lm)} +
    { if (include_line)
      ggplot2::geom_line(data=chords,
                         ggplot2::aes(x = semitone,
                                      y = smoothed.dissonance,
                                      color=color_factor_homey(chords,'majorness'),
                                      group=1), linewidth = 1)} +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         ggplot2::aes(x = semitone,
                                      y = dissonance,
                                      color = 'behavioral'
                         ), linewidth = 0.5)} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey()) +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = -15:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance (Z-Score)') +
    ggplot2::xlab('Semitone') +
    ggplot2::labs(color = NULL) +
    theme_homey()
}
plot_semitone_mami <- function(chords, title='', include_line=T, sigma=0.2,
                               include_points=T,
                               include_linear_regression = F, goal=NULL,
                               black_vlines=c(),gray_vlines=c()) {
  chords$smoothed.major = smoothed(chords$semitone,
                                         chords$majorness,
                                         sigma)

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$majorness)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(shape=21, stroke=NA, size=1,
                          ggplot2::aes(fill=color_factor_homey(chords,'majorness')))
    } +
    { if (include_linear_regression) ggplot2::stat_smooth(method=lm)} +
    { if (include_line)
      ggplot2::geom_line(data=chords,
                         ggplot2::aes(x = semitone,
                                      y = smoothed.major,
                                      color=color_factor_homey(chords,'majorness'),
                                      group=1), linewidth = 1)} +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         ggplot2::aes(x = semitone,
                                      y = dissonance,
                                      color = 'behavioral'
                         ), linewidth = 0.5)} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey()) +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = -15:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Major-Minor (Z-Score)') +
    ggplot2::xlab('Semitone') +
    ggplot2::labs(color = NULL) +
    theme_homey()
}
plot_semitone_spatial_temporal <- function(chords, title='', include_line=T, sigma=0.2,
                                           dashed_minor = F,include_points=T,
                                           include_linear_regression = F, goal=NULL,
                                           black_vlines=c(),gray_vlines=c()) {

  chords$smoothed.temporal_dissonance = smoothed(chords$semitone,
                                                 chords$temporal_dissonance,
                                                 sigma)
  chords$smoothed.spatial_dissonance = smoothed(chords$semitone,
                                                chords$spatial_dissonance,
                                                sigma)

  mean_theoretical = mean(c(chords$smoothed.temporal_dissonance,
                            chords$smoothed.spatial_dissonance))

  linetype_for_minor = if (dashed_minor) {'dashed'} else {'solid'}

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(ggplot2::aes(y = .data$temporal_dissonance),
                          shape=21, stroke=NA, size=1,
                          fill=colors_homey$major)
    } +
    { if (include_points)
      ggplot2::geom_point(ggplot2::aes(y = .data$spatial_dissonance),
                          shape=21, stroke=NA, size=1,
                          fill=colors_homey$minor)
    } +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$smoothed.temporal_dissonance,
      color = 'temporal'),
      linewidth = 1) +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$smoothed.spatial_dissonance,
      color = 'spatial'),
      linewidth = 1,
      linetype = linetype_for_minor) +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         ggplot2::aes(x = semitone,
                                      y = dissonance + mean_theoretical,
                                      color = 'behavioral',
                                      group=1), linewidth = 0.5)} +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::guides(col = ggplot2::guide_legend()) +
    ggplot2::ylab('Consonance') +
    ggplot2::xlab('Semitone') +
    ggplot2::scale_color_manual(
      values=space_time_colors(),
      breaks=c('spatial', 'temporal', 'behavioral')) +
    ggplot2::labs(color = NULL) +
    theme_homey()
}
plot_semitone_spatial <- function(chords, title='', include_line=T, sigma=0.2,
                                  dashed_minor = F,include_points=T,
                                  include_linear_regression = F, goal=NULL,
                                  black_vlines=c(),gray_vlines=c()) {

  chords$smoothed.spatial_dissonance = smoothed(chords$semitone,
                                                chords$spatial_dissonance,
                                                sigma)

  linetype_for_minor = if (dashed_minor) {'dashed'} else {'solid'}

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(ggplot2::aes(y = .data$spatial_dissonance),
                          shape=21, stroke=NA, size=1,
                          fill=colors_homey$minor)
    } +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$smoothed.spatial_dissonance,
      color = 'spatial'),
      linewidth = 1,
      linetype = linetype_for_minor) +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::guides(col = ggplot2::guide_legend()) +
    ggplot2::ylab('Spatial Consonance') +
    ggplot2::xlab('Semitone') +
    ggplot2::scale_color_manual(
      values=space_time_colors(),
      breaks=c('spatial', 'temporal', 'behavioral')) +
    ggplot2::labs(color = NULL) +
    theme_homey()
}
plot_semitone_temporal <- function(chords, title='', include_line=T, sigma=0.2,
                                   dashed_minor = F,include_points=T,
                                   include_linear_regression = F, goal=NULL,
                                   black_vlines=c(),gray_vlines=c()) {

  chords$smoothed.temporal_dissonance = smoothed(chords$semitone,
                                                 chords$temporal_dissonance,
                                                 sigma)

  linetype_for_minor = if (dashed_minor) {'dashed'} else {'solid'}

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(ggplot2::aes(y = .data$temporal_dissonance),
                          shape=21, stroke=NA, size=1,
                          fill=colors_homey$major)
    } +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$smoothed.temporal_dissonance,
      color = 'temporal'),
      linewidth = 1,
      linetype = linetype_for_minor) +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::guides(col = ggplot2::guide_legend()) +
    ggplot2::ylab('Temporal Consonance') +
    ggplot2::xlab('Semitone') +
    ggplot2::scale_color_manual(
      values=space_time_colors(),
      breaks=c('spatial', 'temporal', 'behavioral')) +
    ggplot2::labs(color = NULL) +
    theme_homey()
}
plot_semitone_co <- function(chords, title='') {
  temporal_semitone =chords$semitone %>% min
  spatial_semitone =chords$semitone %>% max
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$consonance)) +
    ggplot2::geom_point(color=colors_homey$neutral) +
    ggplot2::scale_x_continuous(breaks = seq(temporal_semitone,spatial_semitone),
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    theme_homey()
}
plot_semitone_temporal_standard_deviation <- function(chords, title='') {
  temporal_semitone =chords$semitone %>% min
  spatial_semitone =chords$semitone %>% max
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$temporal_standard_deviation)) +
    ggplot2::geom_point(color=colors_homey$neutral, size=0.5) +
    ggplot2::scale_x_continuous(breaks = seq(temporal_semitone,spatial_semitone),
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    theme_homey()
}
plot_semitone_rotation_angle <- function(chords, title='') {
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$rotation_angle * 180 / pi,1)) +
    ggplot2::geom_point(color=colors_homey$neutral, size=0.5) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    ggplot2::ylab('Rotation Angle (degs)') +
    theme_homey()
}
plot_semitone_registers <- function(chords, title='') {
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone)) +
    ggplot2::geom_point(color=colors_homey$minor, size=0.5,
                        ggplot2::aes(y = max(.data$frequencies[[1]]))) +
    ggplot2::geom_point(color=colors_homey$major, size=0.5,
                        ggplot2::aes(y = min(.data$frequencies[[1]]))) +
    ggplot2::geom_point(color=colors_homey$fundamental, size=0.0625,
                        ggplot2::aes(y = max(.data$frequencies[[1]]))) +
    ggplot2::geom_point(color=colors_homey$fundamental, size=0.0625,
                        ggplot2::aes(y = min(.data$frequencies[[1]]))) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::scale_y_continuous(breaks=round(hrep::midi_to_freq(48)*2^(0:7),1),
                                minor_breaks=c(),
                                trans='log2') +
    ggplot2::ggtitle(title) +
    ggplot2::ylab('Ref Freqs & Tonic Timbre') +
    theme_homey()
}

plot_num_harmonics_deviation <- function(num_harmonics_deviation, title='') {
  num_harmonics = num_harmonics_deviation$num_harmonics
  ggplot2::ggplot(num_harmonics_deviation, ggplot2::aes(x = .data$num_harmonics)) +
    ggplot2::geom_point(ggplot2::aes(y = .data$candidate_deviation),
                        color=colors_homey$green, size=0.5) +
    ggplot2::geom_point(ggplot2::aes(y = .data$min),
                        color=colors_homey$major, size=0.5) +
    ggplot2::geom_point(ggplot2::aes(y = .data$median),
                        color=colors_homey$fundamental, size=0.5) +
    ggplot2::geom_point(ggplot2::aes(y = .data$max),
                        color=colors_homey$minor, size=0.5) +
    ggplot2::geom_point(ggplot2::aes(y = .data$range),
                        color=colors_homey$neutral, size=0.5) +
    ggplot2::scale_x_continuous(breaks = num_harmonics,
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    theme_homey()
}
plot_semitone_codi_grid <- function(theory, experiment,
                                    black_vlines=c(), gray_vlines=c(),
                                    include_points=T,
                                    title) {
  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation = theory$temporal_standard_deviation %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_temporal_standard_deviation,temporal_standard_deviation) {
      tols = paste(
        'temporal_standard_deviation:', temporal_standard_deviation
      )
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=z_score)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::geom_line(
      data=experiment,
      color    = colors_homey$neutral,
      ggplot2::aes(x = semitone, y = rating)) +
    ggplot2::geom_line(
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1,
                   color=color_factor_homey(theory,'majorness'))) +
    { if (include_points)
      ggplot2::geom_point(shape=21, stroke=NA, size=1,
                          ggplot2::aes(fill=color_factor_homey(theory,'majorness')))
    } +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                                          vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_grid(temporal_standard_deviation ~ temporal_standard_deviation, scales = 'free_y') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_codi_wrap <- function(theory, experiment,
                                    black_vlines=c(), gray_vlines=c(),
                                    title,ncols=12,
                                    include_points=T) {

  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation  = theory$temporal_standard_deviation  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_standard_deviation) {
      tols = paste0('   temporal_standard_deviation:', temporal_standard_deviation)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    {if (include_points)
      ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                          ggplot2::aes(x = semitone, y = z_score,
                                       fill=color_factor_homey(theory,'majorness')))} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::geom_line(
      data=experiment,
      color    = colors_homey$neutral,
      ggplot2::aes(x = semitone, y = dissonance)) +
    ggplot2::geom_line(
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1,
                   color=color_factor_homey(theory,'majorness'))) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~temporal_standard_deviation,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_spatial_wrap <- function(theory,
                                       black_vlines=c(), gray_vlines=c(),
                                       title,ncols=1) {
  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation  = theory$temporal_standard_deviation  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_standard_deviation) {
      tols = paste0('   temporal_standard_deviation:', temporal_standard_deviation)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$minor,
                        ggplot2::aes(x = semitone, y = spatial_dissonance)) +
    ggplot2::geom_line(
      color=colors_homey$minor,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1)) +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~temporal_standard_deviation,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_temporal_wrap <- function(theory,
                                        black_vlines=c(), gray_vlines=c(),
                                        title,ncols=1) {
  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation  = theory$temporal_standard_deviation  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_standard_deviation) {
      tols = paste0('   temporal_standard_deviation:', temporal_standard_deviation)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$major,
                        ggplot2::aes(x = semitone, y = temporal_dissonance)) +
    ggplot2::geom_line(
      color=colors_homey$major,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1)) +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~temporal_standard_deviation,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_spatial_temporal_wrap <- function(theory,
                                                black_vlines=c(), gray_vlines=c(),
                                                title,ncols=1) {
  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation  = theory$temporal_standard_deviation  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_standard_deviation) {
      tols = paste0('   temporal_standard_deviation:', temporal_standard_deviation)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$minor,
                        ggplot2::aes(x = semitone, y = max(temporal_dissonance) - temporal_dissonance)) +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$major,
                        ggplot2::aes(x = semitone, y = max(spatial_dissonance) - spatial_dissonance)) +
    ggplot2::geom_line(
      color=colors_homey$minor,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth_temporal,
                   group=1)) +
    ggplot2::geom_line(
      color=colors_homey$major,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth_spatial,
                   group=1)) +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~temporal_standard_deviation,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_mami_wrap <- function(theory, experiment,
                                    black_vlines=c(), gray_vlines=c(),
                                    title,ncols=12) {
  per_plot_labels = tidyr::expand_grid(
    temporal_standard_deviation  = theory$temporal_standard_deviation  %>% unique,
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(temporal_standard_deviation) {
      tols = paste0('  ', temporal_standard_deviation)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=major)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        ggplot2::aes(x = semitone, y = major,
                                     fill=color_factor_homey(theory,'majorness'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~temporal_standard_deviation,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_behavioral_codi <- function(experiment_raw,
                                          experiment_smooth,
                                          title='',
                                          sigma=0.2,
                                          black_vlines=c(),
                                          gray_vlines=c()) {
  experiment_raw$smoothed.dissonance = smoothed(experiment_raw$semitone,
                                                           experiment_raw$dissonance_z,
                                                           sigma)

  ggplot2::ggplot(experiment_raw, ggplot2::aes(x = .data$semitone,
                                               y = .data$dissonance_z)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        fill=colors_homey$highlight) +
    ggplot2::geom_line(data=experiment_smooth,
                       color    = colors_homey$subtle_foreground,
                       ggplot2::aes(x = semitone,
                                    y = dissonance,
                                    group=1), linewidth = 0.5) +
    ggplot2::geom_line(data=experiment_raw,
                       color=colors_homey$fundamental,
                       ggplot2::aes(x = semitone,
                                    y = smoothed.dissonance,
                                    group=1), linewidth = 1) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance-Dissonance Z-Score') +
    theme_homey()
}

plot_semitone_codi_raw <- function(theory_raw,
                                   experiment_raw,
                                   sigma=0.2,
                                   black_vlines=c(),
                                   gray_vlines=c(),
                                   title='') {

  theory_raw$smoothed.dissonance = smoothed(theory_raw$semitone,
                                                       theory_raw$dissonance_z,
                                                       sigma)

  experiment_raw$smoothed.dissonance = smoothed(experiment_raw$semitone,
                                                           experiment_raw$dissonance_z,
                                                           sigma)

  ggplot2::ggplot(theory_raw, ggplot2::aes(x = .data$semitone,
                                           y = .data$dissonance_z)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(theory_raw,'majorness'))) +
    ggplot2::geom_line(data=theory_raw,
                       ggplot2::aes(x = semitone,
                                    y = smoothed.dissonance,
                                    color=color_factor_homey(theory_raw,'majorness'),
                                    group=1), linewidth = 0.65) +
    ggplot2::geom_line(data=experiment_raw,
                       color=colors_homey$neutral,
                       ggplot2::aes(x = semitone,
                                    y = smoothed.dissonance,
                                    group=1), linewidth = 0.65) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance-Dissonance Z-Score') +
    theme_homey()
}
plot_semitone_codi_smooth <- function(chords, title='', include_line=T,
                                      sigma=0.2,sigma2=2.0,
                                      include_points=T,
                                      include_linear_regression = F, goal=NULL,
                                      black_vlines=c(),gray_vlines=c()) {
  chords$smoothed.dissonance = smoothed(chords$semitone,
                                                   chords$dissonance,
                                                   sigma)

  chords$smoothed2.dissonance = smoothed(chords$semitone,
                                                    chords$dissonance,
                                                    sigma2)

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$dissonance)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(shape=21, stroke=NA, size=1,
                          ggplot2::aes(fill=color_factor_homey(chords,'majorness')))
    } +
    { if (include_linear_regression) ggplot2::stat_smooth(method=lm)} +
    { if (include_line)
      ggplot2::geom_line(data=chords,
                         ggplot2::aes(x = semitone,
                                      y = smoothed.dissonance,
                                      color=color_factor_homey(chords,'majorness'),
                                      group=1), linewidth = 1)} +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         color    = colors_homey$neutral,
                         ggplot2::aes(x = semitone,
                                      y = dissonance,
                                      group=1), linewidth = 0.5)} +
    ggplot2::geom_line(data=chords,
                       color=colors_homey$green,
                       ggplot2::aes(x = semitone,
                                    y = smoothed2.dissonance,
                                    group=1), linewidth = 1) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = -15:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance-Dissonance') +
    theme_homey()
}

plot_periodicity <- function(ratios, lcd, dimension,
                             c_sound = NULL,
                             relative = T) {

  if (dimension=='wavelength') {
    fill_color   = colors_homey$minor
    border_color = colors_homey$minor_dark
    max_tone = ratios$tone %>% max()
    max_ratio = ratios %>% dplyr::arrange(dplyr::desc(tone)) %>% dplyr::slice(1)
    max_num = max_ratio$num
    max_den = max_ratio$den
  } else if (dimension=='frequency') {
    fill_color   = colors_homey$major
    border_color = colors_homey$major_dark
    min_tone = ratios$tone %>% min()
  }
  brickwork = ratios %>% purrr::pmap_dfr(\( index,
                                            num,
                                            den,
                                            tone,
                                            freq,
                                            midi) {
    course_of_bricks <- tibble::tibble(
      xmin = numeric(),
      xmax = numeric(),
      ymin = numeric(),
      ymax = numeric()
    )
    if (dimension=='wavelength') {
      if (relative) {
        ratio_to_max = (num / den) / (max_num / max_den)
        brick_count  = floor(lcd / ratio_to_max)
        brick_width  = max_tone * ratio_to_max
      } else {
        brick_width = tone
        brick_count = 1
      }
    } else if (dimension=='frequency') {
      if (relative) {
        brick_width = 1 / tone
        brick_count = floor(lcd * (num / den))
      } else {
        brick_width = 1 / tone
        brick_count = 1
      }
    }
    for (brick in 0:(brick_count-1)) {
      course_of_bricks = course_of_bricks %>% tibble::add_row(
        xmin = brick*brick_width,
        xmax = brick*brick_width + brick_width,
        ymin = midi - 0.5,
        ymax = midi + 0.5
      )
    }
    course_of_bricks
  })
  if (dimension=='wavelength') {
    xlab = bquote('Wavelength'~(m))
    scaled_label = scales::label_number(scale = 1e+00)
  } else if (dimension=='frequency') {
    xlab = bquote('Period'~(ms))
    scaled_label = scales::label_number(scale = 1e03)
  }
  ggplot2::ggplot(brickwork, ggplot2::aes(
    xmin=xmin,
    xmax=xmax,
    ymin=ymin,
    ymax=ymax
  )) +
    ggplot2::geom_rect(fill=fill_color, color=border_color) +
    ggplot2::xlab(xlab) +
    ggplot2::ylab("MIDI") +
    ggplot2::scale_x_continuous(labels = scaled_label) +
    theme_homey()
}

plot_semitone_codi_wrap_amp <- function(theory, experiment,
                                        black_vlines=c(), gray_vlines=c(),
                                        title,ncols=12,
                                        include_points=T) {
  per_plot_labels = tidyr::expand_grid(
    amplitude  = theory$amplitude  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(amplitude) {
      tols = paste0('   amplitude:', amplitude)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    {if (include_points)
      ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                          ggplot2::aes(x = semitone, y = z_score,
                                       fill=color_factor_homey(theory,'majorness')))} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::geom_line(
      data=experiment,
      color    = colors_homey$neutral,
      ggplot2::aes(x = semitone, y = dissonance)) +
    ggplot2::geom_line(
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1,
                   color=color_factor_homey(theory,'majorness'))) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~amplitude,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_spatial_wrap_amp <- function(theory,
                                           black_vlines=c(), gray_vlines=c(),
                                           title,ncols=1) {
  per_plot_labels = tidyr::expand_grid(
    amplitude  = theory$amplitude  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(amplitude) {
      tols = paste0('   amplitude:', amplitude)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$minor,
                        ggplot2::aes(x = semitone, y = spatial_dissonance)) +
    ggplot2::geom_line(
      color=colors_homey$minor,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1)) +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~amplitude,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_temporal_wrap_amp <- function(theory,
                                            black_vlines=c(), gray_vlines=c(),
                                            title,ncols=1) {
  per_plot_labels = tidyr::expand_grid(
    amplitude  = theory$amplitude  %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(amplitude) {
      tols = paste0('   amplitude:', amplitude)
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        fill=colors_homey$major,
                        ggplot2::aes(x = semitone, y = temporal_dissonance)) +
    ggplot2::geom_line(
      color=colors_homey$major,
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1)) +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~amplitude,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
