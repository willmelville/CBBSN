
///
	# Loading packages
	library(readr)
	library(stats)
	library(plotly)
	library(moments)
	library(psych)
	library(dplyr)
	library(tidyverse)
	library(TTR)
	library(gtools)
	library(zoo)
# 
# WC <- read_csv("~/Downloads/Fully Consolidated Spring 2018 Data - Sheet1-4.csv", 
# 			col_types = cols(GAME_DATE = col_date(format = "%m/%d/%Y")))
# WC <- WC[c(1:3)]
# WC$row_ID <- paste(WC$FIRST_NAME, " ", WC$LAST_NAME, " -- ", WC$GAME_DATE)
# Position_Players$row_ID <- paste(Position_Players$FIRST_NAME, " ", Position_Players$LAST_NAME, " -- ", Position_Players$GAME_DATE)
# Pitchers$row_ID <- paste(Pitchers$FIRST_NAME, " ", Pitchers$LAST_NAME, " -- ", Pitchers$GAME_DATE)
# 
# c1 <- WC[c(1,2,3,4)]
# c2 <- Position_Players[c(1,2,3,52)]	
# c3 <- Pitchers[c(1,2,3,74)]
# cond_all = bind_rows(c1, c2, c3)
# 
# fulls <- subset(cond_all, !duplicated(cond_all$row_ID))
# write.csv(fulls, "unique_rows.csv", row.names = FALSE)      

