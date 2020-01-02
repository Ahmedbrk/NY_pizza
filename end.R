Sys.setenv(LANG = "en")
#Load packages
library(leaflet)
library(tidyverse)
library(ggmap)
library(leaflet.extras)
library(RColorBrewer)
library(htmltools)
library(leaflet.providers)
#Access data
df <- read_csv("pizza_barstool.csv")  

#Viewing the Data
str(df)
view(df)
glimpse(df)

#Cleaning the Data
df$price_level <- as.character(df$price_level)

df$price_level <- str_replace(df$price_level,"0","Unknown")
df$price_level <-        str_replace(df$price_level,"1","Cheap")
df$price_level <-        str_replace(df$price_level,"2","Normal") 
df$price_level <-        str_replace(df$price_level,"3","Expensive") 

df$price_level <- factor(df$price_level , levels=c("Unknown","Cheap","Normal","Expensive"))

df_newyork <- df %>%
              filter(city =="New York")

#DataViz
leaflet(data = df_newyork) %>% 
        addProviderTiles("CartoDB.DarkMatter")%>%
        addCircleMarkers(radius = 0.5,opacity =1, label = ~htmlEscape(name),color = ~pal(price_level)) %>%
        addLegend(pal = pal, 
                  values =  ~price_level,
                  title = "Price", position = "topright") 

#Add color palette
pal <- colorFactor(palette ="viridis",domain = df$price_level)