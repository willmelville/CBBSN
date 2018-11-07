library(dplyr)

##### Regular fix ##### 
y <- subset(Position_Players, Position_Players$CONFERENCE == "Atlantic 10")
Position_Players$CONFERENCE <-
	ifelse(Position_Players$CONFERENCE == "American Southwestern Conference", Position_Players$CONFERENCE == "American Southwest Conference",
		  ifelse(Position_Players$CONFERENCE == "Atlantic 10"
		  	  , Position_Players$CONFERENCE == "Atlantic 10 Conference",
		  	  ifelse(Position_Players$CONFERENCE == "Atlantic Sun"
		  	  	  , Position_Players$CONFERENCE == "Atlantic Sun Conference",
		  	  	  ifelse(Position_Players$CONFERENCE == "Big-12"
		  	  	  	  , Position_Players$CONFERENCE == "Big 12",
		  	  	  	  ifelse(Position_Players$CONFERENCE == "Big East Conference"
		  	  	  	  	  , Position_Players$CONFERENCE == "Big East",
		  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Big South"
		  	  	  	  	  	  , Position_Players$CONFERENCE == "Big South Conference",
		  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "California Collegiatte Athletic Association" | Position_Players$CONFERENCE == "CCAA" 
		  	  	  	  	  	  	  , Position_Players$CONFERENCE == "California Collegiate Athletic Association",
		  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "CCCAA"
		  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "California Community College Athletic Association" ,
		  	  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Colonial Athletic Asssociation"
		  	  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "Colonial Athletic Association",
		  	  	  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Great Lake Intercollegiate Athletic Conference" | Position_Players$CONFERENCE == "Great Lakes Intercollegiate"
		  	  	  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "Great Lakes Intercollegiate Athletic Conference"),
		  	  	  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Great Midwest Atheletic Conference"
		  	  	  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "Great Midwest Athletic Conference",
		  	  	  	  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Heartland Conference"
		  	  	  	  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "Heartland Collegiate Athletic Conference",
		  	  	  	  	  	  	  	  	  	  	  ifelse(Position_Players$CONFERENCE == "Illnois N4C Conference")
		  	  	  	  	  	  	  	  	  	  	  , Position_Players$CONFERENCE == "Illinois N4C Conference",
		  	  	  	  	  	  	  	  	  	  	  
		  	  	  	  	  	  	  	  	  	  )))))))))))
Position_Players$CONFERENCE
# add this ^^ after comma of the final ifelse statement 
#(e.g.:
#ifelse(Position_Players$CONFERENCE == "Illnois N4C Conference"), Position_Players$CONFERENCE == "Illinois N4C Conference", Position_Players$CONFERENCE)



Position_Players[Position_Players == "American Southwestern Conference"] <- "American Southwest Conference"
Pitchers[Pitchers == "American Southwestern Conference"] <- "American Southwest Conference"

Position_Players[Position_Players == "Atlantic 10"] <- "Atlantic 10 Conference"
Pitchers[Pitchers == "Atlantic 10"] <- "Atlantic 10 Conference"

Position_Players[Position_Players == "Atlantic Sun"] <- "Atlantic Sun Conference"
Pitchers[Pitchers == "Atlantic Sun"] <- "Atlantic Sun Conference"

Position_Players[Position_Players == "Big-12"] <- "Big 12"
Pitchers[Pitchers == "Big-12"] <- "Big 12"

Position_Players[Position_Players == "Big East Conference"] <- "Big East"
Pitchers[Pitchers == "Big East Conference"] <- "Big East"

Position_Players[Position_Players == "Big South"] <- "Big South Conference"
Pitchers[Pitchers == "Big South"] <- "Big South Conference"

Position_Players[Position_Players == "California Collegiatte Athletic Association"] <- "California Collegiate Athletic Association"
Pitchers[Pitchers == "California Collegiatte Athletic Association"] <- "California Collegiate Athletic Association"

