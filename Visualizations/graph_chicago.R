#install.packages(c("rgeos", "rgdal", "ggplot2", "ggmap))
library(rgdal)
library(ggplot2)
library(ggmap)

#SET WD TO UNZIPPED SHAPEFILES

##Read in shapefile
overlay <- readOGR(".")

#Allow to merge with other things
overlay <- fortify(overlay, region="area_numbe") 
#asfd <- merge(overlay, temp, by.x='id', by.y="CN")

#Map chicago with shapefile layed over it
gmap <- get_map("chicago")
gg <- ggmap(gmap)
gg <- gg + geom_polygon(data=overlay, aes(x=long, y=lat, group=group), color="red", alpha=0)
gg <- gg + coord_map()
gg 

#Just map communities
hi <- ggplot() + geom_polygon(data=overlay,aes(x=long, y=lat, group=group), color="black", fill=NA) + coord_map()
hi


# #Filled polygons ex.
# ggplot() + geom_polygon(data=asfd,aes(x=long, y=lat, group=group,
#           fill=log(Taxi_rides)), color="black") + coord_map()
# ggplot() + geom_polygon(data=asdf,aes(x=long, y=lat, group=group,
#   fill=log(Taxi_drops)), color="black") + coord_map()


# #GRAPHING WITH ARROWS
# library(igraph)
# 
# overlay <- readOGR(".")
# #Make lat/long gridded
# overlay <- spTransform(overlay, CRS("+proj=longlat +datum=WGS84"))
# #Get midpts (ordered by area #)
# midpts <- coordinates(overlay[order(as.numeric(as.character(
#     overlay$area_numbe))),])

##USED A PRE-LOADED TABLE OF PICKUP/DROPOFF
# load("~/Kaggle/Chicago Map/data_2013.RData")
# arrows2 <- arrows
##ONLY KEEP TOP 2
# for(i in 1:77) {
#   temp <- names(tail(sort(arrows2[i,]),2))
#   arrows2[i,-as.numeric(temp)] <- 0
# }
# ggwp <- graph_from_adjacency_matrix(arrows2, mode="directed", weighted=T)
#plot(ggwp, layout=midpts, vertex.size=2, edge.arrow.size=0.5)
