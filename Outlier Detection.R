
### CBBBSN Outlier Detection ###


#### Velo discrepancies/difference ####
	# If negative value, locate & check row then contact RM/ARM ***

		# Fastball
		boxplot(Pitchers$FASTBALL_VELO_MAX - Pitchers$FASTBALL_VELO_MIN)
		Pitchers$FB_Diff <- NA
		Pitchers$FB_Diff <- Pitchers$FASTBALL_VELO_MAX - Pitchers$FASTBALL_VELO_MIN
		hist(Pitchers$FB_Diff)

		# For same pitch
		Pitchers$BREAKING_BALL_Diff <- NA
			Pitchers$BREAKING_BALL_Diff <- Pitchers$BREAKING_BALL_VELO_MAX - Pitchers$BREAKING_BALL_VELO_MIN
			boxplot(Pitchers$BREAKING_BALL_Diff)
			hist(Pitchers$BREAKING_BALL_Diff)
			
		Pitchers$THIRD_PITCH_Diff <- NA
			Pitchers$THIRD_PITCH_Diff <- Pitchers$THIRD_PITCH_VELO_MAX - Pitchers$THIRD_PITCH_VELO_MIN
			boxplot(Pitchers$THIRD_PITCH_Diff)
			hist(Pitchers$THIRD_PITCH_Diff)
				
		Pitchers$FOURTH_PITCH_Diff <- NA
			Pitchers$FOURTH_PITCH_Diff <- Pitchers$FOURTH_PITCH_VELO_MAX - Pitchers$FOURTH_PITCH_VELO_MIN
			boxplot(Pitchers$FOURTH_PITCH_Diff)
			hist(Pitchers$FOURTH_PITCH_Diff)
				plot(Pitchers$FOURTH_PITCH_VELO_MAX, Pitchers$FOURTH_PITCH_VELO_MIN)

		# Fastball vs Other
			Pitchers$FB_BREAK_VELO_Diff <- NA
				Pitchers$FB_BREAK_VELO_Diff <- Pitchers$FASTBALL_VELO_MAX - Pitchers$BREAKING_BALL_VELO_MAX
				boxplot(Pitchers$FB_BREAK_VELO_Diff)
				# 	require(ggplot2)
				# Pitchers_With_Grades <- subset(Pitchers, Pitchers$PRESENT_FASTBALL_GRADE_20_80 > 0 & Pitchers$FUTURE_FASTBALL_GRADE_20_80 > 0)
				# p <- ggplot(data = Pitchers_With_Grades, aes(x=PRESENT_FASTBALL_GRADE_20_80, y=FUTURE_FASTBALL_GRADE_20_80)) 
				# p <- p + geom_boxplot(aes(fill=Label))
				# p <- p + geom_jitter()
				# p <- p + facet_wrap( ~ variable, scales="free")
				# p <- p + xlab("x-axis") + ylab("y-axis") + ggtitle("Title")
				# p <- p + guides(fill=guide_legend(title="Legend_Title"))
				# p 
				
			Pitchers$FB_THIRD_VELO_Diff <- NA
				Pitchers$FB_THIRD_VELO_Diff <- Pitchers$FASTBALL_VELO_MAX - Pitchers$THIRD_PITCH_VELO_MAX
				boxplot(Pitchers$FB_THIRD_VELO_Diff)
		
			Pitchers$FB_FOURTH_VELO_Diff <- NA
				Pitchers$FB_FOURTH_VELO_Diff <- Pitchers$FASTBALL_VELO_MAX - Pitchers$FOURTH_PITCH_VELO_MAX
				boxplot(Pitchers$FB_FOURTH_VELO_Diff)

			
