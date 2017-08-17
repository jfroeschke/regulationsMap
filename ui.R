## ui.R


dashboardPage(
     dashboardHeader(title="GIS Data for the Gulf of Mexico Fisheries"),
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
                    div(
                         selectInput("selectFMP", multiple=FALSE,
                                     h3("Select Fishery Management Plan:"),
                                     c("Coastal Migratory Pelagic" = "CMP",
                                        "Coral" = "CORAL",
                                        "Lobster" = "LOBSTER",
                                        "Reef" = "REEF",
                                        "Shrimp" = "SHRIMP"
                                       ),
                                     selected = c("CORAL")),
                         
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
                                            c("McGrail Bank" = "McGrailBank",
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

                    

                    
                    div(
                    dateRangeInput("daterange1", h3("Date range:"),
                                   start = Sys.Date(),
                                   end   = Sys.Date()),
                    bsTooltip("daterange1", 
                              "Select range of dates for applicable regulations. Defaults to current date", options = list(container = "body"))
                    ),
                    
                    
                    
                    div(img(src="logo.png"), style="text-align: center;"),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h3("Contact us")), align="center"),
                    div(br()),
                    div(bookmarkButton(title=HTML('Click here to bookmark the current page with selections retained.
                                Generates a URL to return here.')), align="center")
                    )),
     dashboardBody(
          tabItems(
               tabItem(tabName='map',includeHTML('modalHTML4.html'),
                       includeScript('modalJS.js'),
                  leafletOutput('map',height=600),
                  #downloadButton("dl"),
                  box(htmlOutput("Description"), width=8),
                  box(htmlOutput("Download"), width=4),
                  #tableOutput('tblx'),
                  #textOutput('tbl3')#,
                  #verbatimTextOutput('tbl4')
                  
                  ################# Experimental
                  absolutePanel(id = "controls", class = "panel panel-default", fixed = FALSE,
                                draggable = TRUE, top = 100, left = "auto", right = 20, bottom = "auto",
                                width = 150, height = "auto",
                                wellPanel(
                                     #HTML('<button data-toggle="collapse" data-target="#demo">Minimize controls</button>'),
                                     tags$div(id = 'demo',  class="collapse in",

                                              div(downloadButton("dl", "Save map"), style="text-align: center;"),
                                              #actionButton("go", "Save map"),
                                              div(
                                                   br(),
                                                   div(actionButton("home"," ", icon=icon("home")), style="text-align: center;")


                                              )
                                     )
                                )
                  )
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