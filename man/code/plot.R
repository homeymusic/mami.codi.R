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
  'minor'             = '#ABDAF3',
  'neutral'           = '#F3DDAB',
  'major'             = '#F3A904',
  'light_neutral'     = '#FFF6E2',
  'fundamental'       = '#FF5500',
  'green'             = '#74DE7E',
  'gray'              = '#C0C0C0'
)
color_factor_homey <- function(x,column_name) {
  cut(x[[column_name]],c(-Inf,-1e-6,1e-6,Inf),labels=c("minor","neutral","major"))
}
color_values_homey <- function() {
  c("minor"=colors_homey$minor,"neutral"=colors_homey$fundamental,"major"=colors_homey$major)
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

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$major_minor,
                                       y = .data$consonance_dissonance)) +
    ggplot2::geom_vline(xintercept = 0, color = colors_homey$neutral) +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(chords,'major_minor'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    {if (include_path) {
      ggplot2::geom_path(
        ggplot2::aes(group=1,
                     color=color_factor_homey(chords,'major_minor')),
        arrow = grid::arrow(length = grid::unit(0.1, "inches"),
                            ends = "last", type = "closed")
      )
    }} +
    {  if (include_labels) {
      ggrepel::geom_text_repel(data=chords_to_label,
                               ggplot2::aes(label=label,
                                            color=color_factor_homey(
                                              chords_to_label,'major_minor')),
                               segment.color = colors_homey$subtle_foreground,
                               max.overlaps = Inf,
                               family='Arial Unicode MS')}} +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(mult = 0.2),
      limits=c((0-max(abs(chords$major_minor))),
               (0+max(abs(chords$major_minor))))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_smoothed_mami.codi <- function(chords, title='', chords_to_label=NULL,
                           include_path=FALSE, aspect.ratio=NULL,
                           minimal=F, sigma=0.25) {

  chords$smoothed_consonance_dissonance = smoothed(chords$semitone,
                                                   chords$consonance_dissonance,
                                                   sigma)

  chords = chords %>% dplyr::filter(semitone %in% 0:12)

  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }

  ggplot2::ggplot(chords, ggplot2::aes(x = major_minor,
                                          y = smoothed_consonance_dissonance)) +
    ggplot2::geom_vline(xintercept = 0, color = colors_homey$neutral) +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(chords,'major_minor'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    {if (include_path) {
      ggplot2::geom_path(
        ggplot2::aes(group=1,
                     color=color_factor_homey(chords,'major_minor')),
        arrow = grid::arrow(length = grid::unit(0.1, "inches"),
                            ends = "last", type = "closed")
      )
    }} +
    ggrepel::geom_text_repel(data=chords_to_label,
                             ggplot2::aes(label=label,
                                          color=color_factor_homey(
                                            chords_to_label,'major_minor')),
                             segment.color = colors_homey$subtle_foreground,
                             max.overlaps = Inf) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(mult = 0.2),
      limits=c((0-max(abs(chords$major_minor))),
               (0+max(abs(chords$major_minor))))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_dilo.dihi <- function(chords, title, chords_to_label=NULL,
                           tonic_index=1, include_abline=F, aspect.ratio=NULL,
                           minimal=F) {
  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }
  slope = chords$dissonance_wavelength[tonic_index] / chords$dissonance_frequency[tonic_index]
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$dissonance_frequency,
                                       y = .data$dissonance_wavelength)) +
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
      limits=c(0,max(c(chords$dissonance_frequency,chords$dissonance_wavelength)))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_colo.cohi <- function(chords, title, chords_to_label=NULL,
                           tonic_index=1, include_abline=T, aspect.ratio=NULL,
                           minimal=F) {
  if (is.null(chords_to_label)) {
    chords_to_label = chords
  }
  slope = chords$consonance_wavelength[tonic_index] / chords$consonance_frequency[tonic_index]
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$consonance_frequency,
                                       y = .data$consonance_wavelength)) +
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
      limits=c(min(c(chords$consonance_frequency,chords$consonance_wavelength)),
                   max(c(chords$consonance_frequency,chords$consonance_wavelength)))) +
    {if (minimal) theme_homey_minimal(aspect.ratio=aspect.ratio) else theme_homey(aspect.ratio=aspect.ratio)}
}
plot_semitone_codi <- function(chords, title='', include_line=T, sigma=0.2,
                               include_points=T,
                               include_linear_regression = F, goal=NULL,
                               black_vlines=c(),gray_vlines=c()) {
  frequency_semitone  = chords$semitone %>% min
  wavelength_semitone = chords$semitone %>% max
  chords$smoothed.consonance_dissonance = smoothed(chords$semitone,
                                                   chords$consonance_dissonance_z,
                                                   sigma)

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$consonance_dissonance_z)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    { if (include_points)
      ggplot2::geom_point(shape=21, stroke=NA, size=1,
                          ggplot2::aes(fill=color_factor_homey(chords,'major_minor')))
    } +
    { if (include_linear_regression) ggplot2::stat_smooth(method=lm)} +
    { if (include_line)
      ggplot2::geom_line(data=chords,
                         ggplot2::aes(x = semitone,
                                      y = smoothed.consonance_dissonance,
                                      color=color_factor_homey(chords,'major_minor'),
                                      group=1), linewidth = 1)} +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         color    = colors_homey$neutral,
                         ggplot2::aes(x = semitone,
                                      y = consonance_dissonance_2x,
                                      group=1), linewidth = 0.5)} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance-Dissonance Z-Score') +
    theme_homey()
}
plot_semitone_mami <- function(chords, title='', include_line=T, sigma=0.2,
                               include_linear_regression=F,goal=NULL,abs=F,
                               black_vlines=c(),gray_vlines=c()) {
  frequency_semitone =chords$semitone %>% min
  wavelength_semitone =chords$semitone %>% max

  chords$smoothed.major_minor = smoothed(
    chords$semitone,
    if (abs) abs(z_scores(chords$major_minor)) else z_scores(chords$major_minor),
    sigma)

  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$major_minor)) +
    ggplot2::geom_vline(xintercept = black_vlines, color=colors_homey$highlight) +
    ggplot2::geom_vline(xintercept = gray_vlines,color=colors_homey$highlight,linetype = 'dotted') +
    # ggplot2::geom_hline(yintercept = 0, color = colors_homey$neutral) +
    ggplot2::geom_point(shape=21, stroke=NA, size=1,
                        ggplot2::aes(fill=color_factor_homey(chords,'major_minor'))) +
    { if (include_linear_regression) ggplot2::stat_smooth(method=lm)} +
    { if (include_line)
      ggplot2::geom_line(data=chords,
                         ggplot2::aes(x = semitone,
                                      y = 4*smoothed.major_minor,
                                      color=color_factor_homey(chords,'major_minor'),
                                      group=1), linewidth = 1)} +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         color    = colors_homey$neutral,
                         ggplot2::aes(x = semitone,
                                      y = consonance_dissonance_2x *
                                        (max(chords$smoothed.major_minor) -
                                           min(chords$smoothed.major_minor)),
                                      group=1), linewidth = 0.5)} +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Major-Minor') +
    theme_homey()
}
plot_semitone_colo.cohi <- function(chords, title='', include_line=T, sigma=0.2,
                                    include_linear_regression = F, goal=NULL,
                                    black_vlines=c(),gray_vlines=c()) {
  frequency_semitone  = chords$semitone %>% min
  wavelength_semitone = chords$semitone %>% max
  chords$smoothed.consonance_frequency = smoothed(chords$semitone,
                                            chords$consonance_frequency,
                                            sigma)
  chords$smoothed.consonance_wavelength = smoothed(chords$semitone,
                                             chords$consonance_wavelength,
                                             sigma)
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_line(ggplot2::aes(y = smoothed.consonance_frequency), linewidth = 1,
                       color=colors_homey$major) +
    ggplot2::geom_line(ggplot2::aes(y = smoothed.consonance_wavelength), linewidth = 1,
                       color=colors_homey$minor) +
    {if (!is.null(goal))
      ggplot2::geom_line(data=goal,
                         linetype = "dashed",
                         color    = colors_homey$foreground,
                         ggplot2::aes(x = semitone,
                                      y = consonance_dissonance_2x,
                                      group=1), linewidth = 0.5)} +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(breaks = 0:15,
                                minor_breaks = c()) +
    ggplot2::ylab('Consonance Frequency (gold) and Wavelength (blue)') +
    theme_homey()
}
plot_semitone_co <- function(chords, title='') {
  frequency_semitone =chords$semitone %>% min
  wavelength_semitone =chords$semitone %>% max
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$consonance)) +
    ggplot2::geom_point(color=colors_homey$neutral) +
    ggplot2::scale_x_continuous(breaks = seq(frequency_semitone,wavelength_semitone),
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    theme_homey()
}
plot_semitone_tolerance <- function(chords, title='') {
  frequency_semitone =chords$semitone %>% min
  wavelength_semitone =chords$semitone %>% max
  ggplot2::ggplot(chords, ggplot2::aes(x = .data$semitone,
                                       y = .data$tolerance)) +
    ggplot2::geom_point(color=colors_homey$neutral, size=0.5) +
    ggplot2::scale_x_continuous(breaks = seq(frequency_semitone,wavelength_semitone),
                                minor_breaks = c()) +
    ggplot2::ggtitle(title) +
    theme_homey()
}
plot_semitone_rotation_angle <- function(chords, title='') {
  frequency_semitone =chords$semitone %>% min
  wavelength_semitone =chords$semitone %>% max
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
  frequency_semitone  = chords$semitone %>% min
  wavelength_semitone = chords$semitone %>% max
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
                                    title) {
  per_plot_labels = tidyr::expand_grid(
    tolerance_frequency  = theory$tolerance_frequency  %>% unique,
    tolerance_wavelength = theory$tolerance_wavelength %>% unique
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(tolerance_frequency,tolerance_wavelength) {
      tols = paste(
        'h:', tolerance_wavelength,
        'l:', tolerance_frequency
      )
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    # ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
    #                     ggplot2::aes(x = semitone, y = z_score,
    #                                  fill=color_factor_homey(theory,'major_minor'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::geom_line(
      data=experiment,
      linetype = "dashed",
      ggplot2::aes(x = semitone, y = smooth)) +
    ggplot2::geom_line(
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1,
                   color=color_factor_homey(theory,'major_minor'))) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                                          vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_grid(tolerance_frequency ~ tolerance_wavelength, scales = 'free_y') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
plot_semitone_codi_wrap <- function(theory, experiment,
                                    black_vlines=c(), gray_vlines=c(),
                                    title,ncols=12) {
  per_plot_labels = tidyr::expand_grid(
    tolerance  = theory$tolerance  %>% unique,
  )
  per_plot_labels$label = per_plot_labels %>%
    purrr::pmap_vec(\(tolerance) {
      tols = paste0(
        '  ', round(tolerance*1200/12^3,2), ' cents (',
        tolerance, ' tricia)'
      )
    })
  theory %>% ggplot2::ggplot(ggplot2::aes(x=semitone, y=smooth)) +
    ggplot2::geom_vline(xintercept = black_vlines, color='black') +
    ggplot2::geom_vline(xintercept = gray_vlines,color='gray44',linetype = 'dotted') +
    ggplot2::geom_point(data=theory, shape=21, stroke=NA, size=1,
                        ggplot2::aes(x = semitone, y = z_score,
                                     fill=color_factor_homey(theory,'major_minor'))) +
    ggplot2::scale_fill_manual(values=color_values_homey(), guide="none") +
    ggplot2::geom_line(
      data=experiment,
      linetype = "dashed",
      ggplot2::aes(x = semitone, y = smooth)) +
    ggplot2::geom_line(
      data=theory,
      ggplot2::aes(x = semitone, y = smooth,
                   group=1,
                   color=color_factor_homey(theory,'major_minor'))) +
    ggplot2::scale_color_manual(values=color_values_homey(), guide='none') +
    ggplot2::geom_text(data=per_plot_labels, color=colors_homey$neutral,
                       ggplot2::aes(x=-Inf,y=-Inf,label=label,
                                    vjust="inward",hjust="inward")) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab(NULL) +
    ggplot2::facet_wrap(~tolerance,ncol=ncols,dir='v') +
    ggplot2::scale_x_continuous(breaks = c(),
                                minor_breaks = 0:15) +
    theme_homey()
}
