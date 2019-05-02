#Will Melville
#load necessary data frames 
library(readr)
#this data comes from 2018 MLB draft summary Google sheet
pitcher_draft <- read_csv("2018 MLB Draft Summary - Pitchers (Spring Data).csv", 
                                 col_types = cols(GAME_DATE = col_skip(), 
                                                            SCOUT_NAME = col_skip(), Tier = col_skip()))
hitter_draft <- read_csv("2018 MLB Draft Summary - Hitters (Spring Data).csv", 
                                col_types = cols(TIER = col_skip()))
#this data is from the 2019 scouting data 
hitters2019 <- read_csv("2018 - 2019 EM Scout Data - HIT_Final.csv")
pitchers2019 <- read_csv("2018 - 2019 EM Scout Data - PIT_Final.csv")

#remove players scouted in 2018 from the frames
hitters2019 <- subset(hitters2019, substring(Date,8) == '19' | substring(Date,8)=='9')
pitchers2019 <- subset(pitchers2019, substring(Date,8) == '19' | substring(Date,8)=='9')
#add a column defining conference type as power 5, non power 5, divisions 2 and 3 and junior colleges (Non-D1), and high school
#This is a little tricky because of mistakes/typos in data entry
#initialize all of them as Non-D1
hitters2019$conf_type <- "Non-D1"
pitchers2019$conf_type <- "Non-D1"
hitter_draft$conf_type <- "Non-D1"
pitcher_draft$conf_type <- "Non-D1"
#create a list defining all power 5 conferences 
p5 <- c('Big 10','Big 12','Big Ten', 'Big Ten Conference','Atlantic Coast Conference', 'Atlantic Coastal Conference', 
        'Pac 12', 'Pac-12', 'PAC-12', 'Pac2', 'Pacific 12', 'Pacific 12 Confrence', 'Pacific-12 Conference','Pacific2 Conference',  
        'SEC', 'Southeastern', 'Southeastern Conference', 'BIg 10','Big-12', 'South Eastern', 'South Eastern Confenrence') 

hitter_draft$conf_type <- ifelse(hitter_draft$CONFERENCE %in% p5, 'Power 5', hitter_draft$conf_type)
hitters2019$conf_type <- ifelse(hitters2019$CONFERENCE %in% p5, 'Power 5', hitters2019$conf_type)
pitchers2019$conf_type <- ifelse(pitchers2019$CONFERENCE %in% p5, 'Power 5', pitchers2019$conf_type)
pitcher_draft$conf_type <- ifelse(pitcher_draft$CONFERENCE %in% p5, 'Power 5', pitcher_draft$conf_type)

#create a list of all non power 5 D1 conferences that show up in the data, I used the table function to make this list 
nonP5 <- c('A-10','A10', 'AAC', 'America East Conference', 'American Athletic Conference', 'American East', 'Atlantic 10', 'Atlantic Sun',
           'Atlantic Sun Conference', 'Big East', 'Big East Conference', 'Big Sky Conference', 'Big South', 'Big South Conference', 'Big West', 'Colonial Athletic Association', 
           'Colonial Athletic Asssociation', 'Conference USA', 'GSAC', 'Horizon League', 'Independent', 'Ivy League', 'MAC', 'Metro Atlantic Athletic Conference', 
           'Mid American Conference', 'Mid-American Conference', 'MId-American Conference', 'Mid-American Confrence', 'Missouri Valley', 'Missouri Valley Conference', 
           'Mountain West', 'Mountain West Conference', 'Mountian West', 'North East', 'Northeast Conference', 'Patriot League', 'Red River Athletic Conference', 
           'Red River Conference', 'Southern', 'Southern Conference', 'Southland Conference', 'Soutland Conference', 'Sun Belt', 'The Ivy League', 'WAC', 'WCC', 'West Coast', 
           'West Coast Conference', 'Western Athletic Conference', 'Atlantic 10 Conference', 'BIg East', 'Big South Conference Conference', 'Big West Conference', 'Colonial Athetic Conference', 
           'Colonial Athletic Conference', 'Mountian West Conference', 'Summit League', 'Sun Belt Conference') 
           
