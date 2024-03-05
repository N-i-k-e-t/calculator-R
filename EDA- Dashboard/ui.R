library(shiny)

ui <- fluidPage(
    titlePanel("Exploratory Data Analysis Dashboard"),

    sidebarLayout(
    sidebarPanel(
        fileInput("file", "Upload Dataset (CSV)", accept = ".csv"),
        selectInput("xcol", "X Variable:", choices = NULL),
        selectInput("ycol", "Y Variable:", choices = NULL)
    ),

    mainPanel(
        plotOutput("dataPlot")
    )
    )
)
