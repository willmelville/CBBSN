# Gather duplicates
#names(Position_Players)
#Position_Players_Unique <- Position_Players[duplicated(Position_Players[,c('FIRST_NAME', 'LAST_NAME', 'PLAYER_SCHOOL')])]
#Pitchers_Unique <- Pitchers[!duplicated(Pitchers[c('Name', 'PLAYER_SCOUT', 'PLAYER_SCHOOL')]),]


# Creating new variables to summarize grades
///
	# Position Players
	Position_Players$CUM_GRADE_PRES <- rowMeans(Position_Players[,c("PRESENT_HITTING",
													    "PRESENT_ARM", 
													    "PRESENT_FIELDING", 
											              "PRESENT_RUNNING", 
											 	   	    "PRESENT_POWER")], na.rm = TRUE)

	Position_Players$CUM_GRADE_FUT <- rowMeans(Position_Players[,c("FUTURE_HITTING", 
												        "FUTURE_ARM", 
												        "FUTURE_FIELDING", 
												        "FUTURE_RUNNING", 
												        "FUTURE_POWER")], na.rm = TRUE)
	
	# Pitchers
	# Having issues with this, since a lot of pitchers have NA for some of these categories the rowMeans is returning NA
	Pitchers$CUM_GRADE_PRES <- rowMeans(Pitchers[,c("PRESENT_FASTBALL_GRADE_20_80",
										   "PRESENT_CURVE_GRADE_20_80",
										   "PRESENT_SLIDER_GRADE_20_80",
										   "PRESENT_CHANGE_GRADE_20_80",
										   "PRESENT_CONTROL_GRADE_20_80")], na.rm = TRUE)
	
	Pitchers$CUM_GRADE_FUT <- rowMeans(Pitchers[,c("FUTURE_FASTBALL_GRADE_20_80",
										  "FUTURE_CURVE_GRADE_20_80",
										  "FUTURE_SLIDER_GRADE_20_80",
										  "FUTURE_CHANGE_GRADE_20_80",
										  "FUTURE_CONTROL_GRADE_20_80")], na.rm = TRUE)

#Position_Players$CUM_GRADE_PRES <- as.numeric(Position_Players$CUM_GRADE_PRES)
#Position_Players$CUM_GRADE_FUT <- as.numeric(Position_Players$CUM_GRADE_FUT)
#Pitchers$CUM_GRADE_PRES <- as.numeric(Position_Players$CUM_GRADE_PRES)
#Pitchers$CUM_GRADE_FUT <- as.numeric(Position_Players$CUM_GRADE_FUT)


# mean(Position_Players$CUM_GRADE_PRES, na.rm = TRUE)
# 	hist(Position_Players$CUM_GRADE_PRES)
# 	plot(density(Position_Players$CUM_GRADE_PRES, na.rm = TRUE))
# mean(Position_Players$CUM_GRADE_FUT, na.rm = TRUE)
# 	hist(Position_Players$CUM_GRADE_FUT)
# 	plot(density(Position_Players$CUM_GRADE_FUT, na.rm = TRUE))
# mean(Pitchers$CUM_GRADE_PRES, na.rm = TRUE)
# 	hist(Pitchers$CUM_GRADE_PRES)
# 	plot(density(Pitchers$CUM_GRADE_PRES, na.rm = TRUE))
# mean(Pitchers$CUM_GRADE_FUT, na.rm = TRUE)
# 	hist(Pitchers$CUM_GRADE_FUT)
# 	plot(density(Pitchers$CUM_GRADE_FUT, na.rm = TRUE))

# New data point for OFP difference
Position_Players$NET_GRADE_DIFF <- NA
	Position_Players$NET_GRADE_DIFF <- Position_Players$CUM_GRADE_FUT - Position_Players$CUM_GRADE_PRES
	hist(Position_Players$NET_GRADE_DIFF)
	boxplot(Position_Players$NET_GRADE_DIFF)
	kurtosis(Position_Players$NET_GRADE_DIFF, na.rm = TRUE)
	
Pitchers$NET_GRADE_DIFF <- NA
	Pitchers$NET_GRADE_DIFF <- Pitchers$CUM_GRADE_FUT - Pitchers$CUM_GRADE_PRES
	hist(Pitchers$NET_GRADE_DIFF)
	boxplot(Pitchers$NET_GRADE_DIFF)
	kurtosis(Pitchers$NET_GRADE_DIFF, na.rm = TRUE)

	
	# ### Sample Plot for Single Player Grade Differences ###
	# 	plot(Pitchers$CUM_GRADE_FUT[Pitchers$Name == "Gunner Deal"], Pitchers$CUM_GRADE_PRES[Pitchers$Name == "Gunner Deal"],
	# 		text(Pitchers$CUM_GRADE_FUT[Pitchers$Name == "Gunner Deal"], Pitchers$CUM_GRADE_PRES[Pitchers$Name == "Gunner Deal"],
	# 			labels=Pitchers$SCOUT_NAME[Pitchers$Name == "Gunner Deal"]))


