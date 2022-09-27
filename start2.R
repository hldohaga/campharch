library(sf)
library(raster)
library(spData)
library(spDataLarge)
library(SpatialEpi)
library(ggplot2)
names(world)
plot(world)
summary(world["lifeExp"])

demo(sp)
data(scotland)
data <- scotland$data
scotland.map <- scotland$spatial.polygon
SMR <- data$cases/data$expected
mapvariable(SMR,scotland.map)
plot(scotland)
scotland
scotland["data"]

ggplot(NYleukemia_sf) + 
  geom_sf(aes(fill= population)) + 
  scale_fill_gradient(low = "white", high = "red")

NYleukemia_sf