Position_Players[Position_Players == "CCAA"] <- "California Collegiate Athletic Association"
Pitchers[Pitchers == "CCAA"] <- "California Collegiate Athletic Association"


Position_Players[Position_Players == "CCCAA"] <- "California Community College Athletic Association"
Pitchers[Pitchers == "CCCAA"] <- "California Community College Athletic Association"

Position_Players[Position_Players == "Colonial Athletic Asssociation"] <- "Colonial Athletic Association"
Pitchers[Pitchers == "Colonial Athletic Asssociation"] <- "Colonial Athletic Association"

Position_Players[Position_Players == "Great Lake Intercollegiate Athletic Conference"] <- "Great Lakes Intercollegiate Athletic Conference"
Pitchers[Pitchers == "Great Lake Intercollegiate Athletic Conference"] <- "Great Lakes Intercollegiate Athletic Conference"

Position_Players[Position_Players == "Great Lakes Intercollegiate"] <- "Great Lakes Intercollegiate Athletic Conference"
Pitchers[Pitchers == "Great Lakes Intercollegiate"] <- "Great Lakes Intercollegiate Athletic Conference"

Position_Players[Position_Players == "Great Midwest Atheletic Conference"] <- "Great Midwest Athletic Conference"
Pitchers[Pitchers == "Great Midwest Atheletic Conference"] <- "Great Midwest Athletic Conference"

Position_Players[Position_Players == "Heartland Conference"] <- "Heartland Collegiate Athletic Conference"
Pitchers[Pitchers == "Heartland Conference"] <- "Heartland Collegiate Athletic Conference"

Position_Players[Position_Players == "Illnois N4C Conference"] <- "Illinois N4C Conference"
Pitchers[Pitchers == "Illnois N4C Conference"] <- "Illinois N4C Conference"

Position_Players[Position_Players == "Iowa Intercol. Athletic Conf."] <- "Iowa Intercollegiate Athletic Conference"
Pitchers[Pitchers == "Iowa Intercol. Athletic Conf."] <- "Iowa Intercollegiate Athletic Conference"

Position_Players[Position_Players == "Mid-American Conference"] <- "Mid American Conference"
Pitchers[Pitchers == "Mid-American Conference"] <- "Mid American Conference"

Position_Players[Position_Players == "Mid-American Confrence"] <- "Mid American Conference"
Pitchers[Pitchers == "Mid-American Confrence"] <- "Mid American Conference"

Position_Players[Position_Players == "MId-American Conference"] <- "Mid American Conference"
Pitchers[Pitchers == "MId-American Conference"] <- "Mid American Conference"

Position_Players[Position_Players == "Missouri Valley"] <- "Missouri Valley Conference"
Pitchers[Pitchers == "Missouri Valley"] <- "Missouri Valley Conference"

Position_Players[Position_Players == "Mountain West"] <- "Mountain West Conference"
Pitchers[Pitchers == "Mountain West"] <- "Mountain West Conference"

Position_Players[Position_Players == "Mountian West"] <- "Mountain West Conference"
Pitchers[Pitchers == "Mountian West"] <- "Mountain West Conference"

Position_Players[Position_Players == "NCCAA"] <- "National Christian College Athletic Association"
Pitchers[Pitchers == "NCCAA"] <- "National Christian College Athletic Association"

Position_Players[Position_Players == "NCCAA- West"] <- "National Christian College Athletic Association"
Pitchers[Pitchers == "NCCAA- West"] <- "National Christian College Athletic Association"

Position_Players[Position_Players == "Northeast-10"] <- "Northeast-10 Conference"
Pitchers[Pitchers == "Northeast-10"] <- "Northeast-10 Conference"

Position_Players[Position_Players == "Northern Athletics Collegiate Conference"] <- "Northern Athletic Collegiate Conference"
Pitchers[Pitchers == "Northern Athletics Collegiate Conference"] <- "Northern Athletic Collegiate Conference"

