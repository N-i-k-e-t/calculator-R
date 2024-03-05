library(shiny)
library(ggplot2)

server <- function(input, output) {
    dataset <- reactive({
    req(input$file) # Ensure file is uploaded
    read.csv(input$file$datapath)
    })

    output$xcol <- reactive({ names(dataset()) }) 
    output$ycol <- reactive({ names(dataset()) })

    output$dataPlot <- renderPlot({
    req(input$xcol, input$ycol)  # Ensure variables are selected
    ggplot(dataset(), aes(x = input$xcol, y = input$ycol)) + geom_point()
    })
}

shinyApp(ui = ui, server = server)
