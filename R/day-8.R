#Yan Wang
#08/19/2020
#Daily Exercise 10: Feature Geometries

library(tidyverse)
library(sf)
library(units)
library(USAboundaries)
library(rnaturalearth)
library(gghighlight)
library(ggrepel)
library(knitr)

conus = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))
length(st_geometry(conus))

us_c_ml = st_combine(conus) %>%
  st_cast("MULTILINESTRING")
plot(us_c_ml)

us_u_ml = st_union(conus) %>%
  st_cast("MULTILINESTRING")
plot(us_u_ml)
