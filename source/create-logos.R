
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

create_logo_horizontal <- function(dir, colour, background, format = "png") {
  pic <- specify_logo_horizontal(colour, background)
  fname <- logo_filename("horizontal", colour, background, format)
  export_logo(
    plot = pic,
    path = file.path(dir, fname), 
    background = background
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