Position_Players[Position_Players == "Northwest Atlantic Confrence"] <- "Northwest Athletic Conference"
Pitchers[Pitchers == "Northwest Atlantic Confrence"] <- "Northwest Athletic Conference"

Position_Players[Position_Players == "Pac-12"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pac-12"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "PAC-12"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "PAC-12"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Pac 12"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pac 12"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Pac2"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pac2"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Pacific 12"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pacific 12"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Pacific 12 Confrence"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pacific 12 Confrence"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Pacific Coast"] <- "Pacific Coast Athletic Conference"
Pitchers[Pitchers == "Pacific Coast"] <- "Pacific Coast Athletic Conference"

Position_Players[Position_Players == "Pacific Coast Conference"] <- "Pacific Coast Athletic Conference"
Pitchers[Pitchers == "Pacific Coast Conference"] <- "Pacific Coast Athletic Conference"

Position_Players[Position_Players == "Pacific2 Conference"] <- "Pacific-12 Conference"
Pitchers[Pitchers == "Pacific2 Conference"] <- "Pacific-12 Conference"

Position_Players[Position_Players == "Peach Belt"] <- "Peach Belt Conference"
Pitchers[Pitchers == "Peach Belt"] <- "Peach Belt Conference"

Position_Players[Position_Players == "RMAC"] <- "Rocky Mountain Athletic Conference"
Pitchers[Pitchers == "RMAC"] <- "Rocky Mountain Athletic Conference"

Position_Players[Position_Players == "SCIAC"] <- "Southern California Intercollegiate Athletic Conference"
Pitchers[Pitchers == "SCIAC"] <- "Southern California Intercollegiate Athletic Conference"

Position_Players[Position_Players == "South Coast Conference-South"] <- "South Coast Conference"
Pitchers[Pitchers == "South Coast Conference-South"] <- "South Coast Conference"

Position_Players[Position_Players == "SEC"] <- "Southeastern Conference"
Pitchers[Pitchers == "SEC"] <- "Southeastern Conference"

Position_Players[Position_Players == "South Eastern Conference"] <- "Southeastern Conference"
Pitchers[Pitchers == "South Eastern Conference"] <- "Southeastern Conference"

Position_Players[Position_Players == "Southeastern"] <- "Southeastern Conference"
Pitchers[Pitchers == "Southeastern"] <- "Southeastern Conference"

Position_Players[Position_Players == "Southern California Intercoligate Athletic Conference"] <- "Southern California Intercollegiate Athletic Conference"
Pitchers[Pitchers == "Southern California Intercoligate Athletic Conference"] <- "Southern California Intercollegiate Athletic Conference"

Position_Players[Position_Players == "Southern"] <- "Southern Conference"
Pitchers[Pitchers == "Southern"] <- "Southern Conference"

Position_Players[Position_Players == "Southland"] <- "Southland Conference"
Pitchers[Pitchers == "Southland"] <- "Southland Conference"

Position_Players[Position_Players == "Southwestern Junior College Conference"] <- "Southwest Junior College Conference"
Pitchers[Pitchers == "Southwestern Junior College Conference"] <- "Southwest Junior College Conference"

Position_Players[Position_Players == "Soutland Conference"] <- "Southland Conference"
Pitchers[Pitchers == "Soutland Conference"] <- "Southland Conference"

Position_Players[Position_Players == "SWAC"] <- "Scenic West Athletic Conference"
Pitchers[Pitchers == "SWAC"] <- "Scenic West Athletic Conference"

Position_Players[Position_Players == "TCCAA"] <- "Tennessee Community College Athletic Association"
Pitchers[Pitchers == "TCCAA"] <- "Tennessee Community College Athletic Association"

Position_Players[Position_Players == "University Athletic Associaton"] <- "University Athletic Association"
Pitchers[Pitchers == "University Athletic Associaton"] <- "University Athletic Association"