# Data check
	##### Pitchers Data Check #####
 		# Boxscore and Player Info 
			######### multiple boxplots on one image -- trying to figure it out ######
		describe(Pitchers$WEIGHT)
			boxplot(Pitchers$WEIGHT, main = "Pitcher Weight")
			hist(Pitchers$WEIGHT)
	
		Pitchers$HEIGHT_IN <- as.numeric(Pitchers$HEIGHT_IN)	
		describe(Pitchers$HEIGHT_IN)
			boxplot(Pitchers$HEIGHT_IN, main = "Pitcher Height")
			hist(Pitchers$HEIGHT_IN)
	
		describe(Pitchers$HITS_ALLOWED)
			boxplot(Pitchers$HITS_ALLOWED, main = "Pitcher Hits Allowed")
			hist(Pitchers$HITS_ALLOWED)
	
		describe(Pitchers$HITS_ALLOWED_LEFT_SIDE)
			boxplot(Pitchers$HITS_ALLOWED_LEFT_SIDE, main = "Pitcher Hits ALlowed Left-Side")
			hist(Pitchers$HITS_ALLOWED_LEFT_SIDE)
	
		describe(Pitchers$HITS_ALLOWED_MIDDLE)
			boxplot(Pitchers$HITS_ALLOWED_MIDDLE, main = "Pitcher Hits Allowed Middle")
			hist(Pitchers$HITS_ALLOWED_MIDDLE)
	
		describe(Pitchers$HITS_ALLOWED_RIGHT_SIDE)
			boxplot(Pitchers$HITS_ALLOWED_RIGHT_SIDE, main = "Pitcher Hits Allowed Right Side")
			hist(Pitchers$HITS_ALLOWED_RIGHT_SIDE)
	
		describe(Pitchers$WALKS)
			boxplot(Pitchers$WALKS, main = "Pitcher Walks Allowed")
			hist(Pitchers$WALKS)
		
		Pitchers$INNINGS_PITCHED <- as.numeric(Pitchers$INNINGS_PITCHED)
		describe(Pitchers$INNINGS_PITCHED)
			Pitchers$INNINGS_PITCHED <- as.numeric(Pitchers$INNINGS_PITCHED)
			boxplot(Pitchers$INNINGS_PITCHED, main = "Pitcher Innings Pitched")
			hist(Pitchers$INNINGS_PITCHED)
	
		describe(Pitchers$RUNS_ALLOWED)
			boxplot(Pitchers$RUNS_ALLOWED, main = "Pitcher Runs Allowed")
			hist(Pitchers$RUNS_ALLOWED)
	
		describe(Pitchers$GROUNDOUTS)
			boxplot(Pitchers$GROUNDOUTS, main = "Pitcher Groundouts Induced")
			hist(Pitchers$GROUNDOUTS)
	
		describe(Pitchers$FLYOUTS)
			boxplot(Pitchers$FLYOUTS, main = "Pitcher Flyouts Induced")
			hist(Pitchers$FLYOUTS)
	
		describe(Pitchers$STRIKE_BALL_PERCENTAGE, na.rm = TRUE)
			boxplot(Pitchers$STRIKE_BALL_PERCENTAGE, main = "Pitcher Strike/Ball Percentage")
			hist(Pitchers$STRIKE_BALL_PERCENTAGE)
	
		
