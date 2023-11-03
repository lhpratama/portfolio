library(shiny)
library(shinydashboard)
library(shinyWidgets)

dashboardPage(
  
  skin = "black",
  # --- header ---
  dashboardHeader(title = "US Police Shooting Analysis"),
  
  # --- sidebar ---
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("dashboard")),
      menuItem("Base Analysis", tabName = "page2", icon = icon("chart-area")),
      menuItem("Shootings Based on Race", tabName = "page3", icon = icon("users")),
      menuItem("Database", tabName = "page4", icon = icon("database"))
    )
  ),
  
  # --- body ---
  dashboardBody(
    tabItems(
      ## --- page 1 ---
      tabItem(
        tabName = "page1",
        fluidRow(
          HTML("<h2>US Police Shootings from 2015- Sep 2022</h2>
               <p>Below are lists of people killed by law enforcement in the United States, both on duty and off duty. Although Congress instructed the Attorney General in 1994 to compile and publish annual statistics on police use of excessive force, this was never carried out, and the Federal Bureau of Investigation does not collect these data.</p>
               <p>ID = Serial Number</p>
               <p>Name = Name of Victims</p>
               <p>Manner of Death = Type of manner in which the victim died</p>
               <p>Armed = Whether the victim was armed or not</p>
               <p>Age = Age of the victim</p>
               <p>Gender = Gender of the victim</p>
               <p>Race = Race or ethnicity of the victim</p>
               <p>Threat Level = Level of threat to the police</p>
               <p>Longitude = Longitude of location</p>
               <p>Latitude = Latitude of location</p>
               <p>Source : <a href='https://www.kaggle.com/datasets/ramjasmaurya/us-police-shootings-from-20152022' target='_blank'>Kaggle Dataset</a></p>")
        )
      ),
      
      ## --- page 2 ---
      tabItem(
        tabName = "page2",
        ## --- page 2: row 1 ----
        fluidRow(
          infoBox(
            width = 6,
            title = "Total Shootings",
            color = "black",
            icon = icon("bullseye"),
            value = nrow(police)
          ),
          infoBox(
            width = 6,
            title = "Unique Cities",
            color = "black",
            icon = icon("building"),
            value = length(unique(police$city))
          ),
          infoBox(
            width = 6,
            title = "City with Most Shootings",
            color = "black",
            icon = icon("map-marker"),
            value = names(sort(table(police$city), decreasing = TRUE)[1])
          ),
          infoBox(
            width = 6,
            title = "State with Most Shootings",
            color = "black",
            icon = icon("flag"),
            value = names(sort(table(police$state), decreasing = TRUE)[1])
          )
        ),
        ## --- page 2: row 2 ----
        fluidRow(
          selectInput(
            inputId = "input_state",
            label = "Choose a state",
            choices = unique(police$state)
          )
        ),
        ## --- page 2: row 3 ----
        fluidRow(
          box(
            width = 6,
            plotlyOutput("plot1_state")
          ),
          box(
            width = 6,
            plotlyOutput("plot2_age")
          )
        )
      ),
      
      ## --- page 3 ---
      tabItem(
        tabName = "page3",
        ## --- page 3: row 1 ----
        fluidRow(
          infoBox(
            width = 6,
            title = "Ethnicity with Most Victims",
            color = "black",
            icon = icon("users"),
            value = names(sort(table(police$race), decreasing = TRUE)[1])
          )
        ),
        ## --- page 3: row 2 ----
        fluidRow(
          selectInput(
            inputId = "input_race",
            label = "Choose an ethnicity",
            choices = unique(police$race)
          ),
          uiOutput("infoBox_page3")
        ),
        ## --- page 3: row 3 ----
        fluidRow(
          box(
            width = 6,
            plotlyOutput("plot4_armed")
          ),
          box(
            width = 6,
            plotlyOutput("plot3_death")
          )
        ),
        ## --- page 3: row 4 ----
        fluidRow(
          box(
            width = 6,
            plotlyOutput("plot5_gender")
          ),
          box(
            width = 6,
            plotlyOutput("plot6_threat")
          )
        )
      ),
      
      ## --- page 4 ---
      tabItem(
        tabName = "page4",
        fluidRow(
          box(
            width = 12,
            DTOutput("policeTable")
          )
        )
      )
    )
  )
)
