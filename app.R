

pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes,
                 ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny,
                 stringr, tidyr) 

exams <- read.csv("exams.csv")

exams <- exams %>%
  rename(ethnicity = race.ethnicity, 
         math_score = math.score,
         reading_score = reading.score,
         writing_score = writing.score,
         test_prep = test.preparation.course,
         parent_edu = parental.level.of.education) %>%
  
  mutate(total_score = math_score + reading_score + writing_score,
         english_score = reading_score + writing_score)
#head(exams)

  
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
      h3("Graph Description"),
      span("The graph above is student test results plotted with
           the education of their parents and thier amount of test preparation.
           The english score is calculated by combining the scores of the reading 
           and writing portions of the test. The link to this data set can be found "), 
      a(href = "https://www.kaggle.com/datasets/rkiattisak/student-performance-in-mathematics", "here.", target="_blank"),
      
      br(),
      span("More about me: "),
      a(href="https://github.com/EliBrignac", "GitHub", target = "_blank", align = "center"),
      span(" ❤️‍🔥 ", align = "right"),
      a(href="https://www.linkedin.com/in/eli-brignac/", "LinkedIn", target = "_blank", align = "right")
      
      )
  )
)

server <- function(input, output) {
  
  data <- reactive({
    d <- exams %>% filter(test_prep %in% input$prep & parent_edu %in% input$edu)
    #print(d)

  })
  
  output$scatter_plot <- renderPlot({
    
    ggplot(data(), aes(x = math_score, y = english_score, color = parent_edu, shape = test_prep)) + 
      geom_point() +
      labs(x = "Math Score", y = "English Score", color = "Parent Education")

  })
  
}

#Run the app 
shinyApp(ui = ui, server = server)



