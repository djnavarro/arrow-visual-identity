
source(here::here("source", "logo-functions.R"))
source(here::here("source", "create-annotated.R"))


# annotated images --------------------------------------------------------

output_dir <- here::here("formal")
create_annotated_hex(output_dir)
create_annotated_logo_horizontal(output_dir)
create_annotated_logo_vertical(output_dir)

