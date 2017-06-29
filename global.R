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
library(leaflet.esri)

enableBookmarking(store = "url")


### MapBox Attribution##
map_attr <- "<a href='https://www.mapbox.com/map-feedback/'>Mapbox</a>"

species <- read.csv("species.csv")

a <- read.csv('maplayers.csv', stringsAsFactors = FALSE)
#df <- data.frame(URL="https://api.mapbox.com/styles/v1/gulffish123/cj3ycoorm06302qmralrl4dk3/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZ3VsZmZpc2gxMjMiLCJhIjoiY2l5a2IweTVtMDAwdDJxcGYzYmR0b3lndyJ9.PjwB4UC9ESaDhoe3ed_YKg")
#a <- "https://api.mapbox.com/styles/v1/gulffish123/cj3ycoorm06302qmralrl4dk3/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZ3VsZmZpc2gxMjMiLCJhIjoiY2l5a2IweTVtMDAwdDJxcGYzYmR0b3lndyJ9.PjwB4UC9ESaDhoe3ed_YKg"
#df <- read.csv("df.csv")
#df <- read.csv("df1.csv")
df <- read.csv("df3.csv")
df$Start <- as.Date(df$Start, format="%m/%d/%Y")
df$End <- as.Date(df$End, format="%m/%d/%Y")
#x <- subset(df, End < Sys.Date())

