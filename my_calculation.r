# Load the Shiny library
library(shiny)

# Define the user interface (UI)
ui <- fluidPage(
  sliderInput("slider1", "Slider 1:", min = 0, max = 100, value = 50),
  sliderInput("slider2", "Slider 2:", min = 0, max = 100, value = 50),
  sliderInput("slider3", "Slider 3:", min = 0, max = 100, value = 50),
  sliderInput("slider4", "Slider 4:", min = 0, max = 100, value = 50),
  textOutput("result")
)

# Define the server logic
server <- function(input, output, session) {
  result <- reactive({
    sum(input$slider1, input$slider2, input$slider3, input$slider4)
  })

  output$result <- renderText({
    paste("Sum:", result())
  })

  # Send the result back to the HTML page
  observe({
    session$sendCustomMessage(type = "updateResult", message = result())
  })
}

# Create a Shiny app
shinyApp(ui = ui, server = server)