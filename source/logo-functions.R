# generate Apache Arrow logos programmatically

library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(showtext)
library(magick)
library(hexify)


export_logo <- function(plot, path, height = 6, background = NULL) {
  ggsave(path, plot, width = 6, height = height, dpi = 300, bg = background)
}

export_hex <- function(plot, path, border, background = NULL, border_opacity = 100) {
  
  # intermediate files
  imgpath1 <- tempfile(fileext = ".png")  
  imgpath2 <- tempfile(fileext = ".png")
  
  # export square image to standard 1800x1800 size
  export_logo(plot, path = imgpath1, background = background)
  
  # crop the image slightly
  img <- image_read(imgpath1)
  img <- image_crop(img, "1300x1300", "Center")
  image_write(img, imgpath2)
  
  # generate the hex sticker
  hexify(
    from = imgpath2,
    to = path,
    border_colour = border,
    border_opacity = border_opacity
  )
  
  # ensure magick pointers are collected
  invisible(gc())
}

generate_chevron <- function() {
  tibble(
    x = c(0, .5, 0, 0, .3, 0, 0),
    y = c(1, .5, 0, .2, .5, .8, 1)
  )
}

generate_logomark <- function() {
  generate_chevron() %>% 
    expand_grid(id = 0:2, .) %>% 
    mutate(x = x + id * .35)
}

generate_logotype <- function() {
  # TODO: ggplot2 specifies text dimensions in physical units
  # not data units, which means that text rescales as the 
  # image rescales. The current settings work for the 1800px
  # images, but more generally it would might be nice to 
  # find out how to control text height exactly in ggplot2
  tibble(
    x = c(-1.605, 0),
    y = c(.8, .495),
    text = c("APACHE", "ARROW"),
    font = c("Roboto", "Barlow"),
    weight = c("plain", "bold"),
    size = c(21, 60.5), # <- the intent is really a 3:1 ratio in font size
    hjust = c("left", "right"),
    vjust = c("center", "center")
  )
} 

specify_plot <- function(logotype, logomark, colour, background, x_lim, y_lim) {
  ggplot() +
    geom_polygon(
      data = logomark,
      mapping = aes(x, y, group = id),
      fill = colour,
      colour = colour,
    ) +
    geom_text(
      data = logotype,
      mapping = aes(
        x, y,
        label = text,
        family = font,
        size = size,
        fontface = weight,
        hjust = hjust,
        vjust = vjust
      ),
      colour = colour
    ) +
    coord_equal() +
    scale_size_identity() +
    theme_void() +
    theme(panel.background = element_rect(
      fill = background, colour = background
    )) + 
    scale_x_continuous(limits = x_lim, expand = c(0, 0)) +
    scale_y_continuous(limits = y_lim, expand = c(0, 0)) +
    NULL
}

specify_logo_horizontal <- function(colour = "black", background = "white", crop = FALSE) {
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # create the two components
  arrow_text <- generate_logotype()
  triple_chevron <- generate_logomark()
  
  # specify plot limits
  x_limit <- c(-2.075, 1.675) # logo x range: -1.6, 1.2
  y_limit <- c(-1.375, 2.375) # logo y range: 0, 1
  if(crop) {
    y_limit <- c(-.475, 1.475)
  }
  
  # construct plot: the logomark and logotype positions
  # are already in correct relation to each other for 
  # horizontal format, so no adjustments are required
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings per export_logo()
  return(invisible(pic))
}

specify_logo_vertical <- function(colour = "black", background = "white") {
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # create the two components
  arrow_text <- generate_logotype()
  triple_chevron <- generate_logomark()
  
  # displacement text/arrow blocks 
  # relative to their horizontal location
  arrow_text <- arrow_text %>% 
    mutate(
      x = x + 1.2,
      y = y + .4
    )
  triple_chevron <- triple_chevron %>% 
    mutate(
      x = x - .115,
      y = y - .4
    )

  # specify plot limits
  x_limit <- c(-1.375, 2.375)
  y_limit <- c(-1.375, 2.375)
  
  # construct plot
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings noted above
  return(invisible(pic))
}

specify_logo_chevrons <- function(colour = "black", background = "white") {
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # create the chevrons
  triple_chevron <- generate_logomark() 
  
  # specify plot limits
  x_limit <- c(-.2, 1.4) # chevrons x range: 0, 1.2
  y_limit <- c(-.2, 1.2) # chevrons y range: 0, 1
  
  pic <- ggplot() +
    geom_polygon(
      data = triple_chevron,
      mapping = aes(x, y, group = id),
      fill = colour,
      colour = colour,
    ) +
    coord_equal() +
    scale_size_identity() +
    theme_void() +
    theme(panel.background = element_rect(
      fill = background, colour = background
    )) + 
    scale_x_continuous(limits = x_limit, expand = c(0, 0)) +
    scale_y_continuous(limits = y_limit, expand = c(0, 0)) +
    NULL
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings per export_logo()
  return(invisible(pic))
}


specify_hex <- function(colour = "black", background = "white") {
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # create the two components
  arrow_text <- generate_logotype()
  triple_chevron <- generate_logomark()
  
  # displacement text/arrow blocks 
  # relative to their horizontal location
  arrow_text <- arrow_text %>% 
    mutate(
      x = x + 1.3,
      y = y + .4
    )
  triple_chevron <- triple_chevron %>% 
    mutate(
      x = x - .0125,
      y = y - .4
    )
  
  # specify plot limits
  x_limit <- c(-1.375, 2.375)
  y_limit <- c(-1.375, 2.375)
  
  # construct plot
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)

  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings per export_hex()
  return(invisible(pic))
}

