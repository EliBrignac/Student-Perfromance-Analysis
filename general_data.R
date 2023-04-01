
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes,
                 ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny,
                 stringr, tidyr)


#runExample("01_hello")




# Load the dataset

exams <- read.csv("Eli-app\\data\\exams.csv")
# head(exams)
# plot(exams)

exams <- exams %>%
  rename(ethnicity = race.ethnicity, 
         math_score = math.score,
         reading_score = reading.score,
         writing_score = writing.score,
         test_prep = test.preparation.course,
         parent_edu = parental.level.of.education) %>%
  
  mutate(total_score = math_score + reading_score + writing_score)
  
  
head(exams)


par(mfrow=c(1,3))
#Histogram of the math scores agianst a normal distribution
hist(exams$math_score, 
     freq = FALSE,
     breaks = 14,
     col = "#AA96DA",
     main = "Histogram of Math Scores",
     xlab = "Math Score", 
     ylab = "Density (area under the curve)")
curve(dnorm(x, mean = mean(exams$math_score), sd = sd(exams$math_score)), 
      add = TRUE, 
      col = "black", 
      lwd = 2)

#You can see that the data is approxiamtely normal, as the histogram 
#approximates the normal curve of the data


#Histogram of the reading scores agianst a normal distribution
hist(exams$reading_score, 
     freq = FALSE,
     breaks = 14,
     col = "#C5FAD5",
     main = "Histogram of Reading Scores",
     xlab = "Reading Score", 
     ylab = "Density (area under the curve)")
curve(dnorm(x, mean = mean(exams$reading_score), sd = sd(exams$reading_score)), 
      add = TRUE, 
      col = "black", 
      lwd = 2)

#Histogram of the writing scores agianst a normal distribution
hist(exams$writing_score, 
     freq = FALSE,
     breaks = 14,
     col = "#FFFFD2",
     main = "Histogram of Writing Scores",
     xlab = "Writing Score", 
     ylab = "Density (area under the curve)")
curve(dnorm(x, mean = mean(exams$writing_score), sd = sd(exams$writing_score)), 
      add = TRUE, 
      col = "black", 
      lwd = 2)

#set the dimentions thing back to normal
par(mfrow=c(1,1))

#Show linear relationship
plot(exams$reading_score, exams$writing_score,
     xlab = "Reading Score",
     ylab = "Writing Score",
     main = "Correlation between Reading and Writing Scores")
abline(lm(exams$writing_score ~ exams$reading_score),
       col = "red",
       lwd = 2,
       )


# Create a boxplot of genders and math.score
boxplot(exams$total_score ~ exams$gender, 
        data = exams, 
        main = "Boxplot of Math Scores by Gender", 
        xlab = "Gender", 
        ylab = "Total Score",
        outline = TRUE, #Set to false to remove the outlires
        col = c("pink", "lightblue")
        )

boxplot(exams$total_score ~ exams$ethnicity, 
        data = exams, 
        main = "Total Scores by Ethnicity", 
        xlab = "Gender", 
        ylab = "Total Score",
        outline = TRUE, #Set to false to remove the outlires
        col = c("#C5E8B7", "#ABE098", "#83D475","#57C84D", "#2EB62C")
        )

all_females <- exams %>% subset(gender == "female")
all_males <- exams %>% subset(gender == "male")



boxplot(all_males$total_score ~ all_males$ethnicity, 
        data = exams, 
        main = "Male Total Scores vs ethnicity", 
        xlab = "Ethnicity", 
        ylab = "Total Score",
        outline = TRUE, #Set to false to remove the outlires
        col = c("#fdfefb", "#d6effa", "#9bd0ff","#0074f1", "#0056a8")
)

boxplot(all_females$total_score ~ all_females$ethnicity, 
        data = exams, 
        main = "Female Total Scores vs ethnicity", 
        xlab = "Ethnicity", 
        ylab = "Total Score",
        outline = TRUE, #Set to false to remove the outlires
        col = c("#ffe1e1", "#ffc3c3", "#F9A3CB","#EF87BE", "#E56AB3")
)

schooling <- list("some college", "high school", "some high school")
data <- exams[exams$parent_edu %in% schooling,]


ggplot(data, aes(x = math_score, y = reading_score, color = parent_edu, shape = test_prep)) + 
  geom_point() +
  labs(x = "Math Score", y = "English Score", color = "Parent Education")




# # Load the necessary packages
# library(ggplot2)
# 
# # Load the dataset
# exams <- read.csv("Eli-app\\data\\exams.csv")
# # Plot a histogram of the math scores
# ggplot(exams, aes(x = math.score)) +
#   geom_histogram(aes(y = ..density..), bins = 30, color = "black", fill = "lightblue") +
#   labs(title = "Histogram of Math Scores", x = "Math Score", y = "Density")
# 
# # Add a normal density curve to the plot
# ggplot(exams, aes(x = math.score)) +
#   geom_histogram(aes(y = ..density..), bins = 30, color = "black", fill = "lightblue") +
#   stat_function(fun = dnorm, args = list(mean = mean(exams$math.score), sd = sd(exams$math.score)), color = "red", size = 1) +
#   labs(title = "Histogram of Math Scores with Normal Density Curve", x = "Math Score", y = "Density")

