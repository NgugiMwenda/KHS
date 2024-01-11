setwd('C:/Users/Prof/Desktop/kiroria official/Housing and Rent Survey R shinny Dashboard/KRHS_Dashboard_GitHub')
#source("susor_krhs.R")  #uncoment to dowload new datasets
source("load_packages.R")  #load relevant packages
source('6 passwords.R')  #load passwords for downloading data

source("0 household.R")  #load household data
source("1 county gov.R")  #load household data
source("4 institutional.R") #load institution data



####-------------------------------------------------------------------------->   start ui
ui <- 
  #------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Welcome
  navbarPage("Kenya Housing Survey (KHS) Dashboard", 
             collapsible = TRUE, 
             inverse = TRUE, 
             theme = shinytheme("united"),   #journal
             tabPanel("Welcome!",Sys.Date(),
                      sidebarPanel(
                        img(src="m.jpeg", height="100%", width="100%", align = "center") ,
                        h5("A collaboration between the Kenya National Bureau of Statistics (KNBS)", style="text-align:center"),
                        h5("&", style="text-align:center"),
                        h5("The State Department of Housing and Urban Development", style="text-align:center"),
                      ),
                      mainPanel(
                        h1("Welcome to the Kenya Housing Survey - Dashboard", align = "left"),
                        p("You can Navigate the tabs for a quick look at the statistics as well as generate errors and reports"),                        
                      )
             ),
             #------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Welcome
    #         navbarPage("Kenya Housing Survey (KHS) Dashboard", 
    #                    collapsible = TRUE, 
    #                    inverse = TRUE, 
    #                    theme = shinytheme("united"),   #journal
    #                    tabPanel("Welcome!",Sys.Date(),
    #                             tags$h4("Welcome to the Kenya Housing Survey Dashboard. You can Navigate the tabs for a quick look at the statistics as well as generate errors and reports"),
    #                             tags$br(),
    #                             tags$h3("Makao fiti, Maisha Bora"),
    #                    ),
             
             
             tabPanel("Relevant Development Indicators Indicators",Sys.Date(), 
                      fluidPage(
                        tabsetPanel(
                          tabPanel( h4("National Indicators"), 
                                   mainPanel(#h3("The National Indicators to be computed from the Survey are-"),
                                             h5("1. Proportion of urban population living in slums, informal settlements or inadequate housing"),       
                                             h5("2. Value of dwelling stocks constructed by households"),
                                             h5("3. Value of dwelling stocks constructed by Institutions"),
                                             h5("4. Value of Household Expenditure on Housing by Category "),
                                             h5("5. Ownership of dwellings by Sex"),
                                             h5("6. Proportion of Population living in owner occupied dwellings "),
                                             h5("7. Proportion of Population living in rented dwellings "),
                                             h5("8. Value of Expenditure on maintenance and renovations"),
                                             h5("9. Rent levels by household income categories"),
                                             h5("10. Distribution of dwellings by size/counties/rural/urban"),
                                             h5("11. Housing Overcrowding"),
                                             h5("12. Sell/Purchase Price for dwellings by category"),
                                             h5("13. Age of dwellings"),
                                             h5("14. Size of dwellings "),
                                             h5("15. Dwelling charecteristics : roofing, walls, floors materials, type etcs"),
                                             h5("16. Quantity of energy used by dwellings by dwelling type "),
                                             h5("17. Value of Energy used by dwellings by dwelling type"),
                                             h5("18. Type of Energy consumed by dwellings"),
                                             h5("19. Stock of Affordable housing constructed"),
                                             h5("20. Value of all stock of affordable housing constructed"),
                                             h5("21. Unmet housing need"),
                                             h5("22. Effective demand for renters and homeowners"),
                                             h5("23. Waste disposal method used by dwellings"),
                                             h5("24. Cooking methods used by dwellings"),
                                             h5("25. Source of drinking water for dwellings"),
                                             h5("26. Percentage of rental houses fully occupied; occupation status"),
                                             h5("27. Percentage of homeowner with mortgages"),
                                             h5("28. Proportion of dwelling renters with acccess to mortgage financing. "),
                                             h5("29. Housing affordability"),
                                             h5("30. Wealth Index"),
                                             h5("31. Quality housing index"))), 
                          tabPanel(h4("County Indicators"), 
                                   mainPanel(#h3("The County Indicators to be computed from the Survey are"),
                                             h5("1. Value of Household Expenditure on Housing by Category "),
                                             h5("2. Ownership of dwellings by Sex"),
                                             h5("3. Proportion of Population living in owner occupied dwellings "),
                                             h5("4. Proportion of Population living in rented dwellings "),
                                             h5("5. Value of Expenditure on maintenance and renovations"),
                                             h5("6. Rent levels by household income categories"),
                                             h5("7. Distribution of dwellings by size/counties/rural/urban"),
                                             h5("8. Housing Overcrowding"),
                                             h5("9. Sell/Purchase Price for dwellings by category"),
                                             h5("10. Age of dwellings"),
                                             h5("11. Size of dwellings "),
                                             h5("12. Dwelling charecteristics : roofing, walls, floors materials, type etcs"),
                                             h5("13. Quantity of energy used by dwellings by dwelling type "),
                                             h5("14. Value of Energy used by dwellings by dwelling type"),
                                             h5("15. Type of Energy consumed by dwellings"),
                                             h5("16. Stock of Affordable housing constructed"),
                                             h5("17. Value of all stock of affordable housing constructed"),
                                             h5("18. Unmet housing need"))), 
                          tabPanel(h4("Sustainable Development Goals (SDG's) 2030 Indicators"), 
                                   mainPanel(#h3("The Sustainable Development Goals (SDG's) 2030 Indicators to be computed from the Survey are-"),
                                             h5("1. Indicator 1.4.1: Proportion of population living in households with access to basic services"),
                                             h5("2. Indicator 1.4.2: Proportion of total adult population with secure tenure rights to land, (a) with legally recognized documentation, and (b) who perceive their rights to land as secure, by sex and type of tenure"),
                                             h5("3. Indicator 5.b.1: Proportion of individuals who own a mobile telephone, by sex"),
                                             h5("4. Indicator 6.1.1: Proportion of population using safely managed drinking water services"),
                                             h5("5. Indicator 6.2.1: Proportion of population using (a) safely managed sanitation services and (b) a hand-washing facility with soap and water"),
                                             h5("6. Indicator 7.1.1: Proportion of population with access to electricity"),
                                             h5("7. Indicator 7.1.2: Proportion of population with primary reliance on clean fuels and technology"),
                                             h5("8. Indicator 8.7.1: Proportion and number of children aged 5–17 years engaged in child labour, by sex and age"),
                                             h5("9. Indicator 9.1.1: Proportion of the rural population who live within 2 km of an all-season road"),
                                             h5("10. Indicator 11.1.1: Proportion of urban population living in slums, informal settlements or inadequate housing"),
                                             h5("11. Indicator 11.2.1: Proportion of population that has convenient access to public transport, by sex, age and persons with disabilities"),
                                             h5("12. Indicator 16.1.4: Proportion of population that feel safe walking alone around the area they live after dark"),
                                             h5("13. Indicator 17.8.1: Proportion of individuals using the Internet"))), 
                        ))),
             #------------------------------------------------------------------------------------------------------------------------------------------------------------------Summary statistics            
             tabPanel("Summary Survey Statistics",
                      fluidPage(
                        tabsetPanel(
                          tabPanel("Household Questionnaire",
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Overall Interview Status by County",mainPanel(plotlyOutput("pu1"))),
                                       tabPanel("National Households visit status outcome",mainPanel(plotlyOutput("pu2"))),
                                       tabPanel("Visit status as a (%) of completed interviews By County",mainPanel(tableOutput("ts2"))),
                                       tabPanel("Interviews Submitted by counties by Date",mainPanel(plotOutput("pu3")))))),
                          tabPanel("County govenment",
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Interviews submitted by date",mainPanel(plotOutput("cpu1"))),
                                       tabPanel("Building Requests and approvals 2021 and 2022",mainPanel(plotlyOutput("cpu2"))),
                                       tabPanel("Mean and Median time taken for building approvals",mainPanel(plotlyOutput("cpu3"))),
                                       tabPanel("xxxxxx"),
                                       tabPanel("yyyy")
                                     ))),
                          tabPanel("Institutional and Regulators Questionnaire",
                                   fluidPage(
                                     tabsetPanel(
                                     tabPanel("Type of structures for all institutions",mainPanel(plotlyOutput("fig_th"))),
                                     tabPanel("Most preffered structures by Kenyans to live or rent in %",mainPanel(plotlyOutput("hf1_in"))),
                                     tabPanel("Median Sale Price Per unit in Kenya",mainPanel(plotlyOutput("pih")))
                                   ))),
                          tabPanel("Built Environment Proffesionals",
                                   fluidPage(tabsetPanel(
                                     tabPanel("Total Submission of Interviews per Day"),
                                     tabPanel("Total Submission of Interviews per Day")
                                   ))),
                        ))), 
             
             tabPanel("Geospatial Statistics",  mainPanel(leafletOutput("map", width="1000px",height = "600px"))),
             
             #---------------------------------------------------------------------------------------------------------------------------------------------------->
             tabPanel("Field Errors ",Sys.Date(),
                      fluidPage(
                        tabsetPanel(
                          tabPanel("Household Questionnaire", 
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Visualize Errors By the Supervisor",
                                                dashboardBody(
                                                  box(title="Filter", status='warning', solidHeader = T,
                                                      selectInput("findSupName", "Choose Supervisor:", unique(all_errors$fullname ))),
                                                  box(title="Barplot of errors", status='primary', solidHeader = T, plotOutput("p1")),
                                                )),
                                       tabPanel("Download Field Errors by Supervisor",Sys.Date(),
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    # Input: Choose dataset ----
                                                    selectInput("dataset", "Choose the file with the errors:",
                                                                choices = c( "Section A:Household Identification",
                                                                             "Section B: Information for Household members",
                                                                             "Section C: Household Amenities")),
                                                    downloadButton("downloadData", "Download as CSV")
                                                  ),
                                                  # Main panel for displaying outputs ----
                                                  mainPanel(h3("Raw data errors"),tableOutput("t2"))))))),
                          tabPanel("Institution Questionnaire", 
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Visualize Errors By the Supervisor",
                                                dashboardBody(
                                                  box(title="Filter", status='warning', solidHeader = T,
                                                      selectInput("findSupName", "Choose Supervisor:", unique(all_errors$fullname ))),
                                                  box(title="Barplot of errors", status='primary', solidHeader = T, plotOutput("p2")),
                                                )),
                                       tabPanel("Download Tabulation Errors by Supervisor",Sys.Date(),
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    # Input: Choose dataset ----
                                                    selectInput("dataset", "Choose the file with the errors:",
                                                                choices = c( "House Visit Missing Vistt Status",
                                                                             "House missing Interviewer name")),
                                                    downloadButton("downloadData2", "Download as CSV")
                                                  ),
                                                  # Main panel for displaying outputs ----
                                                  mainPanel(h3("Raw data errors"),tableOutput("t3"))))))),
                          tabPanel("Institutional and Regulators Questionnaire", 
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Visualize Errors By the Supervisor",
                                                dashboardBody(
                                                  box(title="Filter", status='warning', solidHeader = T,
                                                      selectInput("findSupName", "Choose Supervisor:", unique(all_errors$fullname ))),
                                                  box(title="Barplot of errors", status='primary', solidHeader = T, plotOutput("p3")),
                                                )),
                                       tabPanel("Download Tabulation Errors by Supervisor",Sys.Date(),
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    # Input: Choose dataset ----
                                                    selectInput("dataset", "Choose the file with the errors:",
                                                                choices = c( "House Visit Missing Vistt Status",
                                                                             "House missing Interviewer name")),
                                                    downloadButton("downloadData3", "Download as CSV")
                                                  ),
                                                  # Main panel for displaying outputs ----
                                                  mainPanel(h3("Raw data errors"),tableOutput("t4"))))))),
                          tabPanel("Built Environment Proffesionals", 
                                   fluidPage(
                                     tabsetPanel(
                                       tabPanel("Visualize Errors By the Supervisor",
                                                dashboardBody(
                                                  box(title="Filter", status='warning', solidHeader = T,
                                                      selectInput("findSupName", "Choose Supervisor:", unique(all_errors$fullname ))),
                                                  box(title="Barplot of errors", status='primary', solidHeader = T, plotOutput("p4")),
                                                )),
                                       tabPanel("Download Tabulation Errors by Supervisor",Sys.Date(),
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    # Input: Choose dataset ----
                                                    selectInput("dataset", "Choose the file with the errors:",
                                                                choices = c( "House Visit Missing Vistt Status",
                                                                             "House missing Interviewer name")),
                                                    downloadButton("downloadData4", "Download as CSV")
                                                  ),
                                                  # Main panel for displaying outputs ----
                                                  mainPanel(h3("Raw data errors"),tableOutput("t5"))))))),
                        ))), 
             
             
             
             
             tabPanel("About KHS",Sys.Date(),
                tags$h4("Kenya Housing Survey"), 
                "As the Principal Government agency mandated to collect official statistics, 
                Kenya National Bureau of Statistics (KNBS) conducts household surveys. 
                The 2023/24 Kenya Housing Survey (KHS) is a cross-sectional survey designed to gather information and generate estimates 
                for housing indicators in Kenya. To achieve this, the survey will use mixed methods of data collection which will target 
                both households and institutions. In addition to the data collected through the survey, satellite images and aerial photographs 
                will be analyzed to determine spatial changes in housing construction between the years 2018 and 2023.
                The survey is being implemented by KNBS in collaboration with the State Department of Housing and Urban Development.",
               tags$br(),
               tags$br(),
               "Queries regarding this exercise may be addressed to: ",
               tags$br(),
               "Senior Manager Industry - indegwa@knbs.or.ke ",
               tags$br(),
               "Project Cordinator - skakungu@knbs.or.ke",
               tags$br(),
               tags$h4("R Code"),
               "The R Code used to generate this dashboard will be archived here", 
               tags$a(href="https://github.com/NgugiMwenda/K-HMSF-Shiny-Dashboard", "Github, Ngugi Mwenda"),
               tags$br(),
               tags$h4("Author"),
               "Dr S. Ngugi Mwenda, Sampling Methods & Standards Division, Statistical Co-ordination & Methods Directorate, Kenya National Bureau of Statistics",
               tags$br(),
               tags$h4("Contacts"),
               "Official:", tags$i("smwenda@knbs.or.ke") , "Personal:", tags$i("geeglm2020@gmail.com"),
               tags$br(),
               tags$h4("Disclaimer"),
               tags$i("This work and all the codes are property of Kenya Natinal Bureau of Statistics. 
It was developed when the author was an employee at the Bureau. It is copyrighted by the Bureau and any use, replication in any form,
a consent must be done in writting using directorgeneral@knbs.or.ke"),
             )
  )

