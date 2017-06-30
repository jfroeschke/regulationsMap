##Test layers on WMS 


library(leaflet)
library(leaflet.esri)
 
map <- leaflet() %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  setView(-85, 27.75, zoom = 7) %>% 
  #addMouseCoordinates(style=c("basic")) %>% 
  addScaleBar(position="bottomright") #%>% 
  

map <- map %>%  
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/CobiaMigratoryZones/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/KingMackerelZones/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/SpanishMackerelMigratoryZones/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/McGrailBank/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/MiddleGrounds/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/PulleyRidge/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/StetsonBank/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/Tortugas/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/AlabamaSMZ/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/GulfReefLonglineSeasonal/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/LonglineBuoy/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/MadisonSwanson/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/ReefStressed/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/ShallowWaterGrouper/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/SteamboatLumps/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/TheEdges/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/GulfShrimpBycatch/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/ShrimpCrabSeparationZones/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/SouthwestFlSeasonalTrawlClosure/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/TexasShrimpClosure/MapServer")
#addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/TortugasShrimpSanctuary/MapServer")
addEsriDynamicMapLayer("http://portal.gulfcouncil.org/arcgis/rest/services/ManagementMaps/lobstertrapgear/MapServer")
map


 