#############################################################
#### Targeting - packages
#############################################################
## Cornelius Erfort, erfortco@hu-berlin.de

# Install/load packages from CRAN
p_needed <- c(
  "httr",
  "jsonlite",
  "lubridate",
  "dplyr",
  "plyr",
  "stringr",
  "readr",
  "ggplot2",
  "ggrepel",
  "ggmap",
  "maps",
  "rgdal",
  "rgeos",
  "classInt",
  # "maptools",
  "eurostat",
  "scales",
  "broom",
  "openxlsx",
  "margins",
  "tidyr",
  "readxl",
  "rvest",
  "purrr",
  "stargazer",
  "coefplot",
  "data.table",
  "sjPlot",
  "sjmisc",
  "haven",
  "gridExtra",
  "pbapply",
  "quanteda",
  "ineq",
  "extrafont",
  "ggwordcloud",
  "knitr",
  "bibtex",
  "sjlabelled",
  "miceadds",
  "ggnewscale",
  "digest",
  "pbapply",
  "jpeg",
  "png",
  "english",
  "labelled",
  "ggpattern",
  "rnaturalearth",
  "rnaturalearthdata")

packages <- rownames(installed.packages())
p_to_install <- p_needed[!(p_needed %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}
lapply(p_needed, require, character.only = TRUE)

# Export citations
bibfile <- "software.bib"
if(!file.exists(bibfile)) write_bib(p_needed, file = bibfile)

# Set locale
Sys.setenv(LANG = "en")
Sys.setlocale("LC_ALL", "en_US.UTF-8")

# Load fonts
font_import(pattern = "lmroman*")
if(Sys.info()[1] == "Windows") loadfonts(device = "win") else loadfonts()

# Load fonts
# font_import(pattern = "lmroman*")
if(Sys.info()[1] == "Windows") loadfonts(device = "win") else loadfonts()

# par(family = "LM Roman 10")
# theme_update(text = element_text(family = "LM Roman 10"))
par(family = "Latin Modern Roman")
theme_update(text = element_text(family = "Latin Modern Roman")) # "LM Roman 10"))

# Clean up
rm("p_needed", "p_to_install", "packages")
