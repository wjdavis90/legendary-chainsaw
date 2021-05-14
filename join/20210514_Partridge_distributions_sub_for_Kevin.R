#Load libaries
library(tidyverse)
library(janitor)
library(lubridate)
library(collapse)
library(RColorBrewer)
library(patchwork)
library(maps)
library(ggspatial)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(CoordinateCleaner)
library(alphahull)
library(sp)
library(igraph)
library(rangemap)
library(rgdal)
library(maptools)
#library(plyr); library(dplyr)


#Shape files were read into R and converted into a form readable by ggplot
#following this [tutorial](https://github.com/tidyverse/ggplot2/wiki/plotting-polygon-shapefiles).
#The join() in this tutorial is from plyr(). The join() from dplyr() does not work. 

Perdix_hodgsoniae_shape <-readOGR(dsn=".", layer="Perdix_hodgsoniae_hull")

Perdix_hodgsoniae_shape@data$id = rownames(Perdix_hodgsoniae_shape@data)

Perdix_hodgsoniae_points = fortify(Perdix_hodgsoniae_shape, region="id")

Perdix_hodgsoniae_df <-join(Perdix_hodgsoniae_points,
					Perdix_hodgsoniae_shape@data,
					by="id")

Perdix_perdix_shape <-readOGR(dsn=".", layer="Perdix_perdix_hull")

Perdix_perdix_shape@data$id = rownames(Perdix_perdix_shape@data)

Perdix_perdix_points = fortify(Perdix_perdix_shape, region="id")

Perdix_perdix_df <-join(Perdix_perdix_points,
					Perdix_perdix_shape@data,
					by="id")

Perdix_dauurica_shape <-readOGR(dsn=".", layer="Perdix_dauurica_hull")

Perdix_dauurica_shape@data$id = rownames(Perdix_dauurica_shape@data)

Perdix_dauurica_points = fortify(Perdix_dauurica_shape, region="id")

Perdix_dauurica_df <-join(Perdix_dauurica_points,
					Perdix_dauurica_shape@data,
					by="id")


#ggplot(Perdix_hodgsoniae_df) +
#aes(long,lat,group=group) +
#geom_polygon() 
