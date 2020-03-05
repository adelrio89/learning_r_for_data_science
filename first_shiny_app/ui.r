#**************************************************************************
#                  First Shiny Application
#          R for Everyone Book - Jared P. Lander
#**************************************************************************

library(shinydashboard)

dashHeader <- dashboardHeader(title='Simple Dashboard')

dashSidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem('Home',
            tabName = 'HomeTab',
            icon = icon('dashboard')
    ),
    menuItem('Graphs',
             tabName = 'GraphsTab',
             icon = icon('bar-chart-o')
    )
  )
  
)

dashBody <- dashboardBody(
  tabItems(
    tabItem(tabName = 'HomeTab',
      h1('Landing Page!'),
      p('This is the landing page for the dashboard'),
      em('This text is emphasized')
    ),
    tabItem(tabName = 'GraphsTab',
      h1('Graphs!'),
      selectInput(inputId='VarToPlot',
                  label = 'Choose a Variable',
                  choices = c('carat','depth',
                              'table','price'),
                  selected = 'price'),
      plotOutput(outputId='HistPlot')
      
    )
    
  )
  
)

dashboardPage(
  header=dashHeader,
  sidebar=dashSidebar,
  body=dashBody,
  title='Example Dashboard'
)