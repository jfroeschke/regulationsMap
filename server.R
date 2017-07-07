## server.R
server <- function(input, output) { 
     
     
     superSelector <- reactive({
               df <- subset(df, df$FMP %in% input$selectFMP)
               
               if(input$selectFMP == "CMP"){
                    df <- subset(df, df$Name2 %in% input$CMPlayers)
               } 
               
               if(input$selectFMP == "LOBSTER"){
                    df <- subset(df, df$Name2 %in% input$LOBSTERlayers)
               }
               
               if(input$selectFMP == "REEF"){
               df <- subset(df, df$Name2 %in%  input$REEFlayers)
               }
               
               if(input$selectFMP == "CORAL"){
                    df <- subset(df, df$Name2 %in%  input$CORALlayers)
               }
              
               df <- arrange(df, desc(order))
               tmp <- df$URL
               tmp
                              })
     
     legendSelector <- reactive({
          df2 <- subset(df, df$FMP %in% input$selectFMP)
          df2 <- arrange(df2, order)
          df2 <- select(df2, Color, Name)
          tmp <- df2
          tmp
     })
     
     ## Will use later
     # checkboxSelector <- reactive({
     #      df2 <- subset(df, df$FMP %in% input$selectFMP)
     #      #df2 <- subset(df2, df$Sector %in% input$selectSector)
     #      #df2 <- subset(df2, Start < input$daterange1[1])
     #      #df2 <- subset(df2, End > input$daterange1[2])
     #      df2 <- arrange(df2, desc(order))
     #      df2 <- select(df2, Color, Name)
     #      tmp <- df2
     #      tmp
     # })
     
      
      output$tbl2 <- renderTable({legendSelector()})
      
     output$map <- renderLeaflet({  
          map <- leaflet() %>% 
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               setView(-85, 27.75, zoom = 6) %>% 
               addMouseCoordinates(style=c("basic")) %>% 
               addScaleBar(position="bottomright") 
          
          
          map <- map %>%  addLegend(colors=c(legendSelector()$Color),
                         labels=c(legendSelector()$Name),
                         opacity=1, position="bottomleft")

        
          for(i in 1:length(superSelector())){
          map <- map %>%  addEsriDynamicMapLayer(superSelector()[i])
            }
            
       map
     })
     
     # Tried this, not helping
     # observeEvent(input$map_zoom,{
     #      proxy  <- leafletProxy("map") %>%  
     #           setView(-85, 27.75, zoom = input$map_zoom)
     # })
     
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     
}


