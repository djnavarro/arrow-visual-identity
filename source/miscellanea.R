
# generates images used in the readmes
source(here::here("source", "identity-functions.R"))


# helper ------------------------------------------------------------------

annotate_spacing <- function(pic, x_breaks, y_breaks) {
  suppressMessages(
    pic +
      theme_void(base_size = 24) + 
      theme(
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.grid.major = element_line(colour = "grey80", size = .5),
        panel.grid.minor = element_blank()
      ) + 
      scale_x_continuous(
        name = NULL,
        limits = c(-2.075, 1.675), 
        expand = c(0, 0), 
        breaks = x_breaks,
        guide = guide_axis(angle = 90)
      ) +
      scale_y_continuous(
        name = NULL, 
        breaks = y_breaks, 
        limits = c(-.25, 1.25),
        expand = c(0, 0)
      ) + 
      annotate(
        geom = "text", 
        label = as.character(x_breaks * 100), 
        x = x_breaks - .025, 
        y = -.125,
        size = 6, 
        angle = 90
      ) +
      annotate(
        geom = "text", 
        label = as.character(x_breaks * 100), 
        x = x_breaks - .025, 
        y = 1.125,
        size = 6, 
        angle = 90
      ) +
      annotate(
        geom = "text", 
        label = as.character(y_breaks * 100), 
        x = -1.725, 
        y = y_breaks + .025, 
        size = 6
      ) +
      annotate(
        geom = "text", 
        label = as.character(y_breaks * 100), 
        x = 1.325, 
        y = y_breaks + .025, 
        size = 6
      )
  )
}

# logo spacing ------------------------------------------------------------

pic <- generate_logo(
  colour = "#00000088", 
  background = "white", 
  formal = FALSE,
  format = NULL
)

x_breaks <- c(-1.6, 0, .3, .35, .5, .65, .7, .85, 1, 1.2)
y_breaks <- c(0, .2, .5, .8, 1)

pic %>% 
  annotate_spacing(x_breaks, y_breaks) %>% 
  export_logo(here::here("formal", "logo-spacing-1.png"))

x_breaks <- c(-1.6, 0, 1.2)
y_breaks <- c(0, .33, .66, .75, .85, 1)

pic %>% 
  annotate_spacing(x_breaks, y_breaks) %>% 
  export_logo(here::here("formal", "logo-spacing-2.png"))


