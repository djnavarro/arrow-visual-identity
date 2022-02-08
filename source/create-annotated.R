
# required functions
source(here::here("source", "logo-functions.R"))


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

create_annotated_logo_horizontal <- function(dir) {

  pic <- specify_logo_horizontal(
    colour = "#00000088", 
    background = "white"
  )
  
  x_lim <- c(-2.075, 1.675)
  y_lim <- c(-.25, 1.25)
  ar <- (y_lim[2] - y_lim[1]) / (x_lim[2] - x_lim[1])
  
  x_breaks <- c(-1.6, -.97, 0, .3, .35, .5, .65, .7, .85, 1, 1.2)
  y_breaks <- c(0, .2, .33, .5, .66, .74, .8, .86, 1)
  
  pic %>% 
    annotate_spacing(x_breaks, y_breaks, x_lim, y_lim) %>% 
    export_logo(file.path(dir, "horizontal-logo-spacing.png"), height = ar * 6)
  
}

create_annotated_logo_vertical <- function(dir) {
  
  pic <- specify_logo_vertical(
    colour = "#00000088", 
    background = "white"
  )
  
  x_lim <- c(-1.45, 2.3)
  #y_lim <- c(-1.45, 2.3)
  y_lim <- c(-.8, 1.6)
  ar <- (y_lim[2] - y_lim[1]) / (x_lim[2] - x_lim[1])
  
  x_breaks <- c(-.4, -.11, .23, 1.09, 1.2)
  y_breaks <- c(-.4, .1, .6, .73, 1.06, 1.14, 1.26)
  
  pic %>% 
    annotate_spacing(x_breaks, y_breaks, x_lim, y_lim) %>% 
    export_logo(file.path(dir, "vertical-logo-spacing.png"), height = ar * 6)
  
}

create_annotated_hex <- function(dir) {
  
  pic <- specify_hex(
    colour = "#00000088", 
    background = "white"
  )
  
  x_breaks <- c(-.3, -.01, .33, .5, 1.1875, 1.3)
  y_breaks <- c(-.4, .1, .6, .73, 1.06, 1.14, 1.26)
  
  x_lim <- c(-1.375, 2.375)
  y_lim <- c(-1.375, 2.375)
  
  pic <- suppressMessages(
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
          label = as.character(c(.1, .6, .73, 1.06, 1.14) * 100), 
          x = -.43, 
          y = c(.1, .6, .73, 1.06, 1.14),
          size = 6, 
          fontface = "bold"
        ) +
        annotate(
          geom = "text", 
          label = as.character(c(-.4, .6, 1.14, 1.26) * 100), 
          x = .95, 
          y = c(-.4, .6, 1.14, 1.26),
          size = 6, 
          fontface = "bold"
        ) +
        annotate(
          geom = "text", 
          label = as.character(c(-.01, .33, .5) * 100), 
          x = c(-.01, .33, .5), 
          y = 1.38,
          size = 6, 
          angle = 90,
          fontface = "bold"
        ) +
        annotate(
          geom = "text", 
          label = as.character(round(c(-.3, 1.1875, 1.3) * 100)), 
          x = c(-.3, 1.1875, 1.3), 
          y = .5,
          size = 6, 
          angle = 90,
          fontface = "bold"
        ) +
        NULL
  )
  
  export_hex(
    plot = pic, 
    path = file.path(dir, "hex-sticker-spacing.png"),
    border = "black", 
    background = "white", 
    border_opacity = 66
  )
}

