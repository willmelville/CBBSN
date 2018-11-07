library(readr)
library(dplyr)
Draftees <- read_csv("~/Desktop/Draftees.csv")
View(Draftees)


summary(Draftees)
names(Draftees)

Pitchers$Dollars <- NA
Pitchers$Dollars <- as.numeric(Pitchers$Dollars)
Pitchers$BONUS <- as.numeric(Pitchers$BONUS)
Pitchers$Dollars <- scale(Pitchers$BONUS, scale = FALSE)
Pitchers$Strikeouts <- scale(Pitchers$SO9, scale = FALSE)

sample <- sample.int(n = nrow(Pitchers), size = floor(.5*nrow(Pitchers)), replace = FALSE)
training_data <- Pitchers[sample, ]
validation_data <- Pitchers[-sample, ]


# Strikeouts have a NEGATIVE coefficient on Bonus money earned!
#
glm1 <- glm(data = Pitchers, Dollars ~ SO)
summary(glm1)



# Lets try with more variables
glm2 <- glm(data = Pitchers, Dollars ~ SO9 + W + L + ERA + factor(Conference))
summary(glm2)
# Big conferences are getting bigger deals, on average. 

# Are teams solely relying on scouting? Are they investing enough in data analysis at the Rule 4 Draft level 


# Does draft position matter?
glm3 <- glm(data = Pitchers, PICK ~ SO + W + L + ERA + factor(Conference))
summary(glm3)


glm4 <- glm(data = Pitchers, Dollars ~ Pitchers$`FIP(-HBP)`)
summary(glm4)



# Do strikeouts depend on the Conference?
library(lmerTest)
mixed_draft <- lmer(Dollars ~ Pitchers$GS + W + L + BB + SO +
			    	(1+SO9|Conference) + (1+SO|Conference),
			    data = Pitchers)
summary(mixed_draft)
coef(mixed_draft)




mixed_draft <- lmer(Dollars ~ training_data$GS + W + L + BB + SO +
					(1+SO9|Conference) + (1+SO|Conference),
				data = training_data)
summary(mixed_draft)
coef(mixed_draft)

validation_data$predicted_price <- NA
validation_data$predicted_price <- predict(mixed_draft, newdata=validation_data, allow.new.levels = TRUE)
plot(validation_data$predicted_price, validation_data$BONUS)
	


validation_data$predicted_price <- predict(glm2, newdata=validation_data, allow.new.levels = TRUE)
plot(validation_data$predicted_price, validation_data$BONUS)