pitchers2019$conf_type <- ifelse(pitchers2019$DIVISION == 1 & pitchers2019$conf_type == 'Non-D1', 'Non-Power 5', pitchers2019$conf_type)
hitters2019$conf_type <- ifelse(hitters2019$DIVISION == 1 & hitters2019$conf_type == 'Non-D1', 'Non-Power 5', hitters2019$conf_type)
pitcher_draft$conf_type <- ifelse(pitcher_draft$CONFERENCE %in% nonP5, 'Non-Power 5', pitcher_draft$conf_type)
hitter_draft$conf_type <- ifelse(hitter_draft$CONFERENCE %in% nonP5, 'Non-Power 5', hitter_draft$conf_type)
pitcher_draft$conf_type <- ifelse(grepl('High School', pitcher_draft$PLAYER_SCHOOL), 'High School', pitcher_draft$conf_type)
hitter_draft$conf_type <- ifelse(grepl('High School', hitter_draft$PLAYER_SCHOOL), 'High School', hitter_draft$conf_type)
pitchers2019$conf_type <- ifelse(pitchers2019$DIVISION == 'HS', 'High School', pitchers2019$conf_type)
hitters2019$conf_type <- ifelse(hitters2019$DIVISION == 'HS', 'High School', hitters2019$conf_type)

#define a new column giving a more general postion based on position1 
#only need to do this for hitters, since pitchers all play the same position 
hitters2019$position <- 'C'
hitter_draft$position <- 'C'
hitters2019$position <- ifelse(hitters2019$POSITION1 == 'SS' | hitters2019$POSITION1 == '2B', 'Mid INF', hitters2019$position)
hitter_draft$position <- ifelse(hitter_draft$POSITION1 == 'SS' | hitter_draft$POSITION1 == '2B', 'Mid INF', hitter_draft$position)
hitters2019$position <- ifelse(hitters2019$POSITION1 == 'OF' | hitters2019$POSITION1 == 'CF' | 
                               hitters2019$POSITION1 == 'RF' | hitters2019$POSITION1 == 'LF', 'OF', hitters2019$position)
hitter_draft$position <- ifelse(hitter_draft$POSITION1 == 'OF' | hitter_draft$POSITION1 == 'CF' | 
                                 hitter_draft$POSITION1 == 'RF' | hitter_draft$POSITION1 == 'LF', 'OF', hitter_draft$position)
hitters2019$position <- ifelse(hitters2019$POSITION1 == '3B', '3B', hitters2019$position)
hitter_draft$position <- ifelse(hitter_draft$POSITION1 == '3B', '3B', hitter_draft$position)
hitters2019$position <- ifelse(hitters2019$POSITION1 == '1B', '1B', hitters2019$position)
hitter_draft$position <- ifelse(hitter_draft$position == '1B', '1B', hitter_draft$position)
hitters2019$position <- ifelse(hitters2019$POSITION1 == 'DH', 'DH', hitters2019$position)
hitter_draft$position <- ifelse(hitter_draft$POSITION1 == 'DH', 'DH', hitter_draft$position)

