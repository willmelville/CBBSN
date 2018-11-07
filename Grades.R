#####Grade Differences 
////
	# If negative value or extreme difference, check row and contact RM/ARM *** 
	##### Pitchers Grade Differences ####
Pitchers$FBGRADE_DIFF<-NA
Pitchers$FBGRADE_DIFF <- Pitchers$FUTURE_FASTBALL_GRADE_20_80-Pitchers$PRESENT_FASTBALL_GRADE_20_80
boxplot(Pitchers$FBGRADE_DIFF)
hist(Pitchers$FBGRADE_DIFF)
plotly::plot_ly(data = Pitchers,
			 y = Pitchers$FUTURE_FASTBALL_GRADE_20_80,
			 x = Pitchers$PRESENT_FASTBALL_GRADE_20_80,
			 type = "scatter", mode = "markers", color = Pitchers$Name, opacity = .5)

Pitchers$CUGRADE_DIFF<-NA
Pitchers$CUGRADE_DIFF <- Pitchers$FUTURE_CURVE_GRADE_20_80-Pitchers$PRESENT_CURVE_GRADE_20_80
boxplot(Pitchers$CUGRADE_DIFF)
hist(Pitchers$CUGRADE_DIFF)
plotly::plot_ly(data = Pitchers,
			 y = Pitchers$FUTURE_CURVE_GRADE_20_80,
			 x = Pitchers$PRESENT_CURVE_GRADE_20_80,
			 type = "scatter", mode = "markers", color = Pitchers$Name, opacity = .5)

Pitchers$SLGRADE_DIFF<-NA
Pitchers$SLGRADE_DIFF <- Pitchers$FUTURE_SLIDER_GRADE_20_80-Pitchers$PRESENT_SLIDER_GRADE_20_80
boxplot(Pitchers$SLGRADE_DIFF)
hist(Pitchers$SLGRADE_DIFF)
plotly::plot_ly(data = Pitchers,
			 y = Pitchers$FUTURE_SLIDER_GRADE_20_80,
			 x = Pitchers$PRESENT_SLIDER_GRADE_20_80,
			 type = "scatter", mode = "markers", color = Pitchers$Name, opacity = .5)

Pitchers$CHGRADE_DIFF<-NA
Pitchers$CHGRADE_DIFF <- Pitchers$FUTURE_CHANGE_GRADE_20_80-Pitchers$PRESENT_CHANGE_GRADE_20_80
boxplot(Pitchers$CHGRADE_DIFF)
hist(Pitchers$CHGRADE_DIFF)
plotly::plot_ly(data = Pitchers,
			 y = Pitchers$FUTURE_CHANGE_GRADE_20_80,
			 x = Pitchers$PRESENT_CHANGE_GRADE_20_80,
			 type = "scatter", mode = "markers", color = Pitchers$Name, opacity = .5)

Pitchers$CTRLGRADE_DIFF<-NA
Pitchers$CTRLGRADE_DIFF <- Pitchers$FUTURE_CONTROL_GRADE_20_80-Pitchers$PRESENT_CONTROL_GRADE_20_80
boxplot(Pitchers$CTRLGRADE_DIFF)
hist(Pitchers$CTRLGRADE_DIFF)
plotly::plot_ly(data = Pitchers,
			 y = Pitchers$FUTURE_CONTROL_GRADE_20_80,
			 x = Pitchers$PRESENT_CONTROL_GRADE_20_80,
			 type = "scatter", mode = "markers", color = Pitchers$Name, opacity = .5)


##### Position Players Grade Differences ####
///
	# Position Players (If negative value or extreme difference, check row and contact RM/ARM)
		#****If grades look questionable include it in weekly email with image of plot and highlight
			# also please markup (circle) the anomalous data point in email
Position_Players$HIT_DIFF <- NA
Position_Players$HIT_DIFF <- Position_Players$FUTURE_HITTING-Position_Players$PRESENT_HITTING
boxplot(Position_Players$HIT_DIFF)
hist(Position_Players$HIT_DIFF)
plotly::plot_ly(data = Position_Players,
			 y = Position_Players$FUTURE_HITTING,
			 x = Position_Players$PRESENT_HITTING,
			 type = "scatter", mode = "markers", color = Position_Players$Name, opacity = .5)

Position_Players$POWER_DIFF <- NA
Position_Players$POWER_DIFF <- Position_Players$FUTURE_POWER-Position_Players$PRESENT_POWER
boxplot(Position_Players$POWER_DIFF)
hist(Position_Players$POWER_DIFF)
plotly::plot_ly(data = Position_Players,
			 y = Position_Players$FUTURE_POWER,
			 x = Position_Players$PRESENT_POWER,
			 type = "scatter", mode = "markers", color = Position_Players$Name, opacity = .5)

Position_Players$ARM_DIFF <- NA
Position_Players$ARM_DIFF <- Position_Players$FUTURE_ARM-Position_Players$PRESENT_ARM
boxplot(Position_Players$ARM_DIFF)
hist(Position_Players$ARM_DIFF)
plotly::plot_ly(data = Position_Players,
			 y = Position_Players$FUTURE_ARM,
			 x = Position_Players$PRESENT_ARM,
			 type = "scatter", mode = "markers", color = Position_Players$Name, opacity = .5)

Position_Players$FIELD_DIFF <- NA
Position_Players$FIELD_DIFF <- Position_Players$FUTURE_FIELDING-Position_Players$PRESENT_FIELDING
boxplot(Position_Players$FIELD_DIFF)
hist(Position_Players$FIELD_DIFF)
plotly::plot_ly(data = Position_Players,
			 y = Position_Players$FUTURE_FIELDING,
			 x = Position_Players$PRESENT_FIELDING,
			 type = "scatter", mode = "markers", color = Position_Players$Name, opacity = .5)

Position_Players$RUN_DIFF <- NA
Position_Players$RUN_DIFF <- Position_Players$FUTURE_RUNNING-Position_Players$PRESENT_RUNNING
boxplot(Position_Players$RUN_DIFF)
hist(Position_Players$RUN_DIFF)
plotly::plot_ly(data = Position_Players,
			 y = Position_Players$FUTURE_RUNNING,
			 x = Position_Players$PRESENT_RUNNING,
			 type = "scatter", mode = "markers", color = Position_Players$Name, opacity = .5)
