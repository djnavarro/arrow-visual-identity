
# generates images used in the readmes
source(here::here("source", "identity-functions.R"))

pic <- generate_logo(
  colour = "#00000088", 
  background = "white", 
  formal = FALSE,
  format = NULL
)

pic <- suppressMessages(
  pic + 
    theme_void(base_size = 24) + 
    theme(
      panel.background = element_rect(fill = "white", colour = "white"),
      panel.grid.major = element_line(colour = "grey80", size = 1),
      panel.grid.minor = element_blank()
    ) + 
    scale_x_continuous(
      name = NULL,
      limits = c(-2.075, 1.675), 
      expand = c(0, 0), 
      breaks = c(-1.6, 0, .3, .35, .5, .65, .7, .85, 1, 1.2),
      guide = guide_axis(angle = 90)
    ) +
    scale_y_continuous(
      name = NULL, 
      breaks = c(0, .2, .5, .8, 1), 
      limits = c(-.25, 1.25),
      expand = c(0, 0)
    ) + 
    annotate(
      geom = "text", 
      label = as.character(c(-1.6, 0, .3, .35, .5, .65, .7, .85, 1, 1.2) * 100), 
      x = c(-1.6, 0, .3, .35, .5, .65, .7, .85, 1, 1.2) - .025, 
      y = -.125, 
      size = 6, 
      angle = 90
    )
)

