
source(here::here("source", "logo-functions.R"))
source(here::here("source", "create-annotated.R"))
source(here::here("source", "create-logos.R"))
source(here::here("source", "create-offbrand-hex-1.R"))
source(here::here("source", "create-offbrand-hex-2.R"))

# annotated images --------------------------------------------------------

cat("creating annotated logos...\n")
output_dir <- here::here("annotated")
create_annotated_hex(output_dir)
create_annotated_logo_horizontal(output_dir)
create_annotated_logo_vertical(output_dir)

# cropped horizontal logos ------------------------------------------------

cat("creating horizontal logos...\n")
output_dir <- here::here("logos-horizontal")
create_logo_horizontal(dir = output_dir, colour = "black", background = "white", crop = TRUE)
create_logo_horizontal(dir = output_dir, colour = "white", background = "black", crop = TRUE)
create_logo_horizontal(dir = output_dir, colour = "black", background = NULL, crop = TRUE)
create_logo_horizontal(dir = output_dir, colour = "white", background = NULL, crop = TRUE)

# vertical logos ----------------------------------------------------------

cat("creating vertical logos...\n")
output_dir <- here::here("logos-vertical")
create_logo_vertical(dir = output_dir, colour = "black", background = "white")
create_logo_vertical(dir = output_dir, colour = "white", background = "black")
create_logo_vertical(dir = output_dir, colour = "black", background = NULL)
create_logo_vertical(dir = output_dir, colour = "white", background = NULL)

# text only logos ---------------------------------------------------------

cat("creating text only logos...\n")
output_dir <- here::here("logos-text")
create_logo_text(dir = output_dir, colour = "black", background = "white")
create_logo_text(dir = output_dir, colour = "white", background = "black")
create_logo_text(dir = output_dir, colour = "black", background = NULL)
create_logo_text(dir = output_dir, colour = "white", background = NULL)

# chevron only logos ------------------------------------------------------

cat("creating chevron only logos...\n")
output_dir <- here::here("logos-chevrons")
create_logo_chevrons(dir = output_dir, colour = "black", background = "white")
create_logo_chevrons(dir = output_dir, colour = "white", background = "black")
create_logo_chevrons(dir = output_dir, colour = "black", background = NULL)
create_logo_chevrons(dir = output_dir, colour = "white", background = NULL)

# hex stickers ------------------------------------------------------------

cat("creating hex stickers...\n")
output_dir <- here::here("hexes")
create_hex(dir = output_dir, colour = "black", background = "white", border = "black")
create_hex(dir = output_dir, colour = "white", background = "black", border = "#222222")

cat("creating offbrand hex stickers...\n")
create_offbrand_hex_1(here::here("hexes", "offbrand_hex_1.png"))
create_offbrand_hex_2(here::here("hexes", "offbrand_hex_2.png"))