#define a new column class_num, which is 1 for freshman, 2 for sophomore, 3 for junior, and 4 for senior 
#I count redshirts in their red shirt class, so RS-Jr. goes with 3. I'm open to the idea of having RS-Jr. go with 4 though 
hitters2019$class_num <- 1
hitter_draft$class_num <- 1
pitchers2019$class_num <- 1
pitcher_draft$class_num <- 1
hitters2019$class_num <- ifelse(hitters2019$CLASS == 'So.' | hitters2019$CLASS == 'RS-So.' | hitters2019$CLASS == 'HS-So.', 2, hitters2019$class_num)
pitchers2019$class_num <- ifelse(pitchers2019$CLASS == 'So.' | pitchers2019$CLASS == 'RS-So.' | pitchers2019$CLASS == 'HS-So.', 2, pitchers2019$class_num)
hitters2019$class_num <- ifelse(hitters2019$CLASS == 'Jr.' | hitters2019$CLASS == 'RS-Jr.' | hitters2019$CLASS == 'HS-Jr.', 3, hitters2019$class_num)
hitters2019$class_num <- ifelse(hitters2019$CLASS == 'Sr.' | hitters2019$CLASS == 'RS-Sr.' | hitters2019$CLASS == 'HS-Sr.', 4, hitters2019$class_num)
pitchers2019$class_num <- ifelse(pitchers2019$CLASS == 'Jr.' | pitchers2019$CLASS == 'RS-Jr.' | pitchers2019$CLASS == 'HS-Jr.', 3, pitchers2019$class_num)
pitchers2019$class_num <- ifelse(pitchers2019$CLASS == 'Sr.' | pitchers2019$CLASS == 'RS-Sr.' | pitchers2019$CLASS == 'HS-Sr.', 4, pitchers2019$class_num)
hitter_draft$class_num <- ifelse(hitter_draft$CLASS == 'So.' | hitter_draft$CLASS == 'RS-So.', 2, hitter_draft$class_num)
hitter_draft$class_num <- ifelse(hitter_draft$CLASS == 'Jr.' | hitter_draft$CLASS == 'RS-Jr.', 3, hitter_draft$class_num)
hitter_draft$class_num <- ifelse(hitter_draft$CLASS == 'Sr.' | hitter_draft$CLASS == 'RS-Sr.', 4, hitter_draft$class_num)
pitcher_draft$class_num <- ifelse(pitcher_draft$CLASS == 'So.' | pitcher_draft$CLASS == 'RS_So.', 2, pitcher_draft$class_num)
pitcher_draft$class_num <- ifelse(pitcher_draft$CLASS == 'Jr.' | pitcher_draft$CLASS == 'RS_Jr.', 3, pitcher_draft$class_num)
pitcher_draft$class_num <- ifelse(pitcher_draft$CLASS == 'Sr.' | pitcher_draft$CLASS == 'RS_Sr.', 4, pitcher_draft$class_num)

#define functions to find the most similar player for pitchers and hitters 
similar_pitcher <- function(player){
  #the parameter player is a row from the pitcher_draft dataframe 
  #first check that player has all required data points 
  if(any(is.na(c(player$class_num, player$WEIGHT, player$HEIGHT_IN, player$FASTBALL_VELO_MAX, player$FASTBALL_VELO_MIN, 
                 player$conf_type, player$THROWING_SIDE_R_L)))){return(NA)}
  #take a subset of the pitchers2019 data where throwing side and conference type are the same 
  data <- subset(pitchers2019, conf_type == player$conf_type & THROWING_SIDE_R_L == player$THROWING_SIDE_R_L)
  #get rid of any data rows with missing data entries 
  data <- subset(data, is.na(data$FASTBALL_VELO_MIN)==FALSE & is.na(data$FASTBALL_VELO_MAX) == FALSE &
                   is.na(data$HEIGHT_IN) == FALSE & is.na(data$WEIGHT)==FALSE)
  if(nrow(data)==0){
    #there are no similar players 
    return(NA)
  }
  #now for the quantifiable variables, use the standard distance formula (2-norm) to compare player with all 2019 pitchers 
  #Loop through the rows, and use the 2 norm to define distance
  #first initialize the most similar player and the difference between the most similar player and player 
  similar <- data[1,]
  smallest_diff <- norm(c(similar$class_num - player$class_num, similar$HEIGHT_IN-player$HEIGHT_IN, 
                          similar$WEIGHT - player$WEIGHT, similar$`FASTBALL_VELO_MIN`-player$`FASTBALL_VELO_MIN`,
                          similar$`FASTBALL_VELO_MAX`-player$`FASTBALL_VELO_MAX`), '2')
  #if data only has one row, we're done. Otherwise, we loop through each row 
  if(nrow(data) == 1){return(paste(similar$`First Name`, similar$`Last Name`, sep=' '))}
  for(i in 2:nrow(data)){
    row <- data[i,]
    diff <- norm(c(row$class_num - player$class_num, row$HEIGHT_IN-player$HEIGHT_IN, 
                   row$WEIGHT - player$WEIGHT, row$`FASTBALL_VELO_MIN`-player$`FASTBALL_VELO_MIN`,
                   row$`FASTBALL_VELO_MAX`-player$`FASTBALL_VELO_MAX`), '2')
    if(diff < smallest_diff){
      smallest_diff <- diff
      similar <- row
    }
  }
  #return the player name with the lowest difference 
  #closest <- data[data$difference == min(data$difference),]
  return(paste(similar$`First Name`, similar$`Last Name`, sep=' '))
}

