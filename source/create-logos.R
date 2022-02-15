
# required functions
source(here::here("source", "logo-functions.R"))

logo_filename <- function(type, colour, background, format) {
  if(is.null(background)) background <- "transparent"
  paste0(
    "arrow-logo_",
    type, "_",
    colour, "-txt_",
    background, "-bg.",
    format
  )
}

create_logo_horizontal <- function(dir, colour, background, format = "png", crop = TRUE, ...) {
  pic <- specify_logo_horizontal(colour, background, crop = crop)
  fname <- logo_filename("horizontal", colour, background, format)
  height <- ifelse(crop, 3.12, 6)
  width <- 6
  
  # this fixes it... svgs don't have an analog of dpi, svglite interprets the
  # relative height of text vs data differently. sigh. multiplying by 3 is 
  # essentially the same as treating as if the raster version of the image were
  # at 100dpi rather than the 300dpi value at which it was exported... next time,
  # best to calibrate for 100dpi from the beginning so that svg and png are aligned
  if(format == "svg") {
    height <- height * 3
    width <- width * 3
  }
  
  export_logo(
    plot = pic,
    path = file.path(dir, fname), 
    background = background, 
    height = height,
    width = width,
    device = ifelse(format == "svg", svglite, NULL),
    ...
  )
}

create_logo_vertical <- function(dir, colour, background, format = "png") {
  pic <- specify_logo_vertical(colour, background)
  fname <- logo_filename("vertical", colour, background, format)
  export_logo(
    plot = pic,
    path = file.path(dir, fname), 
    background = background
  )
}

create_logo_chevrons <- function(dir, colour, background, format = "png") {
  pic <- specify_logo_chevrons(colour, background)
  fname <- logo_filename("chevrons", colour, background, format)
  export_logo(
    plot = pic,
    path = file.path(dir, fname), 
    background = background,
    height = 5.25 # computed from aspect ratio of ggplot limits
  )
}

create_logo_text <- function(dir, colour, background, format = "png") {
  pic <- specify_logo_text(colour, background)
  fname <- logo_filename("text", colour, background, format)
  export_logo(
    plot = pic,
    path = file.path(dir, fname), 
    background = background,
    height = 2.54 # computed from aspect ratio of ggplot limits
  )
}


create_hex <- function(dir, colour, background, border, format = "png") {
  pic <- specify_hex(colour, background)
  fname <- logo_filename("hex", colour, background, format)
  export_hex(
    plot = pic,
    path = file.path(dir, fname), 
    border = border, 
    background = background,
    border_opacity = 100
  )
}


