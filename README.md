# Student-Perfromance-Analysis
(This is just an image)
<img width="960" alt="PictureOfApp" src="https://user-images.githubusercontent.com/94129362/229425187-6e3d7305-2651-4d96-947b-ab76c0ffb981.png">

##  ✨ How to Run App ✨
To run the app I made using shiny, run these lines of code in your favorite R compiler IDE and it will pull up a pop-up window in your current browser. In order to run this, you need to make sure you have the correct packages installed (shiny, tidyr, dplyr, ggplot2). You can install the correct versions of these packages by running the following line of code in your R IDE. If you already have these packages installed, it is still worth running this line to make sure all your packages are up to date.
```
install.packages(c("shiny", "dplyr", "tidyr", "ggplot2"))
```

Once the packages are installed, you can run the following lines to run the shiny app.
```
library(shiny) #import shiny library
runGitHub("StudentPerfromanceAnalysis", "EliBrignac") #run my app
```


### The General Data
I got this data set from kaggle.com and it can be found at this [LINK](https://www.kaggle.com/datasets/rkiattisak/student-performance-in-mathematics) 
#### Here are the graphs that the general_analysis file makes, I just made them because it was fun and interesting



![NormalPlots](https://user-images.githubusercontent.com/94129362/229267996-06ae047c-2eaf-4b83-97d4-acf1819aa58d.png)

The figure above shows that the scores for math, english, and writing are approximately normal meaning we can confidently conduct
certain tests (such as the chi-squared test). The histogram with 14 bins fits the normal curve with the data's mean = µ and standard deviation =	σ.



![RWCorrelation](https://user-images.githubusercontent.com/94129362/229268011-3e2b6c77-9c4c-4d8e-9153-2401607380e9.png)

The figure above shows that there is a strong linear correlation between the reading score and the writing score of a student. 
We could further display this strong corrolation by plotting the residuals, however I didn't think this was necessary. But if we 
were to plot the residuals, we would expect the points to be "randomly" spread out across the graph with most of the points falling close
to the x-axis (x-axis is where the residual is 0).

![GenderBoxplot](https://user-images.githubusercontent.com/94129362/229268007-0a522763-b6ea-49f7-970b-48e1d1ba9e57.png)

The figure above is a boxplot comparing the total scores (sum of math, reading, and writing scores) of females and males.
We can see that there is no significant differences here, infact they are almost exactly the same.

![EthnicityBoxPlot1](https://user-images.githubusercontent.com/94129362/229268012-1c34de8f-91b3-461f-acc9-da35f17dc6c9.png)

The figure above is a boxplot comparing the total scores of each ethnicity group in the study. Each ethnicity group was kept anonymous
in this dataset. The quadrents of every bar overlap with each other showing that there isn't much difference between the ethnicities 
and their scores. One thing that is kinda interesting, is that there are much more outlires in group C than in any other group. However, 
this isn't that important because they are outlires and would likely be discarded anyway.

