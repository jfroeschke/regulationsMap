## server.R
server <- function(input, output) { 
     
     
     superSelector <- reactive({
               df <- subset(df, df$FMP %in% input$selectFMP)
               
               if(input$selectFMP == "SHRIMP"){
                 df <- subset(df, df$Name2 %in% input$SHRIMPlayers)
               } 
               
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
          #df2 <- select(df2, Color, Name)
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
 ###highly experimental    
    inBounds <- reactive({
          if (is.null(input$map_bounds)){
          #      return(zipdata[FALSE,])
  
      
          bounds <- input$map_bounds
          
         boundsOut <- data.frame(N=bounds$north,
                                S=bounds$south,
                                E=bounds$east,
                                W=bounds$west)
         
         boundsLL <- data.frame(EW=((bounds$east + bounds$west)/2),
                                 NS=((bounds$north + bounds$south)/2)
                                )
         boundsLL                    
         #boundsOut
         }
         
                              
     })
     
    #test <- reactive({data.frame(input$map_bounds)})

      
      output$tblx <- renderTable({input$map_bounds})
      #output$tbl2 <- renderTable({input$map_bounds})
      # output$tbl3 <- renderText({input$map_zoom})
      #output$tbl4 <- renderPrint({input$lat})
     output$map <- renderLeaflet({  
          map <- leaflet() %>% 
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
                        options = providerTileOptions(noWrap = TRUE)) %>%
               addScaleBar(position="bottomright") %>% 
              setView(-85, 27, zoom=6) %>% 
               addMiniMap() %>% 
            addMouseCoordinates(style=("basic")) #%>% 
          
            #addHomeButton(ext=EXTENT, HTML("<i>Home</>"))
            if(input$selectFMP == "LOBSTER"){
             map <- map %>%  setView(-82, 25, zoom=9) 
            }
        
          map <- map %>%  addLegend(colors=c(legendSelector()$Color),
                         labels=c(legendSelector()$Name),
                         opacity=1, position="bottomleft")

     })
     
     
      
      observe({
        map  <- leafletProxy('map') 
        map <- map  %>% leaflet::clearGroup(group="A") #%>% 
          # isolate({map <- map  %>%
          # setView(inBounds()$EW, inBounds()$NS, zoom = input$map_zoom)
          # })
        for(i in 1:length(superSelector())){
          map <- map  %>%
            #addEsriDynamicMapLayer(superSelector()[i], group="A")
          addTiles(superSelector()[i], group="A")
        }
          
        map
      })
     
      observeEvent(input$map_zoom,{
       leafletProxy("map") %>% 
          setView(lat  = (input$map_bounds$north + input$map_bounds$south) / 2,
                  lng  = (input$map_bounds$east + input$map_bounds$west) / 2,
                  zoom = input$map_zoom)
      })
      
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     ##################################################
     summarySelector <- reactive({
       df <- subset(df, df$FMP %in% input$selectFMP)
       df <- arrange(df, desc(order))
       tmp <- df$RMD
       tmp
     })
     
     ################################################
     
     ##################################################
     downloadSelector <- reactive({
       df <- subset(df, df$FMP %in% input$selectFMP)
       df <- arrange(df, desc(order))
       tmp <- df$Download
       tmp
     })
     
     ################################################
     
     
     output$tbl2 <- renderTable({summarySelector()})
     
     output$Description <- renderUI({
       #for(i in 1:length(summarySelector() ))  {
       tags$iframe(src = summarySelector()[1], seamless=NA,width="100%", style="height: calc(100vh - 80px)",frameborder=0)
     })
     
     output$Download <- renderUI({
       #for(i in 1:length(summarySelector() ))  {
       tags$iframe(src = downloadSelector()[1], seamless=NA,width="100%", style="height: calc(100vh - 80px)",frameborder=0)
     })
     
     ## Download a map
     output$dl <- downloadHandler(
          filename = "map.png",
          
          content = function(file) {
               mapshot(map, file = file)
          }
     )
     
     
     
     ## End : Download a map
     ################################################################################
     observeEvent(input$home,{
          map  <- leafletProxy("map") %>%
               setView(-85, 27, zoom=6)
          map
     })
     ################################################################################ 
     
     
}


