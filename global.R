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
library(webshot)
library(htmltools)

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


############## mouse coordinates
addMouseCoordinates2 <- function (map, style = c("detailed", "basic"), epsg = NULL, proj4string = NULL, 
                  native.crs = FALSE) 
{
     style <- style[1]
     if (inherits(map, "mapview")) 
          map <- mapview2leaflet(map)
     stopifnot(inherits(map, "leaflet"))
     if (style == "detailed" && !native.crs) {
          txt_detailed <- paste0("\n      ' x: ' + L.CRS.EPSG3857.project(e.latlng).x.toFixed(0) +\n      ' | y: ' + L.CRS.EPSG3857.project(e.latlng).y.toFixed(0) +\n      ' | epsg: 3857 ' +\n      ' | proj4: +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs ' +\n      ' | lon: ' + (e.latlng.lng).toFixed(5) +\n      ' | lat: ' + (e.latlng.lat).toFixed(5) +\n      ' | zoom: ' + map.getZoom() + ' '")
     }
     else {
          txt_detailed <- paste0("\n      ' x: ' + (e.latlng.lng).toFixed(2) +\n      ' | y: ' + (e.latlng.lat).toFixed(2) +\n      ' | epsg: ", 
                                 epsg, " ' +\n      ' | proj4: ", proj4string, " ' +\n       + map.getZoom() + ' '")
     }
     txt_basic <- paste0("\n    ' Longitude: ' + (e.latlng.lng).toFixed(2) +\n    ' | Latitude: ' + (e.latlng.lat).toFixed(1) +\n      + ' '")
     txt <- switch(style, detailed = txt_detailed, basic = txt_basic)
     map <- htmlwidgets::onRender(map, paste0("\nfunction(el, x, data) {\n\n  // get the leaflet map\n  var map = this; //HTMLWidgets.find('#' + el.id);\n\n  // we need a new div element because we have to handle\n  // the mouseover output separately\n  // debugger;\n  function addElement () {\n    // generate new div Element\n    var newDiv = $(document.createElement('div'));\n    // append at end of leaflet htmlwidget container\n    $(el).append(newDiv);\n    //provide ID and style\n    newDiv.addClass('lnlt');\n    newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '10px',\n      'background-color': 'rgba(255, 255, 255, 1)',\n      'box-shadow': '0 0 50px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '10',\n      'padding-left': '5px',\n      'color': '#333',\n      'font': '14px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n    });\n    return newDiv;\n  }\n\n  // check for already existing lnlt class to not duplicate\n  var lnlt = $(el).find('.lnlt');\n  if(!lnlt.length) {\n    lnlt = addElement();\n\n    // grab the special div we generated in the beginning\n    // and put the mousmove output there\n    map.on('mousemove', function (e) {\n      lnlt.text(", 
                                              txt, ");\n    })\n  };\n}\n"))
     map
}