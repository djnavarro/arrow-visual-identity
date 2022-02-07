
source(here::here("source", "logo-functions.R"))
source(here::here("source", "create-annotated.R"))
source(here::here("source", "create-logos.R"))


# annotated images --------------------------------------------------------

cat("creating annotated logos...\n")
output_dir <- here::here("annotated")
create_annotated_hex(output_dir)
create_annotated_logo_horizontal(output_dir)
create_annotated_logo_vertical(output_dir)


# horizontal logos --------------------------------------------------------

cat("creating horizontal logos...\n")
output_dir <- here::here("logos-horizontal")
create_logo_horizontal(dir = output_dir, colour = "black", background = "white")
create_logo_horizontal(dir = output_dir, colour = "white", background = "black")
create_logo_horizontal(dir = output_dir, colour = "black", background = NULL)
create_logo_horizontal(dir = output_dir, colour = "white", background = NULL)


# vertical logos ----------------------------------------------------------

cat("creating vertical logos...\n")
output_dir <- here::here("logos-vertical")
create_logo_vertical(dir = output_dir, colour = "black", background = "white")
create_logo_vertical(dir = output_dir, colour = "white", background = "black")
create_logo_vertical(dir = output_dir, colour = "black", background = NULL)
create_logo_vertical(dir = output_dir, colour = "white", background = NULL)


# hex stickers ------------------------------------------------------------

cat("creating hex stickers...\n")
output_dir <- here::here("hexes")
create_hex(dir = output_dir, colour = "black", background = "white", border = "black")
create_hex(dir = output_dir, colour = "white", background = "black", border = "#222222")

