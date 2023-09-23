install.packages('httr')
library(httr)

# plug in your API key
myapikey <- "n41MV3lv0yw05WEnHxr0UCk1MXE9g0hLqxBx1Q3L"

# the url path to the service
URL <- "https://api.data.gov/ed/collegescorecard/v1/schools?"

get.data <- GET(URL, query=list(api_key=myapikey,
                                school.name="Western Governors University"))

# content(): extract the content from the query
WGU.data <- content(get.data)
class(WGU.data) # it's a list object

names(WGU.data)

names(WGU.data$results[[1]])