Position_Players[Position_Players == "WCC"] <- "West Coast Conference"
Pitchers[Pitchers == "WCC"] <- "West Coast Conference"

Position_Players[Position_Players == "West Coast"] <- "West Coast Conference"
Pitchers[Pitchers == "West Coast"] <- "West Coast Conference"

Position_Players[Position_Players == "WAC"] <- "Western Athletic Conference"
Pitchers[Pitchers == "WAC"] <- "Western Athletic Conference"

Position_Players[Position_Players == "Wolverine Hoosier Athletic Conference"] <- "Wolverine-Hoosier Athletic Conference"
Pitchers[Pitchers == "Wolverine Hoosier Athletic Conference"] <- "Wolverine-Hoosier Athletic Conference"

Position_Players[Position_Players == "4A/5A Pike Peaks League"] <- "4A/5A Pikes Peak League"
Pitchers[Pitchers == "4A/5A Pike Peaks League"] <- "4A/5A Pikes Peak League"

Position_Players[Position_Players == "Atlantic Coastal Conference"] <- "Atlantic Coast Conference"
Pitchers[Pitchers == "Atlantic Coastal Conference"] <- "Atlantic Coast Conference"

Position_Players[Position_Players == "Big West"] <- "Big West Conference"
Pitchers[Pitchers == "Big West"] <- "Big West Conference"

Position_Players[Position_Players == "CAA"] <- "Colonial Athletic Association"
Pitchers[Pitchers == "CAA"] <- "Colonial Athletic Association"

Position_Players[Position_Players == "Cal-Pac"] <- "California Pacific Conference"
Pitchers[Pitchers == "Cal-Pac"] <- "California Pacific Conference"

Position_Players[Position_Players == "California Collegeiate Athletic Associatiom"] <- "California Collegiate Athletic Association"
Pitchers[Pitchers == "California Collegeiate Athletic Associatiom"] <- "California Collegiate Athletic Association"

Position_Players[Position_Players == "California Community College Athlectic Associaion"] <- "California Community College Athletic Association"
Pitchers[Pitchers == "California Community College Athlectic Associaion"] <- "California Community College Athletic Association"

Position_Players[Position_Players == "California Community College Athletic Associaion"] <- "California Community College Athletic Association"
Pitchers[Pitchers == "California Community College Athletic Associaion"] <- "California Community College Athletic Association"

Position_Players[Position_Players == "Cetennial Conference"] <- "Centennial Conference"
Pitchers[Pitchers == "Cetennial Conference"] <- "Centennial Conference"

Position_Players[Position_Players == "MAAC"] <- "Metro Atlantic Athletic Conference"
Pitchers[Pitchers == "MAAC"] <- "Metro Atlantic Athletic Conference"

Position_Players[Position_Players == "Mountian West Conference"] <- "Mountain West Conference"
Pitchers[Pitchers == "Mountian West Conference"] <- "Mountain West Conference"

Position_Players[Position_Players == "Northern Athletic Collegiante Conference"] <- "Northern Athletic Collegiate Conference"
Pitchers[Pitchers == "Northern Athletic Collegiante Conference"] <- "Northern Athletic Collegiate Conference"

Position_Players[Position_Players == "NWAC"] <- "Northwest Athletic Conference"
Pitchers[Pitchers == "NWAC"] <- "Northwest Athletic Conference"

Position_Players[Position_Players == "Ohio Valley"] <- "Ohio Valley Conference"
Pitchers[Pitchers == "Ohio Valley"] <- "Ohio Valley Conference"

Position_Players[Position_Players == "South Coast Conference-North"] <- "South Coast Conference"
Pitchers[Pitchers == "South Coast Conference-North"] <- "South Coast Conference"

Position_Players[Position_Players == "South Coast Conference-South"] <- "South Coast Conference"
Pitchers[Pitchers == "South Coast Conference-South"] <- "South Coast Conference"

