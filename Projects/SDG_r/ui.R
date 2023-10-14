library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "SDG Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("info")),
      menuItem("SDG by Region", tabName = "page2", icon = icon("globe")),
      menuItem("World Map", tabName = "page3", icon = icon("map"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "page1",
        dashboardBody(
          box(title = "What is SDG?",
              div(
                tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/d/df/Sustainable_Development_Goals.png", width = "35%"),
                "The Sustainable Development Goals (SDGs), also known as the Global Goals, are a universal call to action to end poverty, protect the planet, and ensure prosperity for all. Adopted by all United Nations Member States in 2015 as part of the 2030 Agenda for Sustainable Development, these 17 interconnected goals address a wide range of global challenges and aim to create a more equitable, sustainable, and inclusive world by the year 2030."
              ), width = 6),
          ## --- page 1: row 1 ---
          fluidRow(
            infoBox(
              width = 5,
              title = "Number of countries recorded by the SDG Index Score",
              color = "blue",
              value = length(unique(index$country)),  # You need to define 'index' in your server
              icon = icon("globe")
            ),
            infoBox(
              width = 5,
              title = "Average Global Index Score",
              color = "blue",
              value = mean(report$overall_score),  # You need to define 'report' in your server
              icon = icon("chart-line")
            )
          ),
          ## --- page 1: row 2 ---
          fluidRow(
            box(
              width = 6,
              plotlyOutput("plot1_a")
            ),
            box(
              width = 6,
              plotlyOutput("plot4_a")
            )
          )
        )
      ),
      tabItem(
        tabName = "page2",
        dashboardBody(
          ## --- page 2: row 1 ----
          fluidRow(
            ### Input 1: Choose a Region
            box(
              width = 12,
              selectInput(
                inputId = "input_region",
                label = "Choose a Region",
                choices = unique(report$region)
              )
            )
          ),
          ## --- page 2: row 2 ---
          fluidRow(
            ### Plot 2: Lolipop (plot3_a)
            box(
              width = 12,
              plotlyOutput("plot3_a")
            )
          )
        )
      ),
      tabItem(
        tabName = "page3",
        dashboardBody(
          ## --- page 3: row 1 ---
          fluidRow(
            box(
              width = 12,
              h2("World Map"),
              plotlyOutput("plot5_a")
            )
          )
        )
      )
    )
  )
)

ui
