library(maps)
library(mapdata)
library(ggplot2)
state<- map_data("state")
world<- map_data("world")

#scouts world
SCOUTSFULL<-read.csv("file:///C:/Users/Zane/Documents/Baseball/CBBSN/Analytics/Scout info 11-2-18.csv",header=TRUE,sep=',',strip.white=TRUE,na.strings="EMPTY")

#map of all CBBSN scouts including international
ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = SCOUTSFULL, aes(x = long_school_1, y = lat_school_1), color = SCOUTSFULL$Color2, size = SCOUTSFULL$Size, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Scouts")

#map of all CBBSN scouts colored by region
ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = SCOUTSFULL, aes(x = long_school_1, y = lat_school_1), color = SCOUTSFULL$Color, size = SCOUTSFULL$Size, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Scouts")

#just US scouts
usscouts <- subset(SCOUTSFULL, SCOUTSFULL$Size == 1)

#map of all US CBBSN scouts colored by region
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = usscouts, aes(x = long_school_1, y = lat_school_1), color = usscouts$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN US Coverage by Region")

Northeast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Northeast")
Southeast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Southeast")
Midwest <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Midwest")
Southwest <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Southwest")
WestCoast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "West Coast")

#Regions, colored by scouts

#Northeast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Northeast, aes(x = long_school_1, y = lat_school_1), color = Northeast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Northeast Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Southeast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Southeast, aes(x = long_school_1, y = lat_school_1), color = Southeast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Southeast Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Midwest
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Midwest, aes(x = long_school_1, y = lat_school_1), color = Midwest$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Midwest Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Southwest
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Southwest, aes(x = long_school_1, y = lat_school_1), color = Southwest$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Southwest Coverage") + guides(fill = guide_legend(reverse=TRUE))

#West Coast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = WestCoast, aes(x = long_school_1, y = lat_school_1), color = WestCoast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN West Coast Coverage") + guides(fill = guide_legend(reverse=TRUE))
