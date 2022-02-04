# generate Apache Arrow logos programmatically

library(ggplot2)
library(svglite)
library(dplyr)
library(tidyr)
library(tibble)
library(showtext)


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

export_logo <- function(plot, path) {
  ggsave(path, plot, width = 6, height = 6, dpi = 300)
}

generate_logo <- function(colour = "black", background = "white", 
                          format = "png", formal = TRUE) {
  
  ver <- logo_version(colour, background, enforce = formal)
  
  # load fonts
  font_add_google("Roboto")
  font_add_google("Barlow")
  showtext_auto()
  
  # polygon specifying a single chevron
  single_chevron <- tibble(
    x = c(0, .5, 0, 0, .3, 0, 0),
    y = c(1, .5, 0, .2, .5, .8, 1)
  )
  
  # three polygons specifying the triple-chevron logomark
  triple_chevron <- single_chevron %>% 
    expand_grid(id = 0:2, .) %>% 
    mutate(x = x + id * .35)

  # TODO: ggplot2 specifies text dimensions in physical units
  # not data units, which means that text rescales as the 
  # image rescales. The current settings work for the 1800px
  # images, but more generally it would might be nice to 
  # find out how to control text height exactly in ggplot2
  
  # specify the logotype
  arrow_text <- tibble(
    x = c(-1.6, 0),
    y = c(.8, .5),
    text = c("APACHE", "ARROW"),
    font = c("Roboto", "Barlow"),
    weight = c("plain", "bold"),
    size = c(20, 60),
    hjust = c("left", "right")
  )
  
  # construct plot: the logomark and logotype positions
  # are already in correct relation to each other for 
  # horizontal format, so no adjustments are required
  pic <- ggplot() +
    
    # logomark
    geom_polygon(
      data = triple_chevron,
      mapping = aes(x, y, group = id),
      fill = colour,
      colour = colour,
    ) +
    
    # logotype
    geom_text(
      data = arrow_text,
      mapping = aes(
        x, y,
        label = text,
        family = font,
        size = size,
        fontface = weight,
        hjust = hjust
      ),
      vjust = "center",
      colour = colour
    ) +
    
    # rest of theme
    coord_equal() +
    scale_size_identity() +
    theme_void() +
    theme(panel.background = element_rect(
      fill = background, colour = background
    )) + 
    scale_x_continuous(limits = c(-1.8, 1.95), expand = c(0, 0)) +
    scale_y_continuous(limits = c(-1.375, 2.375), expand = c(0, 0)) +
    NULL

  # export image
  if(!is.null(format)) {
    filename <- paste0("arrow-logo_", ver, ".", format)
    filepath <- here::here("logos", filename)
    export_logo(pic, filepath)
  }
  
  # invisibly return the ggplot object: note that this object won't
  # render the way you want it to unless you export it in the exact 
  # width, height and dpi settings noted above
  return(invisible(pic))
}