Position_Players[Position_Players == "Sun Belt"] <- "Sun Belt Conference"
Pitchers[Pitchers == "Sun Belt"] <- "Sun Belt Conference"

Position_Players[Position_Players == "Sunshine State Conference - Div II"] <- "Sunshine State Conference"
Pitchers[Pitchers == "Sunshine State Conference - Div II"] <- "Sunshine State Conference"

Position_Players[Position_Players == "Wisconsin Intercolliegate Athletic Conference"] <- "Wisconsin Intercollegiate Athletic Conference"
Pitchers[Pitchers == "Wisconsin Intercolliegate Athletic Conference"] <- "Wisconsin Intercollegiate Athletic Conference"

####### Drafted player fix #######

draft_18_hitters[draft_18_hitters == "American Southwestern Conference"] <- "American Southwest Conference"
draft_18_pitchers[draft_18_pitchers == "American Southwestern Conference"] <- "American Southwest Conference"

draft_18_hitters[draft_18_hitters == "Atlantic 10"] <- "Atlantic 10 Conference"
draft_18_pitchers[draft_18_pitchers == "Atlantic 10"] <- "Atlantic 10 Conference"

draft_18_hitters[draft_18_hitters == "Atlantic Sun"] <- "Atlantic Sun Conference"
draft_18_pitchers[draft_18_pitchers == "Atlantic Sun"] <- "Atlantic Sun Conference"

draft_18_hitters[draft_18_hitters == "Big-12"] <- "Big 12"
draft_18_pitchers[draft_18_pitchers == "Big-12"] <- "Big 12"

draft_18_hitters[draft_18_hitters == "Big East Conference"] <- "Big East"
draft_18_pitchers[draft_18_pitchers == "Big East Conference"] <- "Big East"

draft_18_hitters[draft_18_hitters == "Big Ten"] <- "Big 10"
draft_18_pitchers[draft_18_pitchers == "Big Ten"] <- "Big 10"

draft_18_hitters[draft_18_hitters == "Big Ten Conference"] <- "Big 10"
draft_18_pitchers[draft_18_pitchers == "Big Ten Conference"] <- "Big 10"

draft_18_hitters[draft_18_hitters == "Big South"] <- "Big South Conference"
draft_18_pitchers[draft_18_pitchers == "Big South"] <- "Big South Conference"

draft_18_hitters[draft_18_hitters == "California Collegiatte Athletic Association"] <- "California Collegiate Athletic Association"
draft_18_pitchers[draft_18_pitchers == "California Collegiatte Athletic Association"] <- "California Collegiate Athletic Association"

draft_18_hitters[draft_18_hitters == "CCAA"] <- "California Collegiate Athletic Association"
draft_18_pitchers[draft_18_pitchers == "CCAA"] <- "California Collegiate Athletic Association"


draft_18_hitters[draft_18_hitters == "CCCAA"] <- "California Community College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "CCCAA"] <- "California Community College Athletic Association"

draft_18_hitters[draft_18_hitters == "Colonial Athletic Asssociation"] <- "Colonial Athletic Association"
draft_18_pitchers[draft_18_pitchers == "Colonial Athletic Asssociation"] <- "Colonial Athletic Association"

draft_18_hitters[draft_18_hitters == "Great Lake Intercollegiate Athletic Conference"] <- "Great Lakes Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Great Lake Intercollegiate Athletic Conference"] <- "Great Lakes Intercollegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "Great Lakes Intercollegiate"] <- "Great Lakes Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Great Lakes Intercollegiate"] <- "Great Lakes Intercollegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "Great Midwest Atheletic Conference"] <- "Great Midwest Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Great Midwest Atheletic Conference"] <- "Great Midwest Athletic Conference"

