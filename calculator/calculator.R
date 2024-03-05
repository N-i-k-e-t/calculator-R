library(shiny)

# Define UI
ui <- fluidPage(
    titlePanel("Simple Calculator"),
    sidebarLayout(
        sidebarPanel(
            numericInput("num1", "Enter first number:", value = 0),
            numericInput("num2", "Enter second number:", value = 0),
            selectInput("operator", "Choose operation:",
                choices = c(
                    "Addition" = "+",
                    "Subtraction" = "-",
                    "Multiplication" = "*",
                    "Division" = "/"
                )
            ),
            actionButton("calculate", "Calculate")
        ),
        mainPanel(
            textOutput("result")
        )
    )
)

# Define server logic
server <- function(input, output) {
    output$result <- renderText({
        # Handle division by zero
        if (input$operator == "/" && input$num2 == 0) {
            return("Division by zero is not allowed")
        }

        # Perform the calculation
        switch(input$operator,
            "+" = input$num1 + input$num2,
            "-" = input$num1 - input$num2,
            "*" = input$num1 * input$num2,
            "/" = input$num1 / input$num2
        )
    })
}

# Run the app
shinyApp(ui = ui, server = server)
