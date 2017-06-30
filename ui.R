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
                         selectInput("selectFMP", multiple=TRUE,
                                     h3("Select Fishery Management Plan:"),
                                     c("Reef" = "REEF",
                                       "Shrimp" = "SHRIMP",
                                       "Lobster" = "LOBSTER",
                                       "Coastal Migratory Pelagic" = "CMP"),
                                     selected = c("LOBSTER")),
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
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h3("Contact us")), align="center"),
                    div(br()),
                    div(bookmarkButton(title=HTML('Click here to bookmark the current page with selections retained.
                                Generates a URL to return here.')), align="center")
                    )),
     dashboardBody(
          tabItems(
               tabItem(tabName='map',
                  leafletOutput('map',height=600),
                  textOutput('tbl2')
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