draft_18_hitters[draft_18_hitters == "Heartland Conference"] <- "Heartland Collegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Heartland Conference"] <- "Heartland Collegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "Illnois N4C Conference"] <- "Illinois N4C Conference"
draft_18_pitchers[draft_18_pitchers == "Illnois N4C Conference"] <- "Illinois N4C Conference"
#####
draft_18_hitters[draft_18_hitters == "Iowa Intercol. Athletic Conf."] <- "Iowa Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Iowa Intercol. Athletic Conf."] <- "Iowa Intercollegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "Mid-American Conference"] <- "Mid American Conference"
draft_18_pitchers[draft_18_pitchers == "Mid-American Conference"] <- "Mid American Conference"

draft_18_hitters[draft_18_hitters == "Mid-American Confrence"] <- "Mid American Conference"
draft_18_pitchers[draft_18_pitchers == "Mid-American Confrence"] <- "Mid American Conference"

draft_18_hitters[draft_18_hitters == "MId-American Conference"] <- "Mid American Conference"
draft_18_pitchers[draft_18_pitchers == "MId-American Conference"] <- "Mid American Conference"

draft_18_hitters[draft_18_hitters == "Missouri Valley"] <- "Missouri Valley Conference"
draft_18_pitchers[draft_18_pitchers == "Missouri Valley"] <- "Missouri Valley Conference"

draft_18_hitters[draft_18_hitters == "Mountain West"] <- "Mountain West Conference"
draft_18_pitchers[draft_18_pitchers == "Mountain West"] <- "Mountain West Conference"

draft_18_hitters[draft_18_hitters == "Mountian West"] <- "Mountain West Conference"
draft_18_pitchers[draft_18_pitchers == "Mountian West"] <- "Mountain West Conference"

draft_18_hitters[draft_18_hitters == "NCCAA"] <- "National Christian College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "NCCAA"] <- "National Christian College Athletic Association"

draft_18_hitters[draft_18_hitters == "NCCAA- West"] <- "National Christian College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "NCCAA- West"] <- "National Christian College Athletic Association"

draft_18_hitters[draft_18_hitters == "Northeast-10"] <- "Northeast-10 Conference"
draft_18_pitchers[draft_18_pitchers == "Northeast-10"] <- "Northeast-10 Conference"

draft_18_hitters[draft_18_hitters == "Northern Athletics Collegiate Conference"] <- "Northern Athletic Collegiate Conference"
draft_18_pitchers[draft_18_pitchers == "Northern Athletics Collegiate Conference"] <- "Northern Athletic Collegiate Conference"

draft_18_hitters[draft_18_hitters == "Northwest Atlantic Confrence"] <- "Northwest Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Northwest Atlantic Confrence"] <- "Northwest Athletic Conference"

draft_18_hitters[draft_18_hitters == "Pac-12"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pac-12"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "PAC-12"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "PAC-12"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pac 12"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pac 12"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pac2"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pac2"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pacific 12"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pacific 12"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pacific 12 Confrence"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pacific 12 Confrence"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pacifc 12"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pacifc 12"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Pacific Coast"] <- "Pacific Coast Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Pacific Coast"] <- "Pacific Coast Athletic Conference"

draft_18_hitters[draft_18_hitters == "Pacific Coast Conference"] <- "Pacific Coast Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Pacific Coast Conference"] <- "Pacific Coast Athletic Conference"

draft_18_hitters[draft_18_hitters == "Pacific2 Conference"] <- "Pacific-12 Conference"
draft_18_pitchers[draft_18_pitchers == "Pacific2 Conference"] <- "Pacific-12 Conference"

draft_18_hitters[draft_18_hitters == "Peach Belt"] <- "Peach Belt Conference"
draft_18_pitchers[draft_18_pitchers == "Peach Belt"] <- "Peach Belt Conference"

draft_18_hitters[draft_18_hitters == "RMAC"] <- "Rocky Mountain Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "RMAC"] <- "Rocky Mountain Athletic Conference"

