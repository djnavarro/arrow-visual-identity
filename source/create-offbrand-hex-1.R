
# generate Apache Arrow logos programmatically

library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(showtext)
library(magick)
library(hexify) # remotes::install_github("djnavarro/hexify")


create_offbrand_hex_1 <- function(path) {
  
  # define worker functions locally -----------------------------------------
  
  generate_chevron <- function() {
    tibble(
      x = c(0, .5, 0, 0, .3, 0, 0),
      y = c(1, .5, 0, .2, .5, .8, 1)
    )
  }
  
  generate_offbrand_logomark <- function() {
    generate_chevron() %>% 
      expand_grid(id = 0:2, .) %>% 
      mutate(
        x = x + id * .35,
        colour = case_when(
          id == 0 ~ "black",
          id == 1 ~ "#88398A",
          id == 2 ~ "black"
        )
      )
  }
  
  generate_offbrand_logotype <- function() {
    # TODO: ggplot2 specifies text dimensions in physical units
    # not data units, which means that text rescales as the 
    # image rescales. The current settings work for the 1800px
    # images, but more generally it would might be nice to 
    # find out how to control text height exactly in ggplot2
    tibble(
      x = c(-1.605, 0, -.975),
      y = c(.8, .495, .495),
      text = c("APACHE", "ARROW", "R"),
      font = c("Roboto", "Barlow", "Barlow"),
      weight = c("plain", "bold", "bold"),
      size = c(21, 60.5, 60.5), # <- the intent is really a 3:1 ratio in font size
      hjust = c("left", "right", "left"),
      vjust = c("center", "center", "center"),
      colour = c("black", "black", "#88398A")
    )
  } 
  
  export_hex <- function(plot, path, border, background = NULL, border_opacity = 100) {
    
    # intermediate files
    imgpath1 <- tempfile(fileext = ".png")  
    imgpath2 <- tempfile(fileext = ".png")
    
    # export square image to standard 1800x1800 size
    ggsave(imgpath1, plot, width = 6, height = 6, dpi = 300, bg = background)
    
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
  
  specify_offbrand_hex <- function() {
    
    # load fonts
    font_add_google("Roboto")
    font_add_google("Barlow")
    showtext_auto()
    
    # create the two components
    arrow_text <- generate_offbrand_logotype()
    triple_chevron <- generate_offbrand_logomark()
    
    # displacement text/arrow blocks 
    # relative to their horizontal location
    # (this is the same displacement used in 
    # the official hexes)
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
    
    # specify plot limits (same as in the official hexes)
    x_limit <- c(-1.375, 2.375)
    y_limit <- c(-1.375, 2.375)
    
    # construct plot
    pic <- ggplot() +
      geom_polygon(
        data = triple_chevron,
        mapping = aes(
          x, y, 
          group = id,
          fill = colour,
          colour = colour        
        )
      ) +
      geom_text(
        data = arrow_text,
        mapping = aes(
          x, y,
          label = text,
          family = font,
          size = size,
          fontface = weight,
          hjust = hjust,
          vjust = vjust,
          colour = colour
        ),
      ) +
      coord_equal() +
      scale_size_identity() +
      scale_color_identity() +
      scale_fill_identity() +
      theme_void() +
      theme(panel.background = element_rect(
        fill = "white", colour = "white"
      )) + 
      scale_x_continuous(limits = x_limit, expand = c(0, 0)) +
      scale_y_continuous(limits = y_limit, expand = c(0, 0)) +
      NULL
    
    # invisibly return the ggplot object: note that this object won't
    # render the way you want it to unless you export it in the exact 
    # width, height and dpi settings per export_hex()
    return(invisible(pic))
  }
  
  # now do the work ---------------------------------------------------------

  pic <- specify_offbrand_hex()
  export_hex(
    plot = pic,
    path = path, 
    border = "#88398A", 
    background = NULL,
    border_opacity = 100
  )
}

# # edit file destination and uncomment to call:
# create_offbrand_hex_1("~/Desktop/offbrand_hex_1.png")

