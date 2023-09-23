install.packages("tidyverse")
install.packages("reshape2")
install.packages("plyr")
install.packages("dplyr")
install.packages("janitor")
install.packages("lubridate")

library(tidyverse)
library(reshape2)
library(plyr)
library(dplyr)
library(janitor)
library(lubridate)

getwd()
setwd('C:/Users/Public/Documents/Documents/R Source Files/')

movies <- read.csv('Movie-Data.csv')

movies <- clean_names(movies)

movies <- movies %>% 
  select(movie_title,release_date,genre,budget,revenue)

summary (movies)

# sapply() function -- returns data type of each column of data frame
sapply(movies, class)


# Removing the '$' and ',' characters from each value 
# of the 'budget' and 'revenue' attributes
movies$budget <- gsub("[$,]", "", movies$budget)
movies$revenue <- gsub("[$,]", "", movies$revenue)

# Converting the data types of the 'budget' and 'revenue' attributes
# to numeric
movies <- transform(movies,budget = as.numeric(budget))
movies <- transform(movies,revenue = as.numeric(revenue))

# Converting the data type of the 'release_date' attribute
# to date in 'MM/DD/YYYY' format
movies$release_date <- mdy(movies$release_date)

# Creating a new attribute named 'release_year'
# This attribute is the release year of the movie, based on the 
# year in each value of the 'release_date' attribute
movies$release_year <- year(movies$release_date)
#movies$release_year <- as.character(movies$release_year)

# Creating a new attribute named 'release_month'
# This attribute is the release month of the movie, based on the 
# month in each value of the 'release_date' attribute
movies$release_month <- month(movies$release_date)
#movies$release_month <- as.character(movies$release_month)

# Producing a pivot table
movies_melt <- melt(movies, id=c("genre","release_year"), measure="revenue", value.name="revenue")
head(movies_melt)

movies_pivot <- dcast(movies_melt, genre~release_year, margins=TRUE, fun.aggregate = mean)
movies_pivot

movies_aggr <- aggregate(revenue ~ genre, movies, sum)
movies_aggr          