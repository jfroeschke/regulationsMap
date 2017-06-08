# global.R
## Developed to display Gulf of Mexico spatial management regulations
## Data source: http://sero.nmfs.noaa.gov/maps_gis_data/fisheries/gom/GOM_index.html


library(shiny)
library(shinydashboard)
library(shinyBS)
library(leaflet)
library(RColorBrewer)
library(mapview)
library(DT)


### MapBox Attribution##
map_attr <- "<a href='https://www.mapbox.com/map-feedback/'>Mapbox</a>"

species <- read.csv("species.csv")