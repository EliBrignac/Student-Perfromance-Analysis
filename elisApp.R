

pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes,
                 ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny,
                 stringr, tidyr) 

exams <- read.csv("Eli-app\\data\\exams.csv")
exams <- exams %>%
  rename(ethnicity = race.ethnicity, 
         math_score = math.score,
         reading_score = reading.score,
         writing_score = writing.score,
         test_prep = test.preparation.course,
         parent_edu = parental.level.of.education) %>%
  
  mutate(total_score = math_score + reading_score + writing_score,
         english_score = reading_score + writing_score)


head(exams)

  
ui <- fluidPage(
  titlePanel("Test Results of Students"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("edu", "Parents Education",
                         choices = list("high school" = "high school",
                                        "some high school" = "some high school",
                                        "some college" = "some college",
                                        "associate's degree" = "associate's degree",
                                        "bachelor's degree" = "bachelor's degree",
                                        "master's degree" = "master's degree"),
                         selected = "high school"),
      checkboxGroupInput("prep", "Type of Test Preparation",
                         choices = list("No Preparation" = "none",
                                        "Completed Preparation" = "completed"),
                         selected = "none")
    ),
    mainPanel(
      plotOutput("scatter_plot"),
      h5("Graph Description"),
      span("The graph above is the results of the students test plotted against 
           the education of their parents and if they had test preparation.")
      
    )
  )
)

server <- function(input, output) {
  
  # Generate random data for the scatter plot
  data <- reactive({
    d <- exams %>% filter(test_prep %in% input$prep & parent_edu %in% input$edu)
    print(d)
    
    # x <- rnorm(input$n_points)
    # # y <- rnorm(input$n_points)
    # data.frame(x = x, y = y)
  })
  
  # Render the scatter plot
  output$scatter_plot <- renderPlot({
    
    ggplot(data(), aes(x = math_score, y = english_score, color = parent_edu, shape = test_prep)) + 
      geom_point() +
      labs(x = "Math Score", y = "English Score", color = "Parent Education")
    
    #plot(data()$x, data()$y, col = input$color)
  })
  
}

shinyApp(ui = ui, server = server)



