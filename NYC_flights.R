install.packages("nycflights13")
install.packages(tidyverse)
library("tidyverse")
library("nycflights13")

head(flights)
view(flights)

df <- flights %>% 
        filter(carrier=="UA", origin=="EWR", dest=="ORD", month=="1", day=="1")

df_merge <- merge(x=df,y=planes,by="tailnum",all.x=TRUE)

df_merge <- df_merge %>% 
              rename(year=year.x, year_built=year.y)

view(planes)