##### Duplicate Position Players ######		

	# Create subset for duplicated Position Players (based on created Name string in excel)
	Dup_Batters <- Position_Players[Position_Players$Name %in% Position_Players$Name[duplicated(Position_Players$Name)],]
	head(Dup_Batters)

	# Create unique ID for each position player
	# Dup_Batters <- transform(Dup_Batters,id=as.numeric(
	# 	factor(Dup_Batters$Name)))
	# 
	 TY_B <- subset(Dup_Batters, SCOUT_NAME == "Caleb Watkins")
	 TY_P <- subset(Dup_Pitchers, SCOUT_NAME == "Caleb Watkins")
	# ///
	

		 CW1 <- subset(Dup_Batters, Name == "Griffin Paxton -- McLennan Community College")
		 CW2 <- subset(Dup_Batters, Name == "Laine Huffman -- Long Beach State University")
		 CW3 <- subset(Dup_Batters, Name =="Marty Bechina -- Michigan State University")
		 CW4 <- subset(Dup_Batters, Name =="Davis Wendzel -- Baylor University")
		 CW5 <- subset(Dup_Batters, Name =="Andy Thomas -- Baylor University")
		 
	R_LIP <- subset(Pitchers, SCOUT_NAME == "Robert_Lippert")

		
	# Plot the Basic Rating for each id
	# plot(Dup_Batters$CUM_GRADE_PRES, Dup_Batters$CUM_GRADE_FUT,
	# 	text(Dup_Batters$id, Dup_Batters$Name,
	# 		labels = c(Dup_Batters$SCOUT_NAME, Dup_Batters$Name)))

		# Comparative scatter plot (CUM_GRADE)
		plotly::plot_ly(data = Dup_Batters, x = Dup_Batters$Name, y = Dup_Batters$CUM_GRADE_PRES,
			 color = Dup_Batters$SCOUT_NAME, mode = "markers", type = "scatter")
		
		# Comparative bar chart (CUM_GRADE)
		plotly::plot_ly(data = Dup_Batters, x = Dup_Batters$Name, y = Dup_Batters$CUM_GRADE_PRES,
					 color = Dup_Batters$SCOUT_NAME, mode = "markers")
	
	  		
		
		# Comparative scatter plot (CUM_GRADE_FUT)
		plotly::plot_ly(data = Dup_Batters, x = Dup_Batters$Name, y = Dup_Batters$CUM_GRADE_FUT,
					 color = Dup_Batters$SCOUT_NAME, mode = "markers", type = "scatter")

		# Comparative bar chart (CUM_GRADE_FUT)
		plotly::plot_ly(data = Dup_Batters, x = Dup_Batters$Name, y = Dup_Batters$CUM_GRADE_FUT,
					 color = Dup_Batters$SCOUT_NAME)
		
		# Check for Home/1st time differences
		plotly::plot_ly(data = Dup_Batters, x = Dup_Batters$Name, y = Dup_Batters$HOME_1ST_TIME,
					 color = Dup_Batters$SCOUT_NAME, mode = "markers", type = "scatter")

		
##### Duplicate Pitchers ######		
		# Create subset for duplicated Pitchers (based on created Name string in excel)
		Dup_Pitchers <- Pitchers[Pitchers$Name %in% Pitchers$Name[duplicated(Pitchers$Name)],]
		
		
		# Create unique ID for each pitcher
		Dup_Pitchers <- transform(Dup_Pitchers,id=as.numeric(
			factor(Dup_Pitchers$Name)))
	///
		
		# Plot the Basic Rating for each id
		# plot(Dup_Pitchers$id, Dup_Pitchers$CUM_GRADE_PRES,
		# 	text(Dup_Pitchers$SCOUT_NAME, Dup_Pitchers$Name,
		# 		labels = c(Dup_Pitchers$SCOUT_NAME, Dup_Pitchers$Name)))

		# Comparative scatter plot (CUM_GRADE)
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$CUM_GRADE_PRES,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		# Comparative bar chart (CUM_GRADE)
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$CUM_GRADE,
					 color = Dup_Pitchers$SCOUT_NAME)
		
		# Comparative scatter plot (CUM_GRADE_FUT)
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$CUM_GRADE_FUT,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		# Comparative bar chart (CUM_GRADE_FUT)
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$CUM_GRADE_FUT,
					 color = Dup_Pitchers$SCOUT_NAME)		

		# Velo Comps
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$FASTBALL_VELO_MAX,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$BREAKING_BALL_VELO_MAX,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$THIRD_PITCH_VELO_MAX,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$FOURTH_PITCH_VELO_MAX,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		plotly::plot_ly(data = Dup_Pitchers, x = Dup_Pitchers$Name, y = Dup_Pitchers$FB_Diff,
					 color = Dup_Pitchers$SCOUT_NAME, mode = "markers", type = "scatter")
		
		
		