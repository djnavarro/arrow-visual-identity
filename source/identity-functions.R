# generate Apache Arrow logos programmatically

library(ggplot2)
library(svglite)
library(dplyr)
library(tidyr)
library(tibble)
library(showtext)
library(magick)
library(hexify)

logo_version <- function(colour, background, enforce) {
  
  if(is.null(background)) {
    if(colour == "black") {
      return("black-text_no-bg")
    }
    if(colour == "white") {
      return("white-text_no-bg")
    }
  }
  if(colour == "black" & background == "white") {
    return("black-text_white-bg")
  }
  if(colour == "white" & background == "black") {
    return("white-text_black-bg")
  }
  
  if(enforce == TRUE) {
    stop("to use informal logos, set 'formal = FALSE'", call. = FALSE)
  }
}

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
  gc()
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

logo_horizontal <- function(colour = "black", background = "white", 
                          format = "png", formal = TRUE) {
  
  ver <- logo_version(colour, background, enforce = formal)
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # create the two components
  arrow_text <- generate_logotype()
  triple_chevron <- generate_logomark()
  
  # specify plot limits
  x_limit <- c(-1.8, 1.95)
  y_limit <- c(-1.375, 2.375)
  
  # construct plot: the logomark and logotype positions
  # are already in correct relation to each other for 
  # horizontal format, so no adjustments are required
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)
  
  # export image
  if(!is.null(format)) {
    filename <- paste0("arrow-logo_horizontal_", ver, ".", format)
    filepath <- here::here("logos", filename)
    export_logo(pic, filepath)
  }
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings noted above
  return(invisible(pic))
}


logo_vertical <- function(colour = "black", background = "white", 
                          format = "png", formal = TRUE) {
  
  ver <- logo_version(colour, background, enforce = formal)
  
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
      x = x + 0,
      y = y - .4
    )

  # specify plot limits
  x_limit <- c(-1.375, 2.375)
  y_limit <- c(-1.375, 2.375)
  
  # construct plot
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)
  
  # export image
  if(!is.null(format)) {
    filename <- paste0("arrow-logo_vertical_", ver, ".", format)
    filepath <- here::here("logos", filename)
    export_logo(pic, filepath)
  }
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings noted above
  return(invisible(pic))
}


hex_sticker <- function(colour = "black", background = "white", 
                        border = colour, format = "png", formal = TRUE) {
  
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
      x = x + 0,
      y = y - .4
    )
  
  # specify plot limits
  x_limit <- c(-1.375, 2.375)
  y_limit <- c(-1.375, 2.375)
  
  # construct plot
  pic <- specify_plot(arrow_text, triple_chevron, colour, 
                      background, x_limit, y_limit)

  # build hex
  if(!is.null(format)) {
    export_hex(pic, "~/Desktop/hex.png", border, background)
  }
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings noted above
  return(invisible(pic))
}

