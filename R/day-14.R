#Yan Wang
#08/26/2020
#Daily Exercise 14: My First Function

library(tidyverse)
library(USAboundaries)
library(sf)
library(rmapshaper)
library(readr)
library(USAboundariesData)

cities = readr::read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  st_transform(5070)

get_conus = function(data, var){
  filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
}

states = st_transform(us_counties(), 5070) %>%
  get_conus("state_name")

point_in_polygon3 = function(points, polygon, id){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(.data[[id]]) %>%
    setNames(c(id, "n")) %>%
    left_join(polygon, by = id) %>%
    st_as_sf()
}

plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2) +
    scale_fill_gradient(low = "white", high = "darkgreen") +
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(face = "bold", color = "darkgreen", hjust = .5, size = 18)) +
    labs(title = "Number of Cities",
         caption = paste0(sum(data$n), " locations represented"))
}

point_in_polygon3(cities, states, "geoid") %>%
  plot_pip() %>%
  ggsave(path = "img", filename = "D14.jpg")
