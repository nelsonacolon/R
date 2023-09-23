 install.packages("tidyverse")
install.packages("dplyr")
library(tidyverse)
library(dplyr)
library(ggplot2)

name <- c('Nelson', 'Liliam', 'Gabriel', 'Wenceslao')
wt <- c(220, 140, 50, 130)
ht <- c(71, 61, 40, 63)

df <- data.frame(name, wt, ht)

df <- mutate(df, BMI = wt / ht ** 2 * 703)

df <- df %>% 
        mutate (status = ifelse (BMI < 18.5, "Underweight",
                         ifelse (BMI >= 18.5 & BMI < 25, "Normal weight",
                         ifelse (BMI >= 25 & BMI < 30, "Overweight", "Obese"))))

summary(df)

# bar chart
ggplot(df, aes(x=name, y=BMI)) +
  geom_bar(stat="identity", fill="#007FFF") +
  geom_text(aes(label=status), vjust=1.5, color ="white")+
  labs(title='BMI', x="Person",y="BMI")


# combo chart - bar and line
# ggp <- ggplot (df) +
#           geom_bar(aes(name, wt), stat="identity") +
#           geom_line(aes(name, bmi*max(wt),group=1 ),color="black", lwd=3) +
#     #      labs(title='weight vs bmi',x="person",y="weight (in lbs)") +
#           scale_y_continuous(sec.axis=sec_axis(~ . /max(df$wt)))
# ggp