///
			###### VELO Examination #####
		# Fastballs
		describe(Pitchers$FASTBALL_VELO_MIN)
			boxplot(Pitchers$FASTBALL_VELO_MIN, main = "Fastball Min Velo")
			hist(Pitchers$FASTBALL_VELO_MIN)
	
		describe(Pitchers$FASTBALL_VELO_MAX)
			boxplot(Pitchers$FASTBALL_VELO_MAX, main = "Fastball Max Velo")
			hist(Pitchers$FASTBALL_VELO_MAX)
			FB_Velo_Density <- density(Pitchers$FASTBALL_VELO_MAX, na.rm = TRUE) # note very low fastballs ( < 80 mph) no chance a team values that data
			plot(FB_Velo_Density, main = "FB Velo Density", xlab = "FB Max Velo Density")
			polygon(FB_Velo_Density, col = "red", border = "yellow")
			kurtosis(Pitchers$FASTBALL_VELO_MAX, na.rm = TRUE) 
	
			# FB Swing Check for negatives #
				# Total - Whiffs
		boxplot(Pitchers$TOTAL_SWINGS_FASTBALL - Pitchers$SWINGS_AND_MISSES_FASTBALL)
		
				# Total - Chases
		boxplot(Pitchers$TOTAL_SWINGS_FASTBALL - Pitchers$CHASE_SWINGS_FASTBALL)
		
		describe(Pitchers$TOTAL_SWINGS_FASTBALL)
			boxplot(Pitchers$TOTAL_SWINGS_FASTBALL, main = "Fastball Total Swings")
			hist(Pitchers$TOTAL_SWINGS_FASTBALL)
	
		describe(Pitchers$SWINGS_AND_MISSES_FASTBALL)
			boxplot(Pitchers$SWINGS_AND_MISSES_FASTBALL, main = "Fastball Whiffs")
			hist(Pitchers$SWINGS_AND_MISSES_FASTBALL)
	
		describe(Pitchers$CHASE_SWINGS_FASTBALL)
			boxplot(Pitchers$CHASE_SWINGS_FASTBALL, main = "Fastball Chase Swings")
			hist(Pitchers$CHASE_SWINGS_FASTBALL)
	
		describe(Pitchers$HARD_CONTACT_FASTBALL)
			boxplot(Pitchers$HARD_CONTACT_FASTBALL, main = "Fastball Hard Contact Against")
			hist(Pitchers$HARD_CONTACT_FASTBALL)
			
			
	///
		# Breaking Ball
			# Total - Whiffs
			boxplot(Pitchers$TOTAL_SWINGS_BREAKING_BALL - Pitchers$SWINGS_AND_MISSES_BREAKING_BALL)
			
			# Total - Chases
			boxplot(Pitchers$TOTAL_SWINGS_BREAKING_BALL - Pitchers$CHASE_SWINGS_BREAKING_BALL)
			
			
		describe(Pitchers$BREAKING_BALL_VELO_MIN)
			boxplot(Pitchers$BREAKING_BALL_VELO_MIN, main = "Breaking Ball Min Velo")
			hist(Pitchers$BREAKING_BALL_VELO_MIN)
	
		describe(Pitchers$BREAKING_BALL_VELO_MAX)
			boxplot(Pitchers$BREAKING_BALL_VELO_MAX, main = "Breaking Ball Max Velo")
			hist(Pitchers$BREAKING_BALL_VELO_MAX)
			Breaking_Ball_Velo_Density <- density(Pitchers$BREAKING_BALL_VELO_MAX, na.rm = TRUE)
			plot(Breaking_Ball_Velo_Density, main = "Breaking Ball Velo Density", xlab = "Breaking Ball Max Velo Density")
			polygon(Breaking_Ball_Velo_Density, col = "blue", border = "black")
			kurtosis(Pitchers$BREAKING_BALL_VELO_MAX, na.rm = TRUE)
	
		describe(Pitchers$TOTAL_SWINGS_BREAKING_BALL)
			boxplot(Pitchers$TOTAL_SWINGS_BREAKING_BALL, main = "Breaking Ball Total Swings")
			hist(Pitchers$TOTAL_SWINGS_BREAKING_BALL)
	
		describe(Pitchers$SWINGS_AND_MISSES_BREAKING_BALL)
			boxplot(Pitchers$SWINGS_AND_MISSES_BREAKING_BALL, main = "Breaking Ball Whiffs")
			hist(Pitchers$SWINGS_AND_MISSES_BREAKING_BALL)
	
		describe(Pitchers$CHASE_SWINGS_BREAKING_BALL)
			boxplot(Pitchers$CHASE_SWINGS_BREAKING_BALL, main = "Breaking Ball Chase Swings")
			hist(Pitchers$CHASE_SWINGS_BREAKING_BALL)
	
		describe(Pitchers$HARD_CONTACT_BREAKING_BALL)
			boxplot(Pitchers$HARD_CONTACT_BREAKING_BALL, main = "Breaking Ball Hard Contact Against")
			hist(Pitchers$HARD_CONTACT_BREAKING_BALL)
	
	///
		# Third Pitch
			# Total - Whiffs
			boxplot(Pitchers$TOTAL_SWINGS_THIRD_PITCH - Pitchers$SWINGS_AND_MISSES_THIRD_PITCH)
			
			# Total - Chases
			boxplot(Pitchers$TOTAL_SWINGS_THIRD_PITCH - Pitchers$CHASE_SWINGS_THIRD_PITCH)
			
		describe(Pitchers$THIRD_PITCH_VELO_MIN)
			boxplot(Pitchers$THIRD_PITCH_VELO_MIN, main = "3rd Pitch Min Velo")
			hist(Pitchers$THIRD_PITCH_VELO_MIN)
	
		describe(Pitchers$THIRD_PITCH_VELO_MAX)
			boxplot(Pitchers$THIRD_PITCH_VELO_MAX, main = "3rd Pitch Max Velo")
			hist(Pitchers$THIRD_PITCH_VELO_MAX)
			Third_Pitch_Velo_Density <- density(Pitchers$THIRD_PITCH_VELO_MAX, na.rm = TRUE)
			plot(Third_Pitch_Velo_Density, main = "Third Pitch Velo Density", xlab = "Third Pitch Max Velo")
			polygon(Third_Pitch_Velo_Density, col = "green", border = "red")
			kurtosis(Pitchers$THIRD_PITCH_VELO_MAX, na.rm = TRUE)
	
	
		describe(Pitchers$TOTAL_SWINGS_THIRD_PITCH)
			boxplot(Pitchers$TOTAL_SWINGS_THIRD_PITCH, main = "3rd Pitch Total Swings")
			hist(Pitchers$TOTAL_SWINGS_THIRD_PITCH)
	
		describe(Pitchers$SWINGS_AND_MISSES_THIRD_PITCH)
			boxplot(Pitchers$SWINGS_AND_MISSES_THIRD_PITCH, main = "3rd Pitch Whiffs")
			hist(Pitchers$SWINGS_AND_MISSES_THIRD_PITCH)
	
		describe(Pitchers$CHASE_SWINGS_THIRD_PITCH)
			boxplot(Pitchers$CHASE_SWINGS_THIRD_PITCH, main = "3rd Pitch Chase Swings")
			hist(Pitchers$CHASE_SWINGS_THIRD_PITCH)
	
		describe(Pitchers$HARD_CONTACT_THIRD_PITCH)	
			boxplot(Pitchers$HARD_CONTACT_THIRD_PITCH, main = "3rd Pitch Hard Contact Against")
			hist(Pitchers$HARD_CONTACT_THIRD_PITCH)
	
	///
		# Fourth Pitch
		describe(Pitchers$FOURTH_PITCH_VELO_MIN)
			boxplot(Pitchers$FOURTH_PITCH_VELO_MIN, main = "4th Pitch Min Velo")
			hist(Pitchers$FOURTH_PITCH_VELO_MIN)
	
		describe(Pitchers$FOURTH_PITCH_VELO_MAX)
			boxplot(Pitchers$FOURTH_PITCH_VELO_MAX, main = "4th Pitch Max velo")
			hist(Pitchers$FOURTH_PITCH_VELO_MAX)
	
		describe(Pitchers$SWING_FOURTH)
			boxplot(Pitchers$SWING_FOURTH, main = "4th Pitch Swings")
			hist(Pitchers$SWING_FOURTH)
	
		describe(Pitchers$SWING_MISS_FOURTH)
			boxplot(Pitchers$SWING_MISS_FOURTH, main = "4th Pitch Whiffs")
			hist(Pitchers$SWING_MISS_FOURTH)
	
		describe(Pitchers$CHASE_FOURTH)
			boxplot(Pitchers$CHASE_FOURTH, main = "4th Pitch Chase Swings")
			hist(Pitchers$CHASE_FOURTH)
	
		describe(Pitchers$HARD_FOURTH)
			boxplot(Pitchers$HARD_FOURTH, main = "4th Pitch Hard Contact Against")
			hist(Pitchers$HARD_FOURTH)
	
	
	##### Position Players Data Check #####
		# Boxscore and Player Info
		Position_Players$WEIGHT_LBS <- as.numeric(Position_Players$WEIGHT_LBS)
		describe(Position_Players$WEIGHT_LBS)
			boxplot(Position_Players$WEIGHT_LBS, main = "Position Player Weight")
			hist(Position_Players$WEIGHT_LBS)
	
		Position_Players$HEIGHT_IN <- as.numeric(Position_Players$HEIGHT_IN)	
		describe(Position_Players$HEIGHT_IN)
			boxplot(Position_Players$HEIGHT_IN, main = "Position Player Height")
			hist(Position_Players$HEIGHT_IN)
	
		Position_Players$BP_HOME_RUNS_MIDDLE <- as.numeric(Position_Players$BP_HOME_RUNS_MIDDLE)
			describe(Position_Players$BP_HOME_RUNS_MIDDLE)
			boxplot(Position_Players$BP_HOME_RUNS_MIDDLE, main = "Position Player BP HR Middle")
			hist(Position_Players$BP_HOME_RUNS_MIDDLE)
	
		Position_Players$BP_HOME_RUNS_OPPOSITE_FIELD <- as.numeric(Position_Players$BP_HOME_RUNS_OPPOSITE_FIELD)
			describe(Position_Players$BP_HOME_RUNS_OPPOSITE_FIELD)
			boxplot(Position_Players$BP_HOME_RUNS_OPPOSITE_FIELD, main = "Position Player BP HR Oppo")
			hist(Position_Players$BP_HOME_RUNS_OPPOSITE_FIELD)
	
		Position_Players$BP_HOME_RUNS_PULL <- as.numeric(Position_Players$BP_HOME_RUNS_PULL)
			describe(Position_Players$BP_HOME_RUNS_PULL)
			boxplot(Position_Players$BP_HOME_RUNS_PULL, main = "Position Player BP HR Pull")
			hist(Position_Players$BP_HOME_RUNS_PULL)
	
		Position_Players$WALKS <- as.numeric(Position_Players$WALKS)
			describe(Position_Players$WALKS)
			boxplot(Position_Players$WALKS, main = "Position Player Walks")
			hist(Position_Players$WALKS)
	
		Position_Players$HITS <- as.numeric(Position_Players$HITS)
			describe(Position_Players$HITS)
			boxplot(Position_Players$HITS, main = "Position Player Hits")
			hist(Position_Players$HITS)
			
		Position_Players$RUNS <- as.numeric(Position_Players$RUNS)
			describe(Position_Players$RUNS)
			boxplot(Position_Players$RUNS, main = "Position Player Runs")
			hist(Position_Players$RUNS)
	
		describe(Position_Players$STOLEN_BASES)
			boxplot(Position_Players$STOLEN_BASES, main = "Position Player Stolen Bases")
			hist(Position_Players$STOLEN_BASES)
	
		describe(Position_Players$RBIS)
			boxplot(Position_Players$RBIS, main = "Position Player RBIs")
			hist(Position_Players$RBIS)
	
		describe(Position_Players$HOME_1ST_TIME)
			boxplot(Position_Players$HOME_1ST_TIME, main = "Position Player Home/1st Times")
			hist(Position_Players$HOME_1ST_TIME)
	
		# Position Player Plate Appearance / Swing Data
		describe(Position_Players$SWING_AND_MISSES)
			boxplot(Position_Players$SWING_AND_MISSES, main = "Position Player Swings & Misses")
			hist(Position_Players$SWING_AND_MISSES)
	
		describe(Position_Players$CHASE_SWINGS)
			boxplot(Position_Players$CHASE_SWINGS, main = "Position Player Chase Swings")
			hist(Position_Players$CHASE_SWINGS)
	
		describe(Position_Players$SWINGS_FB)
			boxplot(Position_Players$SWINGS_FB, main = "Position Player Swings (Fastballs Only)")
			hist(Position_Players$SWINGS_FB)
	
		describe(Position_Players$LENGTH_OF_AT_BAT_PITCHES)
			boxplot(Position_Players$LENGTH_OF_AT_BAT_PITCHES, main = "Position Player Length of At Bat (Pitches)")
			hist(Position_Players$LENGTH_OF_AT_BAT_PITCHES)
	
		describe(Position_Players$HARD_CONTACT_PULL_SIDE)
			boxplot(Position_Players$HARD_CONTACT_PULL_SIDE, main = "Position Player Hard Contact (Pull)")
			hist(Position_Players$HARD_CONTACT_PULL_SIDE)
	
		describe(Position_Players$HARD_CONTACT_OPPOSITE_FIELD)
			boxplot(Position_Players$HARD_CONTACT_OPPOSITE_FIELD, main = "Position Player Hard Contact (Opposite Field)")
			hist(Position_Players$HARD_CONTACT_OPPOSITE_FIELD)
	
		describe(Position_Players$HARD_CONTACT_MIDDLE)
			boxplot(Position_Players$HARD_CONTACT_MIDDLE, main = "Position Player Hard Contact (Middle)")
			hist(Position_Players$HARD_CONTACT_MIDDLE)
	
		# Position Player Defensive Stats
		Position_Players$ABOVE_AVERAGE_DEFENSIVE_PLAYS <- as.numeric(Position_Players$ABOVE_AVERAGE_DEFENSIVE_PLAYS)
			describe(Position_Players$ABOVE_AVERAGE_DEFENSIVE_PLAYS)
			boxplot(Position_Players$ABOVE_AVERAGE_DEFENSIVE_PLAYS, main = "Position Player Above Avg. Defensive Plays")
			hist(Position_Players$ABOVE_AVERAGE_DEFENSIVE_PLAYS)
	
		Position_Players$ERRORS_COMMITTED <- as.numeric(Position_Players$ERRORS_COMMITTED)
			describe(Position_Players$ERRORS_COMMITTED)
			boxplot(Position_Players$ERRORS_COMMITTED, main = "Position Player Errors Committed")
			hist(Position_Players$ERRORS_COMMITTED)
	
	
	
	
	
	
	