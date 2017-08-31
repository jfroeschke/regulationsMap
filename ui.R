## ui.R


dashboardPage(
     dashboardHeader(disable=TRUE),
    # title="GIS Data for the Gulf of Mexico Fisheries"),
          dashboardSidebar(
               sidebarMenu(id = "tab",
                    #menuItem("Map", tabName = "map", icon = icon("globe"),selected=TRUE),
                    menuItem(" ", tabName = "map",selected=TRUE),
                    #menuItem("Table", tabName = "table", icon = icon("table")),
                    #tags$hr(style="border-color: #808080;"),
                    tags$head(includeCSS("Style.css")),
                    # div(
                    #      selectInput("selectSector", h3("I'm looking for:"),
                    #                  c("Commercial regualtions" = "COMMERCIAL",
                    #                    "Recreational regulations" = "RECREATIONAL",
                    #                    "All regulations" = "ALL"),
                    #                  selected = "COMMERCIAL")),
                    div(img(src="logo.png"), style="text-align: center;"),
                    div(
                         selectInput("selectFMP", multiple=FALSE,
                                     h3("Select Fishery Management Plan:"),
                                     c(#"Coastal Migratory Pelagic" = "CMP", ##removed for now
                                        "Coral and Coral Reefs" = "CORAL",
                                        "Spiny Lobster" = "LOBSTER",
                                        "Reef Fish" = "REEF",
                                        "Shrimp" = "SHRIMP"
                                       ),
                                     selected = c("CORAL")),
                         #div(actionButton("home"," ", icon=icon("home")), style="align:center"),
                         
                         bsTooltip("selectFMP", 
                                   "Select applicable FMP", options = list(container = "body"))
                         # bsPopover("selectFMP", 
                         #           "Select applicable FMP", options = list(container = "body"))
                    ),
                    
                    uiOutput("conditionalInput"),
                    conditionalPanel(
                         condition = "input.selectFMP == 'CMP'",
                         checkboxGroupInput("CMPlayers", "CMP layers",
                                            c("Cobia Migratory Zones" = "CobiaMigratoryZones",
                                              "King Mackerel Migratory Zones" = "KingMackerelMigratoryZones",
                                              "Spanish Mackerel" = "SpanishMackerelMigratoryZones"),
                                            selected="SpanishMackerelMigratoryZones")
                         ),
                    # 
                    conditionalPanel(
                         condition = "input.selectFMP == 'LOBSTER'",
                         checkboxGroupInput("LOBSTERlayers", "Lobster layers:",
                                            c("Lobster Trap Closure" = "LobsterTrapClosure"
                                              ), selected="LobsterTrapClosure")
                    ),

                    conditionalPanel(
                      condition = "input.selectFMP == 'SHRIMP'",
                      checkboxGroupInput("SHRIMPlayers", "Shrimp layers:",
                                         c("Gulf Shrimp Bycatch" = "GulfShrimpBycatch",
                                           "Shrimp Crab Separation Zones" = "ShrimpCrabSeparationZones",
                                           "Southwest Florida Seasonal Trawl Closure" = "SouthwestFloridaSeasonalTrawlClosure",
                                           "Texas Shrimp Closure" = "TexasShrimpClosure",
                                           "Tortugas Shrimp Sanctuary" = "TortugasShrimpSanctuary"
                                           )

                                         , selected="ShrimpCrabSeparationZones")
                    ),
                    
                    
                    
                    conditionalPanel(
                         condition = "input.selectFMP == 'CORAL'",
                         checkboxGroupInput("CORALlayers", "Coral layers:",
                                            c("East West FlowerGardenBanks" = "EastWestFlowerGardenBanks",
                                                 "McGrail Bank" = "McGrailBank",
                                              "MiddleGrounds" = "MiddleGrounds",
                                              "Pulley Ridge" = "PulleyRidge",
                                              "Stetson Bank" = "StetsonBank",
                                              "Tortugas" = "Tortugas"
                                            ),
                                            selected="PulleyRidge")
                         
                    ),
                    
                    conditionalPanel(
                         condition = "input.selectFMP == 'REEF'",
                         checkboxGroupInput("REEFlayers", "Reef fish layers:",
                                            c("Alabama SMZ" = "AlabamaSMZ",
                                              "Gulf Reef Longline Seasonal Closure" = "GulfReefLonglineSeasonalClosure",
                                              "Longline Buoy Closure" = "LonglineBuoyClosure",
                                              "Madison Swanson" = "MadisonSwanson",
                                              "Reef Fish Stressed Area" = "ReefStressedArea",
                                              "Shallow Water Grouper Closed Area" = "ShallowWaterGrouperClosedArea",
                                              "Steamboat Lumps" = "SteamboatLumps",
                                              "The Edges" = "TheEdges"
                                            ))
                    ),

                    
## JF commented out Aug 8, 2017: This is a filter to select layers to display based on a user
## specified date, or range of dates.  Uncomment to enable feature.
                    
                    # div(
                    # dateRangeInput("daterange1", h3("Date range:"),
                    #                start = Sys.Date(),
                    #                end   = Sys.Date()),
                    # bsTooltip("daterange1", 
                    #           "Select range of dates for applicable regulations. Defaults to current date", options = list(container = "body"))
                    # ),
          #plotOutput("side"),          
#div(img(src=df$image[1], height=517, width=200), style="text-align: center;"),
                     br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                  

                    #div(img(src="logo.png"), style="text-align: center;"),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h4("portal@gulfcouncil.org")), align="center"),
                    div(br()),
HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 2203 North Lois Avenue, Suite 1100 <br>
     Tampa, Florida 33607 USA <br> P: 813-348-1630")
                    # div(bookmarkButton(title=HTML('Click here to bookmark the current page with selections retained.
                    #             Generates a URL to return here.')), align="center")
                    )),
     dashboardBody(
          tabItems(
               tabItem(tabName='map',includeHTML('modalHTML4.html'),
                       includeScript('modalJS.js'),
                       #tags$img(src="HAPCViewerBanner.png",  width="100%"),
                     HTML("<h3 id='title' style='color: white;' >GIS Data Mapping Application for the Gulf of Mexico Fisheries</h3>"),
                  leafletOutput('map',height=600),
                  #downloadButton("dl"),
                  box(htmlOutput("Description"), width=12),
                  box(htmlOutput("Download"), width=4)#,
                  #tableOutput('tblx'),
                  #textOutput('tbl3')#,
                  #verbatimTextOutput('tbl4')
                  
                  ################# Experimental
                  # absolutePanel(id = "controls", class = "panel panel-default", fixed = FALSE,
                  #               draggable = TRUE, top = 100, left = "auto", right = 20, bottom = "auto",
                  #               width = 150, height = "auto",
                  #               wellPanel(
                  #                    #HTML('<button data-toggle="collapse" data-target="#demo">Minimize controls</button>'),
                  #                    tags$div(id = 'demo',  class="collapse in",
                  # 
                  #                             div(downloadButton("dl", "Save map"), style="text-align: center;"),
                  #                             #actionButton("go", "Save map"),
                  #                             div(
                  #                                  br(),
                  #                                  div(actionButton(""," ", icon=icon("home")), style="text-align: center;")
                  # 
                  # 
                  #                             )
                  #                    )
                  #               )
                  # )
                  ################# Experimental
                  
                  
                  
                  
                  
                  
                  
                  )#,
               
               # tabItem(tabName='table',
               #         DT::dataTableOutput('tbl')
               #         )
          )
          
          )
)

####################Example dynamic UI output
# checkboxInput("checkbox", "Report Goliath Grouper interaction", FALSE),
# uiOutput("conditionalInput")