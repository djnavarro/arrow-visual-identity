# lazy way to generate links for the website

msg1 <- character()
msg2 <- character()
add <- 3
val <- 1

for(orientation in c("horizontal", "vertical", "hex", "chevrons", "text")) {
  for(text in c("white", "black")) {
    for(background in c("white", "black", "transparent")) {
      
      fname <- paste0("arrow-logo_", orientation, "_", text, "-txt_", background, "-bg.png")
      if(file.exists(here::here("img", fname))) {
        
        msg1[[val]] <- paste0("[", add+val, "]: {{ site.baseurl }}/img/", fname)
        msg2[[val]] <- paste0("- [Arrow logo with ", orientation, " orientation, ", text, " text, and ", background, " background][", add+val, "]")
        val <- val + 1
        
      }
      
    }
  }
}

cat(msg1, sep = "\n")
cat("\n\n")
cat(msg2, sep = "\n")
