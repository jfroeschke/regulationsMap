## server.R
server <- function(input, output) { 
     
     
     superSelector <- reactive({
               df2 <- subset(df, df$FMP %in% input$selectFMP)
               #df2 <- subset(df2, df$Sector %in% input$selectSector)
               #df2 <- subset(df2, Start < input$daterange1[1])
               #df2 <- subset(df2, End > input$daterange1[2])
               tmp <- df2$URL
               tmp
                              })
     
      
      output$tbl2 <- renderText({superSelector()})
      
     output$map <- renderLeaflet({  
          map <- leaflet() %>% 
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               setView(-85, 27.75, zoom = 6) %>% 
               addMouseCoordinates(style=c("basic")) %>% 
               addScaleBar(position="bottomright") #%>% 
          
        
          for(i in 1:length(superSelector())){
          #map <- map %>%  addTiles(superSelector()[i]) 
          map <- map %>%  addEsriDynamicMapLayer(superSelector()[i])
            }
            
       map

          
     })
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     
     }