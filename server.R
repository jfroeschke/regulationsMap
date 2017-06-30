## server.R
server <- function(input, output) { 
     
     
     superSelector <- reactive({
               df2 <- subset(df, df$FMP %in% input$selectFMP)
               #df2 <- subset(df2, df$Sector %in% input$selectSector)
               #df2 <- subset(df2, Start < input$daterange1[1])
               #df2 <- subset(df2, End > input$daterange1[2])
               df2 <- arrange(df2, desc(order))
               tmp <- df2$URL
               tmp
                              })
     
     legendSelector <- reactive({
          df2 <- subset(df, df$FMP %in% input$selectFMP)
          #df2 <- subset(df2, df$Sector %in% input$selectSector)
          #df2 <- subset(df2, Start < input$daterange1[1])
          #df2 <- subset(df2, End > input$daterange1[2])
          df2 <- arrange(df2, desc(order))
          df2 <- select(df2, Color, Name)
          tmp <- df2
          tmp
     })
     
     radioSelector <- reactive({
          df2 <- subset(df, df$FMP %in% input$selectFMP)
          #df2 <- subset(df2, df$Sector %in% input$selectSector)
          #df2 <- subset(df2, Start < input$daterange1[1])
          #df2 <- subset(df2, End > input$daterange1[2])
          df2 <- arrange(df2, desc(order))
          df2 <- select(df2, Color, Name)
          tmp <- df2
          tmp
     })
     
      
      output$tbl2 <- renderText({legendSelector()})
      
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
          #map <- map %>%  addTiles(superSelector()[i]) 
          map <- map %>%  addEsriDynamicMapLayer(superSelector()[i])
            }
            
       map
     })
     
     output$tbl = DT::renderDataTable(
          species, options = list(lengthChange = FALSE))
     
}


######################### Example Only
################################################################################
# output$conditionalInput <- renderUI({
#      if(input$checkbox){
#           absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
#                         draggable = TRUE, top = 5, left = "auto", right = 275, bottom = "auto",
#                         width = 350, height = "auto",
#                         wellPanel(
#                              HTML('<button data-toggle="collapse" data-target="#demo1">Minimize controls</button>'),
#                              tags$div(id = 'demo1',  class="collapse in",
#                                       
#                                       HTML("Click on map to identify location of grouper interaction or enter coordinates in boxes below."),
#                                       #HTML('<textarea id="foo" rows="3" cols="20">Enter a comment</textarea>')
#                                       textInput("Lat", "Latitude", ""),
#                                       textInput("Lon", "Longitude", ""),
#                                       dateInput("date", "Date:", value = Sys.Date()),
#                                       textInput("name", "Name: (not required)", ""),
#                                       textInput("email", "Email: (not required)", ""),
#                                       selectInput("habitat", "Habitat:",
#                                                   c("Artificial reef", "Natural reef", "Shipwreck", "Other")),
#                                       checkboxInput("vented", "Was fish vented before release", FALSE),
#                                       textInput("comment", "Comments:", ""),
#                                       
#                                       verbatimTextOutput("out2"),
#                                       div(popify(bsButton("submit", label = "Submit location of goliath grouper",
#                                                           lock = TRUE, type = "toggle", value = TRUE,
#                                                           style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
#                                                  "Submit goliath grouper location"),style="text-align: center;"),
#                                       bsAlert("alert")#,
#                                       #output$value <- renderPrint({ input$Lon }) ##save this in a reative for download
#                              )))
#           
#      }
# })

# radioButtons("dist", "Distribution type:",
#              c("Normal" = "norm",
#                "Uniform" = "unif",
#                "Log-normal" = "lnorm",
#                "Exponential" = "exp")),