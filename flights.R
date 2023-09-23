install.packages("tidyverse")
install.packages("dplyr")
install.packages("lessR")
install.packages("ggplot2")
library(tidyverse)
library(dplyr)
library(lessR)
library(ggplot2)

# Obtain current working directory
getwd()

# Set working directory -- to be used to load CSV source files
setwd("C:/Users/Public/Documents/Documents/R Source Files")

flights <- read.csv('flights.csv')
flights$year <- as.character(flights$year)
summary(flights)

# aggregate function () -- similar to a pivot table
#aggregate(flights$passengers, by=list(flights$year), FUN=sum)
flights_aggr <- aggregate(passengers ~ year, flights, sum)
print(flights_aggr)

# pivot() function
pivot(flights, sum, passengers, year, na_remove=TRUE)


# Create heatmap with ggplot2
#ggp <- ggplot(flights, aes(year, month)) +                           
#  geom_tile(aes(fill = passengers)) 

ggp <- ggplot(flights, aes(year, month, fill = passengers)) +                           
         geom_tile() +
         scale_fill_gradient(low = "white", high = "#007FFF") +
         geom_text(aes(label=passengers))

ggp

# Manual colors of heatmap
ggp + scale_fill_gradient(low = "white", high = "#007FFF")

# Clear console
cat("\014")