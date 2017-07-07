## ui.R


dashboardPage(
     dashboardHeader(title="Title"),
          dashboardSidebar(
               sidebarMenu(id = "tab",
                    menuItem("Map", tabName = "map", icon = icon("globe"),selected=TRUE),
                    menuItem("Table", tabName = "table", icon = icon("table")),
                    tags$hr(style="border-color: white;"),
                    tags$head(includeCSS("Style.css")),
                    div(
                         selectInput("selectSector", h3("I'm looking for:"),
                                     c("Commercial regualtions" = "COMMERCIAL",
                                       "Recreational regulations" = "RECREATIONAL",
                                       "All regulations" = "ALL"),
                                     selected = "COMMERCIAL")),
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
                                              "Spanish Mackerel" = "SpanishMackerelMigratoryZones"))
                         ),
                    # 
                    conditionalPanel(
                         condition = "input.selectFMP == 'LOBSTER'",
                         checkboxGroupInput("LOBSTERlayers", "Lobster layers:",
                                            c("Lobster Trap Closure" = "LobsterTrapClosure"
                                              ))
                    ),

                    conditionalPanel(
                         condition = "input.selectFMP == 'CORAL'",
                         checkboxGroupInput("CORALlayers", "Coral layers:",
                                            c("McGrail Bank" = "McGrailBank",
                                              "MiddleGrounds" = "MiddleGrounds",
                                              "Pulley Ridge" = "PulleyRidge",
                                              "Stetson Bank" = "StetsonBank",
                                              "Tortugas" = "Tortugas"
                                            ))
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
               tabItem(tabName='map',
                  leafletOutput('map',height=600),
                  tableOutput('tbl2')
                  ),
               
               tabItem(tabName='table',
                       DT::dataTableOutput('tbl')
                       )
          )
          
          )
)

####################Example dynamic UI output
# checkboxInput("checkbox", "Report Goliath Grouper interaction", FALSE),
# uiOutput("conditionalInput")