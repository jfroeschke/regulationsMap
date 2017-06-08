## server.R
server <- function(input, output) { 
     
     
     output$map <- renderLeaflet({  
          map <- leaflet() %>% 
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               setView(-85, 27.75, zoom = 6) %>% 
               addScaleBar(position="bottomright") 
     })
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     
     }