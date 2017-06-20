## server.R
server <- function(input, output) { 
     
     
     superSelector <- reactive({
               df2 <- subset(df, df$FMP %in% input$selectFMP)
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
               addScaleBar(position="bottomright") #%>% 
        
          for(i in 1:length(superSelector())){
          map <- map %>%  addTiles(superSelector()[i]) 
            }
            
       map

          
     })
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     
     }