///
	# Upload data
	#Position_Players <- read_csv("~/Desktop/CBBSN/Data Cleaning/HitterSheet.csv")
	# Position_Players <- read_csv("/Users/jasonrubenstein/Downloads/2018 Summer Data - summer_hitters.csv")
	# Position_Players <- read_csv("/Users/jasonrubenstein/Downloads/Full Spring Data (Currently Weeks 1-16) - Hitters-4.csv")
	# draft_18_hitters <- read_csv("/Users/jasonrubenstein/Downloads/DRAFT_DATA_ANALYSIS_Hitters.csv")
	# players_sheet <- read_csv("/Users/jasonrubenstein/Desktop/CBBSN/new_players.csv")
	#Position_Players[order(as.Date(Position_Players$GAME_DATE,format="%d/%m/%Y")),,drop=FALSE]
	# arrange(Position_Players, order(GAME_DATE))
  Position_Players <- read_csv("~/Desktop/em_data_test_hitters.csv")
	Position_Players$PITCHES_TOTAL <- as.numeric(Position_Players$PITCHES_TOTAL)
	dupe_pos <- Position_Players[duplicated(Position_Players),] # Find dupes
	Position_Players[!duplicated(Position_Players), ] # Remove duplicated rows
	Position_Players$Name <- paste(Position_Players$`First Name`, " ", Position_Players$`Last Name`, " -- ", Position_Players$PLAYER_SCHOOL)
	
	#Pitchers <- read_csv("~/Desktop/CBBSN/Data Cleaning/PitcherSheet.csv")
	# Pitchers <- read_csv("/Users/jasonrubenstein/Downloads/2018 Summer Data - summer_pitchers.csv")
	# Pitchers <- read_csv("/Users/jasonrubenstein/Downloads/Full Spring Data (Currently Weeks 1-16) - Pitchers-4.csv")
	# draft_18_pitchers <- read_csv("/Users/jasonrubenstein/Downloads/DRAFT_DATA_ANALYSIS_Pitchers.csv")
	Pitchers <- read_csv("~/Desktop/em_data_test_pitchers.csv")
	arrange(Pitchers, order(GAME_DATE))
	Pitchers$STRIKE_BALL_PERCENTAGE <- as.numeric(Pitchers$STRIKE_BALL_PERCENTAGE)
	dupe_pit <- Pitchers[duplicated(Pitchers), ] # Find dupes
	Pitchers[!duplicated(Pitchers), ] # Remove duplicated rows
	Pitchers$Name <- paste(Pitchers$`First Name`, " ", Pitchers$`Last Name`, " -- ", Pitchers$PLAYER_SCHOOL)
	
	
	# Convert -1 (dummy used for missing values) to NA
	Pitchers[Pitchers == -1] <- NA
	Pitchers[Pitchers == "-"] <- NA
	Position_Players[Position_Players == -1] <- NA
	Position_Players[Position_Players == "-"] <- NA
	
	
	# Convert 0 in velo column to NA
	Pitchers$FASTBALL_VELO_MAX[Pitchers$FASTBALL_VELO_MAX == 0] <- NA
	Pitchers$FASTBALL_VELO_MIN[Pitchers$FASTBALL_VELO_MIN == 0] <- NA
	Pitchers$BREAKING_BALL_VELO_MAX[Pitchers$BREAKING_BALL_VELO_MAX == 0] <- NA
	Pitchers$BREAKING_BALL_VELO_MIN[Pitchers$BREAKING_BALL_VELO_MIN == 0] <- NA
	Pitchers$THIRD_PITCH_VELO_MAX[Pitchers$THIRD_PITCH_VELO_MAX == 0] <- NA
	Pitchers$THIRD_PITCH_VELO_MIN[Pitchers$THIRD_PITCH_VELO_MIN == 0] <- NA
	Pitchers$FOURTH_PITCH_VELO_MAX[Pitchers$FOURTH_PITCH_VELO_MAX == 0] <- NA
	Pitchers$FOURTH_PITCH_VELO_MIN[Pitchers$FOURTH_PITCH_VELO_MIN == 0] <- NA
	
	# Convert 0 in Home/1st column to NA
	Position_Players$HOME_1ST_TIME[Position_Players$HOME_1ST_TIME == 0] <- NA
	
	///
		
		# Select first nine columns 
			cond_pitchers <- Pitchers[c(1,2,3,4,5,6,7,8,9,74)]
			cond_pos <- Position_Players[c(1,2,3,4,5,6,7,10,11,52)]	
				# Combined DF
				cond_all = bind_rows(cond_pitchers, cond_pos)
				arrange(cond_all, order(GAME_DATE)) 
	
	##### CBBSN Stats ####
	
	# How many schools have we collected data on?
	unique(Pitchers$PLAYER_SCHOOL)
	unique(Position_Players$PLAYER_SCHOOL)
	unique(cond_all$PLAYER_SCHOOL)
	
	# How many conferences have we collected data on?
	unique(Pitchers$`CONFERENCE (Auto-fill)`)
	unique(Position_Players$`CONFERENCE (Auto-fill)`)
	
	# How many scouts have collected data for pos.players/pitchers?
	unique(Pitchers$SCOUT_NAME)
	unique(Position_Players$SCOUT_NAME)
	unique(cond_all$SCOUT.NAME)
	
	# How many players do we have data on?
	unique(Pitchers$Name)
	unique(Position_Players$Name)
	unique(cond_all$Name)
	
	# Assign a unique identifier for each scout name
	Pitchers <- transform(Pitchers,scout_id=as.numeric(
		factor(Pitchers$SCOUT_NAME)))
	Position_Players <- transform(Position_Players,scout_id=as.numeric(
		factor(Position_Players$SCOUT_NAME)))
	cond_all <- transform(cond_all,scout_id=as.numeric(
		factor(cond_all$SCOUT_NAME)))
	
	# Change GAME_DATE to Date format
	Pitchers$GAME_DATE <- as.Date(Pitchers$GAME_DATE, "%m/%d/%y")
	Position_Players$GAME_DATE <- as.Date(Position_Players$GAME_DATE, "%m/%d/%y")
	cond_all$GAME_DATE <- as.Date(cond_all$GAME_DATE, "%m/%d/%y")
	
	# Assign each_report the value of 1
	Pitchers$rep_val = 1
	Position_Players$rep_val = 1
	cond_all$rep_val = 1
	
	# Find sum of reports gathered for each date
	Pitchers$rep_sum <- ave(Pitchers$rep_val, Pitchers$GAME_DATE, FUN=sum)
	Position_Players$rep_sum <- ave(Position_Players$rep_val, Position_Players$GAME_DATE, FUN=sum)
	cond_all$rep_sum <- ave(cond_all$rep_val, cond_all$GAME_DATE, FUN=sum)
	
	# Plot moving average of rep_sum by GAME_DATE for Pitchers & Pos. Players
	pitcher_rep_ma <- EMA(Pitchers$rep_sum, 15)
	plot(Pitchers$GAME_DATE, pitcher_rep_ma, main = "Pitcher Reports Collected 15-Day Rolling Avg.")
	
	pp_rep_ma <- EMA(Position_Players$rep_sum, 15)
	plot(Position_Players$GAME_DATE, pp_rep_ma, main = "Pos. Player Reports Collected 15-Day Rolling Avg.")
	
	# Now for all reports in one plot
	cond_all$dt=strptime(cond_all$GAME_DATE, "%Y-%m-%d")
	cond_all$dt <- as.Date(cond_all$dt)
	
	cond_all_ma <- EMA(cond_all$rep_sum, 14)
	
	plot(cond_all$GAME_DATE, cond_all_ma, main = "All Reports Collected 15-Day Rolling Avg.")
	
	cond_all_rma <- rollmean(cond_all$rep_sum, 7,fill = list(NA, NA))

	library(zoo)
	#Make zoo object of data
	Pitchers.zoo<-zoo(Pitchers$rep_sum,Pitchers$GAME_DATE)
	
	#Calculate moving average with window 3 and make first and last value as NA (to ensure identical length of vectors)
	m.av<-rollmean(Pitchers.zoo, 100,fill = list(NA, NULL, NA))
	
	#Add calculated moving averages to existing data frame
	Pitchers$rep_av=coredata(m.av)
	
	#Add additional line for moving average in red
	ggplot(Pitchers, aes(GAME_DATE)) + geom_line(aes(y=rep_sum,colour="real")) +
		geom_line(aes(y=rep_av,colour="moving"))+
		xlab("Game Date") + ylab("Reports Collected")+
		scale_colour_manual("Lines", values=c("real"="blue", "moving"="red")) + 
		ggtitle("Reports Collected with Moving Average")
	
	