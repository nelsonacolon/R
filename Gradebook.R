install.packages("tidyverse")
# install.packages("dplyr")
# install.packages("ggplot2")
library(tidyverse)
# library(dplyr)
# library(ggplot2)

section <- c("MATH111","MATH111","ENG111","HIST121")
grade <- c(78,93,56, 96)
student <- c("David","Kristina","Mycroft","Allison")
gradebook <- data.frame(section,grade,student)

mutate(gradebook, department = 
         ifelse(grepl("MATH", section), "Math",
         ifelse(grepl("ENG", section), "English", 
         ifelse(grepl("HIST", section), "History", "Other"))))

summary(gradebook)

gradebook %>% 
  summarize(average = mean(grade))

gradebook %>% 
  select(student, section, grade) %>% 
  filter(grade >= 65)




# grepl("MATH", gradebook$section)

gradebook %>% 
  ggplot(aes(x=section,y=grade)) +
  geom_bar(stat='identity')

gradebook %>% 
  ggplot(aes(x=section,y=grade)) +
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean",
           fill = "blue")
  
  