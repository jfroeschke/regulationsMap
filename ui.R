## ui.R


dashboardPage(
     dashboardHeader(title="Title"),
          dashboardSidebar(
               sidebarMenu(id = "tab",
                    menuItem("Map", tabName = "map", icon = icon("fa fa-globe"),selected=TRUE),
                    menuItem("Table", tabName = "table", icon = icon("fa fa-table")),
                    tags$hr(style="border-color: white;"),
                    tags$head(includeCSS("Style.css")),
                    div(
                         selectInput("selectGear", h3("I'm looking for:"),
                                     c("Commercial regualtions" = "COMMERCIAL",
                                       "Recreational regulations" = "RECREATIONAL",
                                       "All regulations" = "ALL"),
                                     selected = "ALL")),
                    div(
                         selectInput("selectFMP", h3("Select Fishery Management Plan:"),
                                     c("Reef fish" = "REEFFISH",
                                       "Lobster" = "RECREATIONAL",
                                       "Coastal Migratory Pelagic" = "CMP",
                                       "All" = "ALL"),
                                     selected = "ALL"),
                         bsTooltip("selectFMP", 
                                   "Select applicable FMP", options = list(container = "body"))
                         # bsPopover("selectFMP", 
                         #           "Select applicable FMP", options = list(container = "body"))
                    ),
                    
                    
                    div(
                    dateRangeInput("daterange1", h3("Date range:"),
                                   start = Sys.Date(),
                                   end   = Sys.Date()),
                    bsTooltip("daterange1", 
                              "Select range of dates for applicable regulations. Defaults to current date", options = list(container = "body"))
                    ),
                    
                
                    
                    
                    div(img(src="logo.png"), style="text-align: center;"),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h3("Contact us")), align="center")
                    )),
     dashboardBody(
          tabItems(
               tabItem(tabName='map',
                  leafletOutput('map',height=600)),
               tabItem(tabName='table',
                       DT::dataTableOutput('tbl')
                       )
          )
          
          )
)