draft_18_hitters[draft_18_hitters == "SCIAC"] <- "Southern California Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "SCIAC"] <- "Southern California Intercollegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "SAC DII"] <- "South Atlantic Conference"
draft_18_pitchers[draft_18_pitchers == "SAC DII"] <- "South Atlantic Conference"

draft_18_hitters[draft_18_hitters == "South Coast Conference-South"] <- "South Coast Conference"
draft_18_pitchers[draft_18_pitchers == "South Coast Conference-South"] <- "South Coast Conference"

draft_18_hitters[draft_18_hitters == "SEC"] <- "Southeastern Conference"
draft_18_pitchers[draft_18_pitchers == "SEC"] <- "Southeastern Conference"

draft_18_hitters[draft_18_hitters == "South Eastern Conference"] <- "Southeastern Conference"
draft_18_pitchers[draft_18_pitchers == "South Eastern Conference"] <- "Southeastern Conference"

draft_18_hitters[draft_18_hitters == "Southeastern"] <- "Southeastern Conference"
draft_18_pitchers[draft_18_pitchers == "Southeastern"] <- "Southeastern Conference"

draft_18_hitters[draft_18_hitters == "Southern California Intercoligate Athletic Conference"] <- "Southern California Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Southern California Intercoligate Athletic Conference"] <- "Southern California Intercollegiate Athletic Conference"

draft_18_hitters[draft_18_hitters == "Southern"] <- "Southern Conference"
draft_18_pitchers[draft_18_pitchers == "Southern"] <- "Southern Conference"

draft_18_hitters[draft_18_hitters == "Southland"] <- "Southland Conference"
draft_18_pitchers[draft_18_pitchers == "Southland"] <- "Southland Conference"

draft_18_hitters[draft_18_hitters == "Southwestern Junior College Conference"] <- "Southwest Junior College Conference"
draft_18_pitchers[draft_18_pitchers == "Southwestern Junior College Conference"] <- "Southwest Junior College Conference"

draft_18_hitters[draft_18_hitters == "Soutland Conference"] <- "Southland Conference"
draft_18_pitchers[draft_18_pitchers == "Soutland Conference"] <- "Southland Conference"

draft_18_hitters[draft_18_hitters == "SWAC"] <- "Scenic West Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "SWAC"] <- "Scenic West Athletic Conference"

draft_18_hitters[draft_18_hitters == "TCCAA"] <- "Tennessee Community College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "TCCAA"] <- "Tennessee Community College Athletic Association"

draft_18_hitters[draft_18_hitters == "University Athletic Associaton"] <- "University Athletic Association"
draft_18_pitchers[draft_18_pitchers == "University Athletic Associaton"] <- "University Athletic Association"

draft_18_hitters[draft_18_hitters == "WCC"] <- "West Coast Conference"
draft_18_pitchers[draft_18_pitchers == "WCC"] <- "West Coast Conference"

draft_18_hitters[draft_18_hitters == "West Coast"] <- "West Coast Conference"
draft_18_pitchers[draft_18_pitchers == "West Coast"] <- "West Coast Conference"

draft_18_hitters[draft_18_hitters == "WAC"] <- "Western Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "WAC"] <- "Western Athletic Conference"

draft_18_hitters[draft_18_hitters == "Wolverine Hoosier Athletic Conference"] <- "Wolverine-Hoosier Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Wolverine Hoosier Athletic Conference"] <- "Wolverine-Hoosier Athletic Conference"

draft_18_hitters[draft_18_hitters == "4A/5A Pike Peaks League"] <- "4A/5A Pikes Peak League"
draft_18_pitchers[draft_18_pitchers == "4A/5A Pike Peaks League"] <- "4A/5A Pikes Peak League"

draft_18_hitters[draft_18_hitters == "Atlantic Coastal Conference"] <- "Atlantic Coast Conference"
draft_18_pitchers[draft_18_pitchers == "Atlantic Coastal Conference"] <- "Atlantic Coast Conference"