server <- function(input, output) {
#------------------------------------------------------------------------------------------------------------------------------------------Plots
  #------------------------------------------------------------------------plot household
output$pu1<-renderPlotly({ps1}) 
output$pu2<-renderPlotly({ps2})
output$pu3<-renderPlot({ps3})

#-----------------------------------------------------------------------plot county government
output$cpu1<-renderPlot({c_ps3})
output$cpu2<-renderPlotly({fig_ra }) 
output$cpu3<-renderPlotly({fig_ta }) 

#---------------------------------------------------------------------plot instituition
output$fig_th<-renderPlotly({fig_th}) 
output$hf1_in<-renderPlotly({hf1_in})
output$pih<-renderPlotly({pih})
#------------------------------------------------------------------------------------------------------------------------------------------>END

#------------------------------------------------------------------------------------------------------------------------------------------->Table output
output$ts2<-renderTable({ks3})

#------------------------------------------------------------------------------------------------------------------------------------------->End of tables



#-------------------------------------------------------------------------------------------------------------------------------------------> Download Errors
datasetInput <- reactive({
  switch(input$dataset,
         "Section A:Household Identification" = ern,
         "Section B: Information for Household members"=m4,
         "Section C: Household Amenities"=ersc
         
  )
})

output$t2 <- renderTable({head(datasetInput(),10)})
# Downloadable errors csv of selected dataset ----
output$downloadData <- downloadHandler(
  filename = function() {
    paste(input$dataset, ".csv", sep = "")
  },
  content = function(file) {
    write.csv(datasetInput(), file, row.names = FALSE)
  }
)
  
#------------------------------------------------------------------------------------------------------------------------------------------->Maps start here
  
  output$map <- renderLeaflet({ 
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldImagery,options = providerTileOptions(noWrap = FALSE)) %>%
      addCircles(data = gps.pick2, weight = 2, radius=5,color="#00FFFF", stroke = TRUE, fillOpacity = 1) %>%
      addPolygons(data = kenya.polys, weight = 2,color="white",stroke = TRUE, fillOpacity = 0.000, popup = ~FIRST_CouN) %>%
      addPolygons(data = kenya.polys2 , weight = 2,color="yellow",stroke = TRUE, fillOpacity = 0.000, 
                  popup =~EAName,label=~EAName,group ="kenya.polys2") %>%
      addLegend("bottomright", colors= "#00FFFF", labels= "GPS Picked for the Structure",title="Cartographic GPS Coordinates") %>%
      addResetMapButton() %>%
      addSearchFeatures(
        targetGroups  = "kenya.polys2",
        options = searchFeaturesOptions(zoom = 10, openPopup = TRUE,
                                        firstTipSubmit = TRUE, autoCollapse = FALSE, hideMarkerOnCollapse = TRUE))%>%
      addControl("<P><B>Hint!</B> Click on the Search button above.....<br/>
                 <li>Type the First 2 letters of the EA, e.g mu..</li></P>",
                 position = "topleft")
  })
#------------------------------------------------------------------------------------------------------------------------------------------>END  
  
}
shinyApp(ui = ui, server = server)


