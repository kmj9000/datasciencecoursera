library(shiny)

shinyUI(
  fluidPage(
    theme = "bootstrap.css",
    pageWithSidebar(                
      headerPanel("Fuel consumption?"),
      sidebarPanel(
        h4('Select the cylinders & horse power'),
        h3("Enter the data"),
        radioButtons("am",
                     "Transmission Type",
                     c("Automatic" = "0","Manual" = "1")
                     ),
        radioButtons("cyl", "Cylinders:",
                     c("4" = "4","6" = "6","8" = "8")
                     ),
        numericInput('horse',
                     'Horse power (70 - 250): ',
                     100, min = 70, max = 250, step = 10)
        ),
      mainPanel(h4("Summary measures for Miles/Gallon"),
                verbatimTextOutput("mpgId")
                )
      )
    )
  )