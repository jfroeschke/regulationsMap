df <- read.csv("df3.csv", stringsAsFactors = FALSE) ##beware strings as factor =FALSE critical here


df$Start <- as.Date(df$Start, format="%m/%d/%Y")
df$End <- as.Date(df$End, format="%m/%d/%Y")
df$Name2 <- gsub(" ", "", df$Name)

map <- leaflet() %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>% 
  addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/KingMackerelZones/MapServer", 
                         group="A", popupFunction = KingMackerelPU)
map

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