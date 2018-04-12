library(rgdal)
library(ggplot2)

overlay <- readOGR(".")


midpts <- coordinates(overlay[order(as.numeric(as.character(
     overlay$area_numbe))),])
midpts <- as.data.frame(midpts)

map.p <- ggplot(midpts, aes(x=midpts[,1], y=midpts[,2])) + geom_point()

#MAY NEED TO PLAY WITH SIZE=PWEIGHT^2*6 depending on proportions
show_map <- function(ttext, pweight=0.5) {
  startpt <- as.numeric(strsplit(ttext, "-")[[1]][1])
  endpt <- as.numeric(strsplit(ttext, "-")[[1]][2])
  geom_segment(aes_string(x=midpts[startpt,1],
      y=midpts[startpt,2],xend=midpts[endpt,1],yend=midpts[endpt,2]),
      arrow=arrow(), size=pweight^2*6)
}
#Example
map.p + show_map("77-8") + show_map("76-8") + show_map("76-10",0.4)