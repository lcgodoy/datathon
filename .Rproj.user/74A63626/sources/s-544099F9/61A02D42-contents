library(magrittr)
library(leaflet)

#---- Endereco - Datathon ----

address <- 'Av. Bento Gonçalves, 9500 - Agronomia, Porto Alegre - RS, 91501-970' %>% 
  tolower() %>% 
  gsub(pattern = ' ', replacement = '+', x = .)

google_key <- "AIzaSyDJYs44-vEUhb_8BpUGcIiC0A8hpKixNhY"

language <- 'pt-br'
region <- 'BR'

maps_url <- "https://maps.googleapis.com/maps/api/geocode/json?"

urlArgs <- c("address" = address,
             "language" = language,
             "region" = region,
             "key" = google_key)

# Estrutura: &variavel=valor. Exemplo: &region=BR
web_url <- utils::URLencode(paste0(maps_url, paste0("&", paste0(names(urlArgs)), 
                                                    "=", paste0(urlArgs), collapse = "")))

place_request <- jsonlite::fromJSON(web_url)

lat <- place_request$results$geometry$location$lat
lng <- place_request$results$geometry$location$lng

save(lat, lng, file = 'data/coords.RData')

#--- Plot ----

icons <- awesomeIcons(
  icon = "fa-book",
  library = "fa",
  markerColor = "#161738",
  spin = F
)

location <- paste(sep = "<br/>",
                  "<b><a href='https://www.ufrgs.br/datathon/index.html'>1º Datathon - UFRGS</a></b>",
                  "Av. Bento Gonçalves, 9500 - Agronomia",
                  "Porto Alegre, RS - Brasil"
)

leaflet() %>%
  addTiles() %>% 
  addAwesomeMarkers(lng = lng, 
                    lat = lat, 
                    icon = icons, popup = location, label = "We're here!")
