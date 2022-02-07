
# generates images used in the readmes
source(here::here("source", "identity-functions.R"))


# helper ------------------------------------------------------------------

annotate_spacing <- function(pic, x_breaks, y_breaks, x_lim, y_lim) {
  fs <- 6
  ff <- "bold"
  major_off <- .125
  minor_off <- 0
  suppressMessages(
    pic +
      theme_void(base_size = 24) + 
      theme(
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.grid.major = element_line(colour = "grey60", size = .1),
        panel.grid.minor = element_blank()
      ) + 
      scale_x_continuous(
        name = NULL,
        limits = x_lim, 
        expand = c(0, 0), 
        breaks = x_breaks,
        guide = guide_axis(angle = 90)
      ) +
      scale_y_continuous(
        name = NULL, 
        breaks = y_breaks, 
        limits = y_lim,
        expand = c(0, 0)
      ) + 
      annotate(
        geom = "text", 
        label = as.character(x_breaks * 100), 
        x = x_breaks - minor_off, 
        y = min(y_breaks) - major_off,
        size = fs, 
        angle = 90,
        fontface = ff
      ) +
      annotate(
        geom = "text", 
        label = as.character(x_breaks * 100), 
        x = x_breaks - minor_off, 
        y = max(y_breaks) + major_off,
        size = fs, 
        angle = 90,
        fontface = ff
      ) +
      annotate(
        geom = "text", 
        label = as.character(y_breaks * 100), 
        x = min(x_breaks) - major_off, 
        y = y_breaks + minor_off, 
        size = fs,
        fontface = ff
      ) +
      annotate(
        geom = "text", 
        label = as.character(y_breaks * 100), 
        x = max(x_breaks) + major_off, 
        y = y_breaks + minor_off, 
        size = fs,
        fontface = ff
      )
  )
}

# logo spacing ------------------------------------------------------------

annotated_logo_horizontal <- function() {

  pic <- logo_horizontal(
    colour = "#00000088", 
    background = "white", 
    formal = FALSE,
    format = NULL
  )
  
  x_lim <- c(-2.075, 1.675)
  y_lim <- c(-.25, 1.25)
  ar <- (y_lim[2] - y_lim[1]) / (x_lim[2] - x_lim[1])
  
  x_breaks <- c(-1.6, -.97, 0, .3, .35, .5, .65, .7, .85, 1, 1.2)
  y_breaks <- c(0, .2, .33, .5, .66, .74, .8, .86, 1)
  
  pic %>% 
    annotate_spacing(x_breaks, y_breaks, x_lim, y_lim) %>% 
    export_logo(here::here("formal", "horizontal-logo-spacing.png"), height = ar * 6)
  
}

annotated_logo_vertical <- function() {
  
  pic <- logo_vertical(
    colour = "#00000088", 
    background = "white", 
    formal = FALSE,
    format = NULL
  )
  
  x_lim <- c(-1.45, 2.3)
  #y_lim <- c(-1.45, 2.3)
  y_lim <- c(-.8, 1.6)
  ar <- (y_lim[2] - y_lim[1]) / (x_lim[2] - x_lim[1])
  
  x_breaks <- c(-.4, 0, .23, 1.2)
  y_breaks <- c(-.4, .1, .6, .73, 1.06, 1.14, 1.26)
  
  pic %>% 
    annotate_spacing(x_breaks, y_breaks, x_lim, y_lim) %>% 
    export_logo(here::here("formal", "vertical-logo-spacing.png"), height = ar * 6)
  
}

annotated_logo_horizontal()
annotated_logo_vertical()

