# global.R
## Developed to display Gulf of Mexico spatial management regulations
## Data source: http://sero.nmfs.noaa.gov/maps_gis_data/fisheries/gom/GOM_index.html
## mxd's for map services here: H:\GIS\PROJECTS\ManagementMaps

library(shiny)
library(shinydashboard)
library(shinyBS)
library(leaflet)
library(RColorBrewer)
library(mapview)
library(DT)
library(leaflet.esri)
library(dplyr)
library(raster)

EXTENT <- extent(c(-100.42, -69.59, 20.82, 32.57))

enableBookmarking(store = "url")
#load("df.RData")

# species <- read.csv("species.csv")
# 
#a <- read.csv('maplayers.csv', stringsAsFactors = FALSE)
#df <- data.frame(URL="https://api.mapbox.com/styles/v1/gulffish123/cj3ycoorm06302qmralrl4dk3/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZ3VsZmZpc2gxMjMiLCJhIjoiY2l5a2IweTVtMDAwdDJxcGYzYmR0b3lndyJ9.PjwB4UC9ESaDhoe3ed_YKg")
#a <- "https://api.mapbox.com/styles/v1/gulffish123/cj3ycoorm06302qmralrl4dk3/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZ3VsZmZpc2gxMjMiLCJhIjoiY2l5a2IweTVtMDAwdDJxcGYzYmR0b3lndyJ9.PjwB4UC9ESaDhoe3ed_YKg"
#df <- read.csv("df.csv")
#df <- read.csv("df1.csv")
df <- read.csv("df3.csv", stringsAsFactors = FALSE) ##beware strings as factor =FALSE critical here


df$Start <- as.Date(df$Start, format="%m/%d/%Y")
df$End <- as.Date(df$End, format="%m/%d/%Y")
df$Name2 <- gsub(" ", "", df$Name)
# #write.csv(df, "getnames.csv", row.names=FALSE)
# 
# save(df, file="df.RData")

SD <- as.Date("1/1/2017", format="%m/%d/%Y")
ED <- as.Date("12/31/2017", format="%m/%d/%Y")

###DEFINE POPUP FOR EACH LAYER
KingMackerelMigratoryZonesPU <- htmlwidgets::JS(
  "function (error, featureCollection) {
    if(error || featureCollection.features.length === 0) {
      return false;
    } else {
    return 'King Mackerel Migratory Zones' ;
    }
  }")

SpanishMackerelMigratoryZonesPU <- htmlwidgets::JS(
  "function (error, featureCollection) {
    if(error || featureCollection.features.length === 0) {
      return false;
    } else {
    return 'SpanishMackerel Migratory Zones' ;
    }
  }")
xx <- data.frame(long=-85, lat=27.5)