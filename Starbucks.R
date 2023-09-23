install.packages("tidyverse")
library(tidyverse)

getwd()
setwd("C:/Users/Public/Documents/Documents/R Source Files")

sb <- read.csv("Starbucks-FY23-Q1-Store-Counts-by-Market.csv")

head (sb)

sb <- sb %>% 
        rename (Country=ï..Country, 
        Store_Type=Store.Type, 
        Store_Count=Store.Count)

install.packages("janitor")
library(janitor)

sb <- sb %>% 
        clean_names()

View(sb)

sb <- sb %>% 
        mutate (country = 
                  ifelse(country == 'Puerto Rico2' , 'Puerto Rico',
                       ifelse (country == 'UAE - Dubai', 'United Arab Emirates', country)  
                        )
                )

sb <- sb %>% 
  mutate (year= 
            ifelse(grepl("23", quarter) , '2023',
                   ifelse (grepl("22", quarter), '2022', 
                        ifelse (grepl("21", quarter), '2021', '2020')   
                           )  
            
                  )
          )

sb$store_count <- as.numeric(as.character(sb$store_count))

install.packages("ggplot2")
library(ggplot2)

sb %>%
  filter(str_detect(quarter,'Q4')) %>% 
  ggplot(aes(x=year, y=store_count)) +
    geom_bar(stat="identity", fill="#007FFF") +
    facet_wrap(~segment)

summary(sb_2)

sb_2 <- sb %>% 
          filter (quarter == 'Q4 FY21')

sb_2 <- sb %>%
            rename (country_name=country)

OECD_facts <- read.csv("OECD_GDP.csv")
  
OECD_facts <- OECD_facts %>% 
                select (ï..Country.Name,Country.Code,X2021) %>% 
                rename (country_name = ï..Country.Name,country_code=Country.Code,GDP=X2021)

#OECD_facts$GDP <- as.numeric(as.character(OECD_facts$GDP))               
summary (OECD_facts)

options(scipen = 999)

OECD_map <- read.csv("OECD_GDP_Metadata.csv")

summary(OECD_map)


OECD_map <- OECD_map %>% 
              filter(Region != '') %>% 
              select(ï..Country.Code,IncomeGroup,TableName) %>% 
              rename(country_code=ï..Country.Code,income_group=IncomeGroup,country=TableName)  
              
OECD_merge <- merge(x=OECD_facts,y=OECD_map,by='country_code')

OECD_merge <- OECD_merge %>% 
                select (-country)

Final <- merge(x=sb_2,y=OECD_merge,by="country_name")

summary(Final)

Final <- Final %>% 
          filter (quarter == 'Q4 FY21')

Final %>% 
  ggplot(aes(x=store_count, y=GDP)) + 
  geom_point()