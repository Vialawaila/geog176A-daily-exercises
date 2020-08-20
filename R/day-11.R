#Yan Wang
#08/19/2020
#Daily Exercise 10: Feature Geometries

library(tidyverse)
library(sf)
library(units)


uscities <- read_csv("~/github/exercise-04/data/uscities.csv")
  filter(city %in% c("Santa Barbara", "San Francesco")) %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)

st_distance(uscities)
st_distance(st_transform(uscities, 5070))
st_distance(st_transform(uscities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))

st_distance(uscities) %>%
  units::set_units("km") %>%
  units::drop_units()
