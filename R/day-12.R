#Yan Wang
#08/24/2020
#Daily Exercise 12: Spatial filtering

library(tidyverse)
library(USAboundaries)
library(sf)

california <- us_states() %>%
  filter(name == "California")
touchCalifornia = st_filter(states, california, .predicate = st_touches)

map <- ggplot() +
  geom_sf(data = states) +
  geom_sf(data = touchCalifornia, fill = "red") +
  labs(title = "Daily Exercise 12: Spatial filtering",
       x = "Longitude",
       y = "Latitude") +
  ggthemes::theme_map()

ggsave(path = "img", filename = "D12.jpg")