similar_hitter <- function(player){
  #player is a row from the hitter_draft data frame 
  #check if player has all required data. If not, return na 
  if(any(is.na(c(player$HEIGHT_IN, player$WEIGHT_LBS, player$class_num)))){return(NA)}
  #take a subset from hitters2019 where position, batting side, throwing side, and conftype all match 
  data <- subset(hitters2019, BATTING_SIDE_R_L_S == player$BATTING_SIDE_R_L_S & THROWING_SIDE_R_L == player$THROWING_SIDE_R_L &
                   conf_type == player$conf_type & position == player$position)
  #remove any data with missing entries 
  data <- subset(data, is.na(data$class_num)==FALSE & is.na(data$HEIGHT_IN) == FALSE & 
                   is.na(data$WEIGHT_LBS)==FALSE)
  if(nrow(data)==0){
    #there are no similar players 
    return(NA)
  }
  else{
    #now compare quantifiable variables height, weight, and class_num 
    similar <- data[1,]
    smallest_diff <- norm(c(similar$class_num-player$class_num, similar$HEIGHT_IN-player$HEIGHT_IN, 
                          similar$WEIGHT_LBS-player$WEIGHT_LBS), '2')
    #if data only has one row left, we are done 
    if(nrow(data) == 1){return(paste(similar$`First Name`, similar$`Last Name`, sep=' '))}
    #if data has more than one row, loop through each player in data to find the most similar 
    for(i in 2:nrow(data)){
      row <- data[i,]
      diff <- norm(c(row$class_num-player$class_num, row$HEIGHT_IN-player$HEIGHT_IN, 
                   row$WEIGHT_LBS-player$WEIGHT_LBS), '2')
      if(diff < smallest_diff){
        smallest_diff <- diff 
        similar <- row
      }
    }
    return(paste(similar$`First Name`, similar$`Last Name`, sep=' '))
  }
}  

#now apply these functions to every entry in hitter_draft and pitcher_draft 
#but only apply it to players who were drafted 
hitter_draft <- subset(hitter_draft, `DRAFTED?` =='Y')
pitcher_draft <- subset(pitcher_draft, `DRAFTED?` == 'Y')
similar_h <- list()
for(i in 1:nrow(hitter_draft)){
  similar_h <- append(similar_h, similar_hitter(hitter_draft[i,]))
}
similar_p <- list()
for(i in 1:nrow(pitcher_draft)){
  similar_p <- append(similar_p, similar_pitcher(pitcher_draft[i,]))
}

#finally, create data frames combining the drafted players with their similar players
pitchers <- data.frame(pitcher_draft$`FULL NAME`, pitcher_draft$ROUND, pitcher_draft$PICK, 
                       pitcher_draft$TEAM, pitcher_draft$CLASS, pitcher_draft$PLAYER_SCHOOL, 
                       pitcher_draft$conf_type, pitcher_draft$HEIGHT_IN, pitcher_draft$WEIGHT, 
                       pitcher_draft$THROWING_SIDE_R_L, pitcher_draft$FASTBALL_VELO_MAX, pitcher_draft$FASTBALL_VELO_MIN, 
                       cbind(similar_p))
hitters <- data.frame(hitter_draft$`FULL NAME`, hitter_draft$ROUND, hitter_draft$PICK, hitter_draft$TEAM, 
                      hitter_draft$CLASS, hitter_draft$PLAYER_SCHOOL, hitter_draft$conf_type, hitter_draft$HEIGHT_IN, 
                      hitter_draft$WEIGHT_LBS, hitter_draft$position, hitter_draft$BATTING_SIDE_R_L_S, 
                      hitter_draft$THROWING_SIDE_R_L, cbind(similar_h))