draft_18_hitters[draft_18_hitters == "Big West"] <- "Big West Conference"
draft_18_pitchers[draft_18_pitchers == "Big West"] <- "Big West Conference"

draft_18_hitters[draft_18_hitters == "CAA"] <- "Colonial Athletic Association"
draft_18_pitchers[draft_18_pitchers == "CAA"] <- "Colonial Athletic Association"

draft_18_hitters[draft_18_hitters == "Cal-Pac"] <- "California Pacific Conference"
draft_18_pitchers[draft_18_pitchers == "Cal-Pac"] <- "California Pacific Conference"

draft_18_hitters[draft_18_hitters == "California Collegeiate Athletic Associatiom"] <- "California Collegiate Athletic Association"
draft_18_pitchers[draft_18_pitchers == "California Collegeiate Athletic Associatiom"] <- "California Collegiate Athletic Association"

draft_18_hitters[draft_18_hitters == "California Community College Athlectic Associaion"] <- "California Community College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "California Community College Athlectic Associaion"] <- "California Community College Athletic Association"

draft_18_hitters[draft_18_hitters == "California Community College Athletic Associaion"] <- "California Community College Athletic Association"
draft_18_pitchers[draft_18_pitchers == "California Community College Athletic Associaion"] <- "California Community College Athletic Association"

draft_18_hitters[draft_18_hitters == "Cetennial Conference"] <- "Centennial Conference"
draft_18_pitchers[draft_18_pitchers == "Cetennial Conference"] <- "Centennial Conference"

draft_18_hitters[draft_18_hitters == "MAAC"] <- "Metro Atlantic Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "MAAC"] <- "Metro Atlantic Athletic Conference"

draft_18_hitters[draft_18_hitters == "Mountian West Conference"] <- "Mountain West Conference"
draft_18_pitchers[draft_18_pitchers == "Mountian West Conference"] <- "Mountain West Conference"

draft_18_hitters[draft_18_hitters == "Northern Athletic Collegiante Conference"] <- "Northern Athletic Collegiate Conference"
draft_18_pitchers[draft_18_pitchers == "Northern Athletic Collegiante Conference"] <- "Northern Athletic Collegiate Conference"

draft_18_hitters[draft_18_hitters == "NWAC"] <- "Northwest Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "NWAC"] <- "Northwest Athletic Conference"

draft_18_hitters[draft_18_hitters == "Ohio Valley"] <- "Ohio Valley Conference"
draft_18_pitchers[draft_18_pitchers == "Ohio Valley"] <- "Ohio Valley Conference"

draft_18_hitters[draft_18_hitters == "South Coast Conference-North"] <- "South Coast Conference"
draft_18_pitchers[draft_18_pitchers == "South Coast Conference-North"] <- "South Coast Conference"

draft_18_hitters[draft_18_hitters == "South Coast Conference-South"] <- "South Coast Conference"
draft_18_pitchers[draft_18_pitchers == "South Coast Conference-South"] <- "South Coast Conference"

draft_18_hitters[draft_18_hitters == "Sun Belt"] <- "Sun Belt Conference"
draft_18_pitchers[draft_18_pitchers == "Sun Belt"] <- "Sun Belt Conference"

draft_18_hitters[draft_18_hitters == "Sunshine State Conference - Div II"] <- "Sunshine State Conference"
draft_18_pitchers[draft_18_pitchers == "Sunshine State Conference - Div II"] <- "Sunshine State Conference"

draft_18_hitters[draft_18_hitters == "Wisconsin Intercolliegate Athletic Conference"] <- "Wisconsin Intercollegiate Athletic Conference"
draft_18_pitchers[draft_18_pitchers == "Wisconsin Intercolliegate Athletic Conference"] <- "Wisconsin Intercollegiate Athletic Conference"



fixed <- unique(draft_18_hitters)
write.csv(fixed, file = "new_players_fixed.csv")
