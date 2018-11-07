# Rename drafted? column
colnames(draft_18_hitters)[53] <- "drafted"
colnames(draft_18_pitchers)[75] <- "drafted"

### Run fix_conference code

head(draft_18_hitters)
head(draft_18_pitchers)

library(psych)
psych::describe(draft_18_hitters$Round)
describe(draft_18_hitters$Pick_Number)
describe(draft_18_hitters$Bonus)

describe(draft_18_pitchers$Round)
describe(draft_18_pitchers$Pick_Number)
describe(draft_18_pitchers$Bonus)

# plot pick_number (x) & signing_bonus (y)
signed_hitters = subset(draft_18_hitters, draft_18_hitters$Bonus > 0)
signed_pitchers = subset(draft_18_pitchers, draft_18_pitchers$Bonus > 0)
plot(signed_hitters$Pick_Number, signed_hitters$Bonus)
plot(signed_pitchers$Pick_Number, signed_pitchers$Bonus)

# models to find whether drafted/not
	# Interested in variables (hitters):
		# Home_1st_Time
m1 <- glm(data = draft_18_hitters, draft_18_hitters$`Drafted?` ~ HOME_1ST_TIME, family = "binomial")
summary(m1)
		# Height
		# Weight (possibly interacted with height?)
		# Position -- fixed effect?
		# Conference -- fixed?
		# Division -- fixed?
		# Hard Contact Total (make Hard_Contact column summing the pull/mid/oppo)
		# Above Avg. Defensive Plays
		# Errors
		# Grades
	# Interested in variables (pitchers):
		# Throwing side interacted with everything
		# Height
		# Weight(interacted with height?)
		# Pitches Total? Starter vs. Reliever
		# Stolen bases allowed
		# STRIKE_BALL_PCT
		# Hits allowed total (make Hits column summing the left/mid/right)
		# FB velo Max (group_by school and name, average fastball velo max)
		# Swings and misses FB
		# Hard contact FB
		# Whethere they have a 4th pitch or not (Binary for if min velo > 0)
		# Grades
		

