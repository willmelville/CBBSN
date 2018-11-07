

---
	#title: "Scrape NCAA Website for Individual College Stats"
	
	#This code will scrape batting and pitching stats from the NCAA website for all      #division 1 schools
	
	
	```{r}
#Load required packages
#require(baseballr)
install.packages("dplyr")
install.packages("xml2")
install.packages("rvest")
install.packages("proto")
install.packages("gsubfn")
install.packages("sqldf")
install.packages("rJava")
install.packages("xlsxjars")
install.packages("xlsx")

require(dplyr)
require(rvest)
require(xml2)
require(gsubfn)
require(proto)
require(sqldf)
require(rJava)
require(xlsxjars)
require(xlsx)

```


#Create Master Batting Tables using Cincinnati
```{r}

#Enter Team and code
y <- 140
c <- "AAC"
s <- "Cincinnati"

b_2018 <- paste0("http://stats.ncaa.org/team/", y,"/stats/12973")
b_2017 <- paste0("http://stats.ncaa.org/team/", y,"/stats/12560")
b_2016 <- paste0("http://stats.ncaa.org/team/", y,"/stats?game_sport_year_ctl_id=12360&id=12360")
b_2015 <- paste0("http://stats.ncaa.org/team/", y,"/stats?game_sport_year_ctl_id=12080&id=12080")



#2018 totals
url <- b_2018
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)


batting_2018 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")

batting_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2018")

batting_2018r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2018")

batting_2018 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2018r group by player order by wOBA desc")




#2017 totals
url <- b_2017
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)


batting_2017 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")

batting_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2017")

batting_2017r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2017")

batting_2017 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2017r group by player order by wOBA desc")


#2016 totals
url <- b_2016
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)


batting_2016 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")

batting_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2016")

batting_2016r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2016")

batting_2016 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2016r group by player order by wOBA desc")

#2015 totals
url <- b_2015
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)


batting_2015 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")

batting_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2015")

batting_2015r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2015")

batting_2015 <-sqldf("select player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2015r group by player order by wOBA desc")



#Get career totals

batting_total_r <- sqldf("select b18.player, b18.Jersey, b18.Yr, b18.Pos, b18.GP, case when b18.GS IS NULL THEN 0 ELSE b18.GS END AS GS, b18.PA, b18.AB, b18.H, b18.BB, b18.K, b18.[1B], b18.[2B], b18.[3B], b18.HR, b18.HBP, b18.SH, b18.SF, b18.CS, b18.SB from batting_2018r b18 left outer join batting_2017r b17 on b18.player = b17.player 
					UNION select b17.player, b17.Jersey, b17.Yr, b17.Pos, b17.GP, case when b17.GS IS NULL THEN 0 ELSE b17.GS END AS GS, b17.PA, b17.AB, b17.H, b17.BB, b17.K, b17.[1B], b17.[2B], b17.[3B], b17.HR, b17.HBP, b17.SH, b17.SF, b17.CS, b17.SB from batting_2017r b17 left outer join batting_2018r b18 on b18.player = b17.player 
					UNION select b16.player, b16.Jersey, b16.Yr, b16.Pos, b16.GP, case when b16.GS IS NULL THEN 0 ELSE b16.GS END AS GS, b16.PA, b16.AB, b16.H, b16.BB, b16.K, b16.[1B], b16.[2B], b16.[3B], b16.HR, b16.HBP, b16.SH, b16.SF, b16.CS, b16.SB from batting_2016r b16 left outer join batting_2018r b18 on b18.player = b16.player
					UNION select b15.player, b15.Jersey, b15.Yr, b15.Pos, b15.GP, case when b15.GS IS NULL THEN 0 ELSE b15.GS END AS GS, b15.PA, b15.AB, b15.H, b15.BB, b15.K, b15.[1B], b15.[2B], b15.[3B], b15.HR, b15.HBP, b15.SH, b15.SF, b15.CS, b15.SB from batting_2015r b15 left outer join batting_2018r b18 on b18.player = b15.player")


batting_total_r1 <- sqldf("select Player, max(Jersey) AS Jersey, max(yr) AS Yr, POS, SUM(GP) AS GP, SUM(GS) AS GS, SUM(PA) PA, SUM(AB) AB, SUM(H) H, SUM(BB) BB, SUM(K) K, SUM([1B]) [1B], SUM([2B]) [2B], SUM([3B]) [3B], SUM(HR) HR, SUM(HBP) HBP, SUM(SH) SH, SUM(SF) SF, SUM(CS) CS, SUM(SB) SB  FROM batting_total_r WHERE PA > 0  group by Player")

batting_total <- sqldf("select player, Jersey, Yr, Pos, GP, GS, PA, ROUND(cast(H AS float) /AB, 3) AVG, ROUND(((cast(H+BB+HBP AS float)) / (AB + BB + HBP + SF +SH)),3) OBP, ROUND(((([1B]) + ([2B] * 2) + ([3B]* 3) + ([HR]* 4)) / (cast(AB AS float))),3) SLG, ROUND(((([1B]) + ([2B] * 2) + ([3B]* 3) + ([HR]* 4)) / (cast(AB AS float))) - (cast(H AS float) /AB), 3) ISO, HR, SB, SB + CS AS SBA,  ROUND((cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100,2) [K%], ROUND((cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100,2) [BB%], ROUND((H-HR) / (AB-cast(K AS float)-HR+SF),3) BABIP, ROUND((sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)),3) wOBA from batting_total_r1 group by player order by Jersey desc")


#Get Players from 2018 teams
b_Players <- sqldf("select Player FROM batting_2018r")

batting_career <- sqldf("select * FROM batting_total WHERE player IN b_Players ORDER BY PA DESC")


#Get Current year for players and sort
batting_career_master <- sqldf(paste0("select b.player, '", c ,"' AS Conference , '", s ,"' AS School ,b18.Yr, b.Pos, b.PA, b.AVG, b.OBP, b.SLG, b.HR, b.ISO, b.SB, b.SBA, b.[K%], b.[BB%], b.BABIP, b.wOBA  FROM batting_career b JOIN batting_2018 b18 ON b.Player = b18.Player group by b.Player order by b.PA desc"))

batting_2018_master <-sqldf(paste0("select player,  '", c ,"' AS Conference , '", s ,"' AS School, Yr, Pos, (AB+BB+HBP+SF+SH) AS PA, ROUND(BA,3) AVG, ROUND(OBP,3) OBP, ROUND(SLG,3) SLG, HR, ROUND((SLG-BA), 3) ISO, SB, SBA, ROUND(Kpct,2) AS [K%], ROUND(BBpct,2) AS [BB%], ROUND(BABIP,3) BABIP,  ROUND(wOBA,3) wOBA from batting_2018 where PA > 0 order by PA desc"))
```




#Get Batting Stats for all other schools and add to Master Tables
```{r}

#removed 86 (Buffalo) - No 2018 Stats

for(y in c(196,164,288,404,651,718,128,28755,316,1157,28600,471,2711,678,10411,14,62,272,380,683,391,368,173,175,236,249,248,340,400,572,575,606,609,596,740,67,147,193,234,255,367,415,457,490,513,746,545,742,749,51,328,327,522,521,698,703,700,768,87,169,251,635,603,739,812,115,48,1092,19651,355,363,1320,563,456,792,301,306,312,392,418,416,428,463,509,518,539,559,587,101,90,97,277,99,108,109,111,104,1014,180,1068,283,317,500,711,460,786,458,231,229,366,388,419,523,574,664,9,706,772,302,797,505,514,735,810,817,80,158,167,172,275,540,554,813,116,220,310,381,386,439,482,562,576,617,639,47,71,129,204,331,414,503,519,709,774,61,165,178,228,488,489,485,632,393,72,1045,219,299,305,669,659,782,721,96,466,473,626,630,465,81,127,222,361,450,590,748,43,14927,201,202,315,444,454,660,654,692,695,29,28,107,529,528,657,674,110,732,756,754,725,83,285,342,352,726,8,31,37,235,257,334,365,430,434,433,648,694,697,736,198,244,406,625,141,459,741,769,2915,26172,2,1004,287,2743,346,402,474,483,508,676,624,655,6,7,17,2678,261,314,432,553,665,699,308,493,464,527,649,771,27,30,149,253,254,498,32,671,646,670,716,702,77,260,370,534,541,551,610,627,629,631,94,136,1104,472,502,102,1356,536,30024)) {
	
	if (y %in% c(196,164,288,404,651,718,128)) {c = "AAC"}
	if (y %in% c(28755,316,1157,28600,471,2711,678,10411)) {c = "ASUN"}
	if (y %in% c(14,62,272,380,683,391,368)) {c = "American East"}
	if (y %in% c(173,175,236,249,248,340,400,572,575,606,609,596,740)) {c = "Atlantic 10"}
	if (y %in% c(67,147,193,234,255,367,415,457,490,513,746,545,742,749)) {c = "ACC"}
	if (y %in% c(51,328,327,522,521,698,703,700,768)) {c = "Big 12"}
	if (y %in% c(87,169,251,635,603,739,812)) {c = "Big East"}
	if (y %in% c(115,48,1092,19651,355,363,1320,563,456,792)) {c = "Big South"}
	if (y %in% c(301,306,312,392,418,416,428,463,509,518,539,559,587)) {c = "Big 10"}
	if (y %in% c(101,90,97,277,99,108,109,111,104)) {c = "Big West"}
	if (y %in% c(1014,180,1068,283,317,500,711,460,786)) {c = "Colonial"}
	if (y %in% c(458,231,229,366,388,419,523,574,664,9,706,772)) {c = "Conference USA"}
	if (y %in% c(302,797,505,514,735,810,817)) {c = "Horizon"}
	if (y %in% c(80,158,167,172,275,540,554,813)) {c = "Ive League"}
	if (y %in% c(116,220,310,381,386,439,482,562,576,617,639)) {c = "Metro Atlantic"}
	if (y %in% c(47,71,86,129,204,331,414,503,519,709,774)) {c = "Mid American"}
	if (y %in% c(61,165,178,228,488,489,485,632,393)) {c = "Mid-Eastern"}
	if (y %in% c(72,1045,219,299,305,669,659,782)) {c = "Missouri Valley"}
	if (y %in% c(721,96,466,473,626,630,465)) {c = "Mountain West"}
	if (y %in% c(81,127,222,361,450,590,748)) {c = "Northeast"}
	if (y %in% c(43,14927,201,202,315,444,454,660,654,692,695)) {c = "OVC"}
	if (y %in% c(29,28,107,529,528,657,674,110,732,756,754)) {c = "Pac 12"}
	if (y %in% c(725,83,285,342,352,726)) {c = "Patriot"}
	if (y %in% c(8,31,37,235,257,334,365,430,434,433,648,694,697,736)) {c = "SEC"}
	if (y %in% c(198,244,406,625,141,459,741,769,2915)) {c = "Southern"}
	if (y %in% c(26172,2,1004,287,2743,346,402,474,483,508,676,624,655)) {c = "Southland"}
	if (y %in% c(6,7,17,2678,261,314,432,553,665,699)) {c = "Southwestern"}
	if (y %in% c(308,493,464,527,649,771)) {c = "Summit League"}
	if (y %in% c(27,30,149,253,254,498,32,671,646,670,716,702)) {c = "Sun Belt"}
	if (y %in% c(77,260,370,534,541,551,610,627,629,631)) {c = "West Coast"}
	if (y %in% c(94,136,1104,472,502,102,1356,536,30024)) {c = "Western Athletic"}
	
	
	#AAC
	if (y == 196) {s = "East Carolina"} 
	if (y == 164) {s = "UConn"}
	if (y == 288) {s = "Houston"}
	if (y == 404) {s = "Memphis"}
	if (y == 651) {s = "USF"}
	if (y == 718) {s = "Tulane"}
	if (y == 128) {s = "UCF"}
	
	#ASUN
	if (y == 28755) {s = "FGCU"}
	if (y == 316) {s = "Jacksonville"}
	if (y == 1157) {s = "Kennesaw State"}
	if (y == 28600) {s = "Lipscomb"}
	if (y == 471) {s = "NJIT"}
	if (y == 2711) {s = "North Florida"}
	if (y == 678) {s = "Stetson"}
	if (y == 10411) {s = "USC Upstate"}
	
	#American East
	if (y == 14) {s = "Albany (NY)"}
	if (y == 62) {s = "Binghamton"}
	if (y == 272) {s = "Hartford"}
	if (y == 380) {s = "Maine"}
	if (y == 683) {s = "Stony Brook"}
	if (y == 391) {s = "UMBC"}
	if (y == 368) {s = "UMass Lowell"}
	
	#Atlantic 10
	if (y == 173) {s = "Davidson"}
	if (y == 175) {s = "Dayton"}
	if (y == 236) {s = "Fordham"}
	if (y == 249) {s = "George Washington"}
	if (y == 248) {s = "George Mason"}
	if (y == 340) {s = "La Salle"}
	if (y == 400) {s = "Massachusetts"}
	if (y == 572) {s = "Rhode Island"}
	if (y == 575) {s = "Richmond"}
	if (y == 606) {s = "Saint Josephs"}
	if (y == 609) {s = "Saint Louis"}
	if (y == 596) {s = "St. Bonaventure"}
	if (y == 740) {s = "VCU"}
	
	
	#ACC
	if (y == 67) {s = "Boston College"}
	if (y == 147) {s = "Clemson"}
	if (y == 193) {s = "Duke"}
	if (y == 234) {s = "Florida St"}
	if (y == 255) {s = "Georgia Tech"}
	if (y == 367) {s = "Louisville"}
	if (y == 415) {s = "Miami (FL)"}
	if (y == 457) {s = "North Carolina"}
	if (y == 490) {s = "NC State"}    
	if (y == 513) {s = "Notre Dame"}
	if (y == 746) {s = "Virginia"}
	if (y == 545) {s = "Pittsburgh"}
	if (y == 742) {s = "Virginia Tech"}
	if (y == 749) {s = "Wake Forest"}
	
	#Big 12
	if (y == 51) {s = "Baylor"}
	if (y == 328) {s = "Kansas"}
	if (y == 327) {s = "Kansas State"}
	if (y == 522) {s = "Oklahoma"}
	if (y == 521) {s = "Oklahoma State"}
	if (y == 698) {s = "TCU"}
	if (y == 703) {s = "Texas"}
	if (y == 700) {s = "Texas Tech"}
	if (y == 768) {s = "West Virginia"}
	
	#Big East
	if (y == 87) {s = "Butler"}
	if (y == 169) {s = "Creighton"}
	if (y == 251) {s = "Georgetown"}
	if (y == 635) {s = "Seton Hall"}
	if (y == 603) {s = "St. Johns (NY)"}
	if (y == 739) {s = "Villanova"}
	if (y == 812) {s = "Xavier"}
	
	#Big South
	if (y == 115) {s = "Campbell"}
	if (y == 48) {s = "Charleston So."}
	if (y == 1092) {s = "Gardner-Webb"}
	if (y == 19651) {s = "High Point"}
	if (y == 355) {s = "Liberty"}
	if (y == 363) {s = "Longwood"}
	if (y == 1320) {s = "Presbyterian"}
	if (y == 563) {s = "Radford"}
	if (y == 456) {s = "UNC Asheville"}
	if (y == 792) {s = "Winthrop"}
	
	#Big 10
	if (y == 301) {s = "Illinois"}
	if (y == 306) {s = "Indiana"}
	if (y == 312) {s = "Iowa"}
	if (y == 392) {s = "Maryland"}
	if (y == 418) {s = "Michigan"}
	if (y == 416) {s = "Michigan State"}
	if (y == 428) {s = "Minnesota"}
	if (y == 463) {s = "Nebraska"}
	if (y == 509) {s = "Northwestern"}
	if (y == 518) {s = "Ohio State"}
	if (y == 539) {s = "Penn State"}
	if (y == 559) {s = "Purdue"}
	if (y == 587) {s = "Rutgers"}
	
	#Big West
	if (y == 101) {s = "CSUN"}
	if (y == 90) {s = "Cal Poly"}
	if (y == 97) {s = "Cal St. Fullerton"}
	if (y == 277) {s = "Hawaii"}
	if (y == 99) {s = "Long Beach St."}
	if (y == 108) {s = "UC Davis"}
	if (y == 109) {s = "UC Irvine"}
	if (y == 111) {s = "UC Riverside"}
	if (y == 104) {s = "UC Santa Barbara"}
	
	#Colonial
	if (y == 1014) {s = "Col. of Charleston"}
	if (y == 180) {s = "Delaware"}
	if (y == 1068) {s = "Elon"}
	if (y == 283) {s = "Hofstra"}
	if (y == 317) {s = "James Madison"}
	if (y == 500) {s = "Northeastern"}
	if (y == 711) {s = "Towson"}
	if (y == 460) {s = "UNCW"}
	if (y == 786) {s = "William & Mary"}
	
	#Conference USA
	if (y == 458) {s = "Charlotte"}
	if (y == 231) {s = "FIU"}
	if (y == 229) {s = "Fla. Atlantic"}
	if (y == 366) {s = "Louisiana Tech"}
	if (y == 388) {s = "Marshall"}
	if (y == 419) {s = "Middle Tenn"}
	if (y == 523) {s = "Old Dominion"}
	if (y == 574) {s = "Rice"}
	if (y == 664) {s = "Southern Miss"}
	if (y == 9) {s = "UAB"}
	if (y == 706) {s = "UTSA"}
	if (y == 772) {s = "Western Ky."}
	
	#Horizon
	if (y == 302) {s = "Ill.-Chicago"}
	if (y == 797) {s = "Milwaukee"}
	if (y == 505) {s = "Northern Ky."}
	if (y == 514) {s = "Oakland"}
	if (y == 735) {s = "Valparaiso"}
	if (y == 810) {s = "Wright St."}
	if (y == 817) {s = "Youngstown St."}
	
	#Ivy League
	if (y == 80) {s = "Brown"}
	if (y == 158) {s = "Columbia"}
	if (y == 167) {s = "Cornell"}
	if (y == 172) {s = "Dartmouth"}
	if (y == 275) {s = "Harvard"}
	if (y == 540) {s = "Penn"}
	if (y == 554) {s = "Princeton"}
	if (y == 813) {s = "Yale"}
	
	#Metro Atlantic
	if (y == 116) {s = "Canisius"}
	if (y == 220) {s = "Fairfield"}
	if (y == 310) {s = "Iona"}
	if (y == 381) {s = "Manhattan"}
	if (y == 386) {s = "Marist"}
	if (y == 439) {s = "Monmouth"}
	if (y == 482) {s = "Niagara"}
	if (y == 562) {s = "Quinnipiac"}
	if (y == 576) {s = "Rider"}
	if (y == 617) {s = "Saint Peters"}
	if (y == 639) {s = "Siena"}
	
	#Mid American
	if (y == 47) {s = "Ball St."}
	if (y == 71) {s = "Bowling Green"}
	if (y == 86) {s = "Buffalo"}
	if (y == 129) {s = "Central Mich."}
	if (y == 204) {s = "Eastern Mich."}
	if (y == 331) {s = "Kent St."}
	if (y == 414) {s = "Miami (OH)"}
	if (y == 503) {s = "Northern Ill."}
	if (y == 519) {s = "Ohio"}
	if (y == 709) {s = "Toledo"}
	if (y == 774) {s = "Western Mich."}
	
	#Mid-Eastern
	if (y == 61) {s = "Bethune-Cookman"}
	if (y == 165) {s = "Coppin St."}
	if (y == 178) {s = "Delaware St."}
	if (y == 228) {s = "Florida A&M"}
	if (y == 488) {s = "N.C. A&T"}
	if (y == 489) {s = "N.C. Central"}
	if (y == 485) {s = "Norfolk St."}
	if (y == 632) {s = "Savannah St."}
	if (y == 393) {s = "UMES"}
	
	#Missouri Valley
	if (y == 72) {s = "Bradley"}
	if (y == 1045) {s = "Dallas Baptist"}
	if (y == 219) {s = "Evansville"}
	if (y == 299) {s = "Illinois St."}
	if (y == 305) {s = "Indiana St."}
	if (y == 669) {s = "Missouri St."}
	if (y == 659) {s = "Southern Ill."}
	if (y == 782) {s = "Wichita St."}
	
	#Mountain West
	if (y == 721) {s = "Air Force"}
	if (y == 96) {s = "Fresno St."}
	if (y == 466) {s = "Nevada"}
	if (y == 473) {s = "New Mexico"}
	if (y == 626) {s = "San Diego St."}
	if (y == 630) {s = "San Jose St."}
	if (y == 465) {s = "UNLV"}
	
	#Northeast
	if (y == 81) {s = "Bryant"}
	if (y == 127) {s = "Central Conn. St."}
	if (y == 222) {s = "Fairleigh Dickinson"}
	if (y == 361) {s = "LIU Brooklyn"}
	if (y == 450) {s = "Mt. St. Marys"}
	if (y == 590) {s = "Sacred Heart"}
	if (y == 748) {s = "Wagner"}
	
	#OVC
	if (y == 43) {s = "Austin Peay"}
	if (y == 14927) {s = "Belmont"}
	if (y == 201) {s = "Eastern Ill."}
	if (y == 202) {s = "Eastern Ky."}
	if (y == 315) {s = "Jacksonville St."}
	if (y == 444) {s = "Morehead St."}
	if (y == 454) {s = "Murray St."}
	if (y == 660) {s = "SIUE"}
	if (y == 654) {s = "Southeast Mo. St."}
	if (y == 692) {s = "Tennessee Tech"}
	if (y == 695) {s = "UT Martin"}
	
	#Pac 12
	if (y == 29) {s = "Arizona"}
	if (y == 28) {s = "Arizona St."}
	if (y == 107) {s = "California"}
	if (y == 529) {s = "Oregon"}
	if (y == 528) {s = "Oregon St."}
	if (y == 657) {s = "Southern Cal"}
	if (y == 674) {s = "Stanford"}
	if (y == 110) {s = "UCLA"}
	if (y == 732) {s = "Utah"}
	if (y == 756) {s = "Washington"}
	if (y == 754) {s = "Washington St."}
	
	#Patriot
	if (y == 725) {s = "Army"}
	if (y == 83) {s = "Bucknell"}
	if (y == 285) {s = "Holy Cross"}
	if (y == 342) {s = "Lafayette"}
	if (y == 352) {s = "Lehigh"}
	if (y == 726) {s = "Navy"}
	
	#SEC
	if (y == 8) {s = "Alabama"}
	if (y == 31) {s = "Arkansas"}
	if (y == 37) {s = "Auburn"}
	if (y == 235) {s = "Florida"}
	if (y == 257) {s = "Georgia"}
	if (y == 334) {s = "Kentucky"}
	if (y == 365) {s = "LSU"}
	if (y == 430) {s = "Mississippi St."}
	if (y == 434) {s = "Missouri"}
	if (y == 433) {s = "Ole Miss"}
	if (y == 648) {s = "South Carolina"}
	if (y == 694) {s = "Tennessee"}
	if (y == 697) {s = "Texas A&M"}
	if (y == 736) {s = "Vanderbilt"}
	
	
	#Southern
	if (y == 198) {s = "ETSU"}
	if (y == 244) {s = "Furman"}
	if (y == 406) {s = "Mercer"}
	if (y == 625) {s = "Samford"}
	if (y == 141) {s = "The Citadel"}
	if (y == 459) {s = "UNCG"}
	if (y == 741) {s = "VMI"}
	if (y == 769) {s = "Western Caro."}
	if (y == 2915) {s = "Wofford"}
	
	#Southland
	if (y == 26172) {s = "A&M-Corpus Chris"}
	if (y == 2) {s = "Abilene Christian"}
	if (y == 1004) {s = "Central Ark."}
	if (y == 287) {s = "Houston Baptist"}
	if (y == 2743) {s = "Incarnate Word"}
	if (y == 346) {s = "Lamar"}
	if (y == 402) {s = "McNeese"}
	if (y == 474) {s = "New Orleans"}
	if (y == 483) {s = "Nicholls St."}
	if (y == 508) {s = "Northwestern St."}
	if (y == 676) {s = "SFA"}
	if (y == 624) {s = "Sam Houston St."}
	if (y == 655) {s = "Southeastern LA."}
	
	#Southwestern
	if (y == 6) {s = "Alabama A&M"}
	if (y == 7) {s = "Alabama St."}
	if (y == 17) {s = "Alcorn"}
	if (y == 2678) {s = "Ark. Pine Bluff"}
	if (y == 261) {s = "Grambling"}
	if (y == 314) {s = "Jackson St."}
	if (y == 432) {s = "Mississippi Val."}
	if (y == 553) {s = "Prairie View"}
	if (y == 665) {s = "Southern U."}
	if (y == 699) {s = "Texas Southern"}
	
	#Summit League
	if (y == 308) {s = "Fort Wayne"}
	if (y == 493) {s = "North Dakota St."}
	if (y == 464) {s = "Omaha"}
	if (y == 527) {s = "Oral Roberts"}
	if (y == 649) {s = "South Dakota St."}
	if (y == 771) {s = "Western Ill."}
	
	
	#Sun Belt
	if (y == 27) {s = "Appalachian St."}
	if (y == 30) {s = "Arkansas St."}
	if (y == 149) {s = "Coastal Carolina"}
	if (y == 253) {s = "Georgia Southern"}
	if (y == 254) {s = "Georgia St."}
	if (y == 498) {s = "La.-Monroe"}
	if (y == 32) {s = "Little Rock"}
	if (y == 671) {s = "Louisiana"}
	if (y == 646) {s = "South Ala."}
	if (y == 670) {s = "Texas State"}
	if (y == 716) {s = "Troy"}
	if (y == 702) {s = "UT Arlington"}
	
	#West Coast
	if (y == 77) {s = "BYU"}
	if (y == 260) {s = "Gonzaga"}
	if (y == 370) {s = "Loyola Marymount"}
	if (y == 534) {s = "Pacific"}
	if (y == 541) {s = "Pepperdine"}
	if (y == 551) {s = "Portland"}
	if (y == 610) {s = "Saint Marys (CA)"}
	if (y == 627) {s = "San Diego"}
	if (y == 629) {s = "San Francisco"}
	if (y == 631) {s = "Santa Clara"}
	
	#Western Athletic
	if (y == 94) {s = "CSU Bakersfield"}
	if (y == 136) {s = "Chicago St."}
	if (y == 1104) {s = "Grand Canyon"}
	if (y == 472) {s = "New Mexico St."}
	if (y == 502) {s = "Northern Colo."}
	if (y == 102) {s = "Sacramento St."}
	if (y == 1356) {s = "Seattle U"}
	if (y == 536) {s = "UTRGV"}
	if (y == 30024) {s = "Utah Valley"}
	
	
	b_2018 <- paste0("http://stats.ncaa.org/team/", y,"/stats/12973")
	b_2017 <- paste0("http://stats.ncaa.org/team/", y,"/stats/12560")
	b_2016 <- paste0("http://stats.ncaa.org/team/", y,"/stats?game_sport_year_ctl_id=12360&id=12360")
	b_2015 <- paste0("http://stats.ncaa.org/team/", y,"/stats?game_sport_year_ctl_id=12080&id=12080")
	
	
	
	#2018 totals
	url <- b_2018
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	
	batting_2018 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")
	
	batting_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2018")
	
	batting_2018r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2018")
	
	batting_2018 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2018r group by player order by wOBA desc")
	
	
	
	
	#2017 totals
	url <- b_2017
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	
	batting_2017 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")
	
	batting_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2017")
	
	batting_2017r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2017")
	
	batting_2017 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2017r group by player order by wOBA desc")
	
	
	#2016 totals
	url <- b_2016
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	
	batting_2016 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")
	
	batting_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2016")
	
	batting_2016r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2016")
	
	batting_2016 <-sqldf("select Player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2016r group by player order by wOBA desc")
	
	#2015 totals
	url <- b_2015
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	
	batting_2015 <- sqldf("select * from get_stats where player <> 'Totals' AND player <> 'Opponent Totals'")
	
	batting_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, BA,OBPct OBP,SLGPct SLG,CASE WHEN [R] IS NULL THEN 0 ELSE [R] END [R], CASE WHEN [AB] IS NULL THEN 0 ELSE [AB] END [AB], CASE WHEN [H] IS NULL THEN 0 ELSE [H] END [H], CASE WHEN [2B] IS NULL THEN 0 ELSE [2B] END [2B], CASE WHEN [3B] IS NULL THEN 0 ELSE [3B] END [3B], CASE WHEN [HR] IS NULL THEN 0 ELSE [HR] END [HR], [TB], CASE WHEN [RBI] IS NULL THEN 0 ELSE [RBI] END [RBI], CASE WHEN [BB] IS NULL THEN 0 ELSE [BB] END [BB], CASE WHEN [HBP] IS NULL THEN 0 ELSE [HBP] END [HBP], CASE WHEN [SH] IS NULL THEN 0 ELSE [SH] END [SH], CASE WHEN [SF] IS NULL THEN 0 ELSE [SF] END [SF], CASE WHEN [K] IS NULL THEN 0 ELSE [K] END [K], CASE WHEN [DP] IS NULL THEN 0 ELSE [DP] END [DP], CASE WHEN [CS] IS NULL THEN 0 ELSE [CS] END [CS], CASE WHEN [Picked] IS NULL THEN 0 ELSE [Picked] END [Picked], CASE WHEN [SB] IS NULL THEN 0 ELSE [SB] END [SB] from batting_2015")
	
	batting_2015r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, (AB+BB+HBP+SF+SH) AS PA, [AB], BA, OBP,SLG,[R], [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP], [CS], [SB] from batting_2015")
	
	batting_2015 <-sqldf("select player, Jersey, Yr, Pos, GP, GS, AB, [H], ([H]-[2B]-[3B]-[HR]) [1B], [2B], [3B], [HR], [TB], [RBI], [BB], [HBP], [SH], [SF], [K],[DP],(AB+BB+HBP+SF+SH) AS PA, BA, OBP, SLG, SB, (SB + CS) AS SBA,  (cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100 Kpct, (cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100 BBpct, (H-HR) / (AB-cast(K AS float)-HR+SF) BABIP, (sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)) wOBA from batting_2015r group by player order by wOBA desc")
	
	
	
	#Get career totals
	
	batting_total_r <- sqldf("select b18.player, b18.Jersey, b18.Yr, b18.Pos, b18.GP, case when b18.GS IS NULL THEN 0 ELSE b18.GS END AS GS, b18.PA, b18.AB, b18.H, b18.BB, b18.K, b18.[1B], b18.[2B], b18.[3B], b18.HR, b18.HBP, b18.SH, b18.SF, b18.CS, b18.SB from batting_2018r b18 left outer join batting_2017r b17 on b18.player = b17.player 
						UNION select b17.player, b17.Jersey, b17.Yr, b17.Pos, b17.GP, case when b17.GS IS NULL THEN 0 ELSE b17.GS END AS GS, b17.PA, b17.AB, b17.H, b17.BB, b17.K, b17.[1B], b17.[2B], b17.[3B], b17.HR, b17.HBP, b17.SH, b17.SF, b17.CS, b17.SB from batting_2017r b17 left outer join batting_2018r b18 on b18.player = b17.player 
						UNION select b16.player, b16.Jersey, b16.Yr, b16.Pos, b16.GP, case when b16.GS IS NULL THEN 0 ELSE b16.GS END AS GS, b16.PA, b16.AB, b16.H, b16.BB, b16.K, b16.[1B], b16.[2B], b16.[3B], b16.HR, b16.HBP, b16.SH, b16.SF, b16.CS, b16.SB from batting_2016r b16 left outer join batting_2018r b18 on b18.player = b16.player
						UNION select b15.player, b15.Jersey, b15.Yr, b15.Pos, b15.GP, case when b15.GS IS NULL THEN 0 ELSE b15.GS END AS GS, b15.PA, b15.AB, b15.H, b15.BB, b15.K, b15.[1B], b15.[2B], b15.[3B], b15.HR, b15.HBP, b15.SH, b15.SF, b15.CS, b15.SB from batting_2015r b15 left outer join batting_2018r b18 on b18.player = b15.player")
	
	batting_total_r1 <- sqldf("select Player, max(Jersey) AS Jersey, max(yr) AS Yr, POS, SUM(GP) AS GP, SUM(GS) AS GS, SUM(PA) PA, SUM(AB) AB, SUM(H) H, SUM(BB) BB, SUM(K) K, SUM([1B]) [1B], SUM([2B]) [2B], SUM([3B]) [3B], SUM(HR) HR, SUM(HBP) HBP, SUM(SH) SH, SUM(SF) SF, SUM(CS) CS, SUM(SB) SB  FROM batting_total_r WHERE PA > 0  group by Player")
	
	batting_total <- sqldf("select player, Jersey, Yr, Pos, GP, GS, PA, ROUND(cast(H AS float) /AB, 3) AVG, ROUND(((cast(H+BB+HBP AS float)) / (AB + BB + HBP + SF +SH)),3) OBP, ROUND(((([1B]) + ([2B] * 2) + ([3B]* 3) + ([HR]* 4)) / (cast(AB AS float))),3) SLG, ROUND(((([1B]) + ([2B] * 2) + ([3B]* 3) + ([HR]* 4)) / (cast(AB AS float))) - (cast(H AS float) /AB), 3) ISO, HR, SB, SB + CS AS SBA,  ROUND((cast(K AS float) / (AB+BB+HBP+SF+SH)) * 100,2) [K%], ROUND((cast(BB AS float) / (AB+BB+HBP+SF+SH)) * 100,2) [BB%], ROUND((H-HR) / (AB-cast(K AS float)-HR+SF),3) BABIP, ROUND((sum([1B]) * .878 + sum([2b]) * 1.242 + sum([3B]) * 1.569 + sum(HR) * 2.015 + sum(BB) * .691 + sum(HBP) * .721) / (sum(AB) + sum(BB) + SUM(HBP) + sum(SF)),3) wOBA from batting_total_r1 group by player order by Jersey desc")
	
	
	#Get Players from 2018 teams
	b_Players <- sqldf("select Player FROM batting_2018r")
	
	batting_career <- sqldf("select * FROM batting_total WHERE player IN b_Players ORDER BY PA DESC")
	
	
	#Get Current year for players and sort
	batting_career <- sqldf(paste0("select b.player, '", c ,"' AS Conference , '", s ,"' AS School ,b18.Yr, b.Pos, b.PA, b.AVG, b.OBP, b.SLG, b.HR, b.ISO, b.SB, b.SBA, b.[K%], b.[BB%], b.BABIP, b.wOBA  FROM batting_career b JOIN batting_2018 b18 ON b.Player = b18.Player group by b.Player order by b.PA desc"))
	
	batting_2018 <-sqldf(paste0("select player,  '", c ,"' AS Conference , '", s ,"' AS School, Yr, Pos, (AB+BB+HBP+SF+SH) AS PA, ROUND(BA,3) AVG, ROUND(OBP,3) OBP, ROUND(SLG,3) SLG, HR, ROUND((SLG-BA), 3) ISO, SB, SBA, ROUND(Kpct,2) AS [K%], ROUND(BBpct,2) AS [BB%], ROUND(BABIP,3) BABIP,  ROUND(wOBA,3) wOBA from batting_2018 where PA > 0 order by PA desc"))
	
	
	batting_career_master <- sqldf("Select * from batting_career_master UNION select * from batting_career")
	batting_2018_master <- sqldf("Select * from batting_2018_master UNION select * from batting_2018")

#Export to Excel 
write.csv(x = batting_career_master, file = "NCAA_2018_Career.csv")

write.csv(x = batting_2018_master, file = "NCAA_2018_Season.csv")
```
#Pitching
#Create Master Pitching Tables with stats from Cincinnati
```{r}
#Enter Team and code
y <- 140
c <- "AAC"
s <- "Cincinnati"



#enter URL for each year
p_2018 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12973&year_stat_category_id=11954")
p_2017 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12560&year_stat_category_id=11001")
p_2016 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12360&year_stat_category_id=10947")
p_2015 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12080&year_stat_category_id=10781")

#2018 totals
url <- p_2018
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)

get_stats = subset(get_stats, select = -c(G) )

pitching_2018 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")


pitching_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2018")

pitching_2018r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2018")

pitching_2018r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2018r$Pitches)))

pitching_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ER, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) +3.147,2) FIP FROM pitching_2018r ORDER BY PA DESC")



#2017 totals
url <- p_2017
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)

get_stats = subset(get_stats, select = -c(G) )

pitching_2017 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")


pitching_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2017")

pitching_2017r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2017")

pitching_2017r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2017r$Pitches)))

pitching_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ER, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) +3.147,2) FIP FROM pitching_2017r ORDER BY PA DESC")




#2016 totals
url <- p_2016
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)

get_stats = subset(get_stats, select = -c(G) )

pitching_2016 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")


pitching_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2016")

pitching_2016r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER,  H, BB, SO, cast(BF AS float) BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2016")

pitching_2016r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2016r$Pitches)))

pitching_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, cast(BF AS float) PA, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2) FIP FROM pitching_2016r ORDER BY PA DESC")

#2015 totals
url <- p_2015
pgsession <- html_session(url)
pgform <-html_form(pgsession)[[3]]
filled_form <-set_values(pgform,
					"available_stat_id" = "0"
)

d <- submit_form(session = pgsession, form=filled_form)



get_stats <- d %>%
	html_nodes("table") %>%
	.[[3]] %>%
	html_table(header=TRUE)

get_stats = subset(get_stats, select = -c(G) )

pitching_2015 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")


pitching_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, H, BB, SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2015")

pitching_2015r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO FROM pitching_2015")

pitching_2015r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2015r$Pitches)))

pitching_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2)  FIP FROM pitching_2015r")


#Get career totals
pitching_total_r <- sqldf("select p18.player, p18.Jersey, p18.Yr, p18.Pos, p18.GP, case when p18.GS IS NULL THEN 0 ELSE p18.GS END AS GS , p18.IP, p18.BF, p18.Pitches, p18.ER, p18.H, p18.BB, p18.SO, (p18.H + p18.SO + p18.GO + p18.FO) AB, p18.H - (p18.[2B] + p18.[3B] + p18.[HR]) AS [1B], p18.[2B], p18.[3B], p18.[HR], p18.HBP, p18.IBB, p18.GO, p18.FO from pitching_2018r p18 left outer join pitching_2017r p17 on p18.player = p17.player 
					 UNION select p17.player, p17.Jersey, p17.Yr, p17.Pos, p17.GP, case when p17.GS IS NULL THEN 0 ELSE p17.GS END AS GS, p17.IP, p17.BF, p17.Pitches, p17.ER, p17.H, p17.BB, p17.SO, (p17.H + p17.SO + p17.GO + p17.FO) AB, p17.H - (p17.[2B] + p17.[3B] + p17.[HR]) AS [1B], p17.[2B], p17.[3B], p17.[HR], p17.HBP, p17.IBB, p17.GO, p17.FO from pitching_2017r p17 left outer join pitching_2018r p18 on p18.player = p17.player 
					 UNION select p16.player, p16.Jersey, p16.Yr, p16.Pos, p16.GP, case when p16.GS IS NULL THEN 0 ELSE p16.GS END AS GS, p16.IP, p16.BF, p16.Pitches, p16.ER, p16.H, p16.BB, p16.SO, (p16.H + p16.SO + p16.GO + p16.FO) AB, p16.H - (p16.[2B] + p16.[3B] + p16.[HR]) AS [1B], p16.[2B], p16.[3B], p16.[HR], p16.HBP, p16.IBB, p16.GO, p16.FO from pitching_2016r p16 left outer join pitching_2018r p18 on p18.player = p16.player
					 UNION select p15.player, p15.Jersey, p15.Yr, p15.Pos, p15.GP, case when p15.GS IS NULL THEN 0 ELSE p15.GS END AS GS, p15.IP, p15.BF, p15.Pitches, p15.ER, p15.H, p15.BB, p15.SO, (p15.H + p15.SO + p15.GO + p15.FO) AB, p15.H - (p15.[2B] + p15.[3B] + p15.[HR]) AS [1B], p15.[2B], p15.[3B], p15.[HR], p15.HBP, p15.IBB, p15.GO, p15.FO from pitching_2015r p15 left outer join pitching_2018r p18 on p18.player = p15.player")

pitching_total_r1 <- sqldf("select Player, max(Jersey) AS Jersey, max(yr) AS Yr, POS, SUM(GP) AS GP, SUM(GS) AS GS, SUM(IP) IP, SUM(BF) BF, SUM(Pitches) Pitches, SUM(ER) ER, SUM(H) H, SUM(BB) BB, SUM(SO) SO, (SUM(H) + SUM(SO) + SUM(GO) + SUM(FO)) AB, SUM(H) - (SUM([2B]) + SUM([3B]) + SUM([HR])) AS [1B], SUM([2B]) [2B], SUM([3B]) [3B], SUM([HR]) [HR], SUM(HBP) HBP, SUM(IBB) IBB, SUM(GO) GO, SUM(FO) FO FROM pitching_total_r group by Player")

pitching_total <- sqldf("select Player, Jersey, Yr, Pos, GP, IP, BF PA, Pitches, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ROUND(((ER / IP) * 9), 2) ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2)  FIP FROM pitching_total_r1")

Players <- sqldf("select Player FROM pitching_2018r")

pitching_career <- sqldf("select * FROM pitching_total WHERE player IN Players ORDER BY PA DESC")


pitching_career_master <- sqldf(paste0("select p.player, '", c ,"' AS Conference , '", s ,"' AS School ,p18.Yr, p.Pos, p.IP, p.PA, p.Pitches, p.[K%], p.[BB%], p.[K%-BB%], p.AVG, p.OBP, p.SLG, p.wOBA, p.[GO%], p.[FO%], p.ERA, p.FIP FROM pitching_career p JOIN pitching_2018 p18 ON p.Player = p18.Player group by p.Player order by p.PA desc"))

pitching_2018_master <- sqldf(paste0("select p.player, '", c ,"' AS Conference , '", s ,"' AS School ,p.Yr, p.Pos, p.IP, p.PA, p.Pitches, p.[K%], p.[BB%], p.[K%-BB%], p.AVG, p.OBP, p.SLG, p.wOBA, p.[GO%], p.[FO%], p.ERA, p.FIP FROM pitching_2018 p group by p.Player order by p.PA desc"))

```


```{r}
#run for all other schools
for(y in c(196,164,288,404,651,718,128,28755,316,1157,28600,471,2711,678,10411,14,62,272,380,683,391,368,173,175,236,249,248,340,400,572,575,606,609,596,740,67,147,193,234,255,367,415,457,490,513,746,545,742,749,51,328,327,522,521,698,703,700,768,87,169,251,635,603,739,812,115,48,1092,19651,355,363,1320,563,456,792,301,306,312,392,418,416,428,463,509,518,539,559,587,101,90,97,277,99,108,109,111,104,1014,180,1068,283,317,500,711,460,786,458,231,229,366,388,419,523,574,664,9,706,772,302,797,505,514,735,810,817,80,158,167,172,275,540,554,813,116,220,310,381,386,439,482,562,576,617,639,47,71,129,204,331,414,503,519,709,774,61,165,178,228,488,489,485,632,393,72,1045,219,299,305,669,659,782,721,96,466,473,626,630,465,81,127,222,361,450,590,748,43,14927,201,202,315,444,454,660,654,692,695,29,28,107,529,528,657,674,110,732,756,754,725,83,285,342,352,726,8,31,37,235,257,334,365,430,434,433,648,694,697,736,198,244,406,625,141,459,741,769,2915,26172,2,1004,287,2743,346,402,474,483,508,676,624,655,6,7,17,2678,261,314,432,553,665,699,308,493,464,527,649,771,27,30,149,253,254,498,32,671,646,670,716,702,77,260,370,534,541,551,610,627,629,631,94,136,1104,472,502,102,1356,536,30024)) {
	
	if (y %in% c(196,164,288,404,651,718,128)) {c = "AAC"}
	if (y %in% c(28755,316,1157,28600,471,2711,678,10411)) {c = "ASUN"}
	if (y %in% c(14,62,272,380,683,391,368)) {c = "American East"}
	if (y %in% c(173,175,236,249,248,340,400,572,575,606,609,596,740)) {c = "Atlantic 10"}
	if (y %in% c(67,147,193,234,255,367,415,457,490,513,746,545,742,749)) {c = "ACC"}
	if (y %in% c(51,328,327,522,521,698,703,700,768)) {c = "Big 12"}
	if (y %in% c(87,169,251,635,603,739,812)) {c = "Big East"}
	if (y %in% c(115,48,1092,19651,355,363,1320,563,456,792)) {c = "Big South"}
	if (y %in% c(301,306,312,392,418,416,428,463,509,518,539,559,587)) {c = "Big 10"}
	if (y %in% c(101,90,97,277,99,108,109,111,104)) {c = "Big West"}
	if (y %in% c(1014,180,1068,283,317,500,711,460,786)) {c = "Colonial"}
	if (y %in% c(458,231,229,366,388,419,523,574,664,9,706,772)) {c = "Conference USA"}
	if (y %in% c(302,797,505,514,735,810,817)) {c = "Horizon"}
	if (y %in% c(80,158,167,172,275,540,554,813)) {c = "Ivy League"}
	if (y %in% c(116,220,310,381,386,439,482,562,576,617,639)) {c = "Metro Atlantic"}
	if (y %in% c(47,71,86,129,204,331,414,503,519,709,774)) {c = "Mid American"}
	if (y %in% c(61,165,178,228,488,489,485,632,393)) {c = "Mid-Eastern"}
	if (y %in% c(72,1045,219,299,305,669,659,782)) {c = "Missouri Valley"}
	if (y %in% c(721,96,466,473,626,630,465)) {c = "Mountain West"}
	if (y %in% c(81,127,222,361,450,590,748)) {c = "Northeast"}
	if (y %in% c(43,14927,201,202,315,444,454,660,654,692,695)) {c = "OVC"}
	if (y %in% c(29,28,107,529,528,657,674,110,732,756,754)) {c = "Pac 12"}
	if (y %in% c(725,83,285,342,352,726)) {c = "Patriot"}
	if (y %in% c(8,31,37,235,257,334,365,430,434,433,648,694,697,736)) {c = "SEC"}
	if (y %in% c(198,244,406,625,141,459,741,769,2915)) {c = "Southern"}
	if (y %in% c(26172,2,1004,287,2743,346,402,474,483,508,676,624,655)) {c = "Southland"}
	if (y %in% c(6,7,17,2678,261,314,432,553,665,699)) {c = "Southwestern"}
	if (y %in% c(308,493,464,527,649,771)) {c = "Summit League"}
	if (y %in% c(27,30,149,253,254,498,32,671,646,670,716,702)) {c = "Sun Belt"}
	if (y %in% c(77,260,370,534,541,551,610,627,629,631)) {c = "West Coast"}
	if (y %in% c(94,136,1104,472,502,102,1356,536,30024)) {c = "Western Athletic"}
	
	
	#AAC
	if (y == 196) {s = "East Carolina"} 
	if (y == 164) {s = "UConn"}
	if (y == 288) {s = "Houston"}
	if (y == 404) {s = "Memphis"}
	if (y == 651) {s = "USF"}
	if (y == 718) {s = "Tulane"}
	if (y == 128) {s = "UCF"}
	
	#ASUN
	if (y == 28755) {s = "FGCU"}
	if (y == 316) {s = "Jacksonville"}
	if (y == 1157) {s = "Kennesaw State"}
	if (y == 28600) {s = "Lipscomb"}
	if (y == 471) {s = "NJIT"}
	if (y == 2711) {s = "North Florida"}
	if (y == 678) {s = "Stetson"}
	if (y == 10411) {s = "USC Upstate"}
	
	#American East
	if (y == 14) {s = "Albany (NY)"}
	if (y == 62) {s = "Binghamton"}
	if (y == 272) {s = "Hartford"}
	if (y == 380) {s = "Maine"}
	if (y == 683) {s = "Stony Brook"}
	if (y == 391) {s = "UMBC"}
	if (y == 368) {s = "UMass Lowell"}
	
	#Atlantic 10
	if (y == 173) {s = "Davidson"}
	if (y == 175) {s = "Dayton"}
	if (y == 236) {s = "Fordham"}
	if (y == 249) {s = "George Washington"}
	if (y == 248) {s = "George Mason"}
	if (y == 340) {s = "La Salle"}
	if (y == 400) {s = "Massachusetts"}
	if (y == 572) {s = "Rhode Island"}
	if (y == 575) {s = "Richmond"}
	if (y == 606) {s = "Saint Josephs"}
	if (y == 609) {s = "Saint Louis"}
	if (y == 596) {s = "St. Bonaventure"}
	if (y == 740) {s = "VCU"}
	
	
	#ACC
	if (y == 67) {s = "Boston College"}
	if (y == 147) {s = "Clemson"}
	if (y == 193) {s = "Duke"}
	if (y == 234) {s = "Florida St"}
	if (y == 255) {s = "Georgia Tech"}
	if (y == 367) {s = "Louisville"}
	if (y == 415) {s = "Miami (FL)"}
	if (y == 457) {s = "North Carolina"}
	if (y == 490) {s = "NC State"}    
	if (y == 513) {s = "Notre Dame"}
	if (y == 746) {s = "Virginia"}
	if (y == 545) {s = "Pittsburgh"}
	if (y == 742) {s = "Virginia Tech"}
	if (y == 749) {s = "Wake Forest"}
	
	#Big 12
	if (y == 51) {s = "Baylor"}
	if (y == 328) {s = "Kansas"}
	if (y == 327) {s = "Kansas State"}
	if (y == 522) {s = "Oklahoma"}
	if (y == 521) {s = "Oklahoma State"}
	if (y == 698) {s = "TCU"}
	if (y == 703) {s = "Texas"}
	if (y == 700) {s = "Texas Tech"}
	if (y == 768) {s = "West Virginia"}
	
	#Big East
	if (y == 87) {s = "Butler"}
	if (y == 169) {s = "Creighton"}
	if (y == 251) {s = "Georgetown"}
	if (y == 635) {s = "Seton Hall"}
	if (y == 603) {s = "St. Johns (NY)"}
	if (y == 739) {s = "Villanova"}
	if (y == 812) {s = "Xavier"}
	
	#Big South
	if (y == 115) {s = "Campbell"}
	if (y == 48) {s = "Charleston So."}
	if (y == 1092) {s = "Gardner-Webb"}
	if (y == 19651) {s = "High Point"}
	if (y == 355) {s = "Liberty"}
	if (y == 363) {s = "Longwood"}
	if (y == 1320) {s = "Presbyterian"}
	if (y == 563) {s = "Radford"}
	if (y == 456) {s = "UNC Asheville"}
	if (y == 792) {s = "Winthrop"}
	
	#Big 10
	if (y == 301) {s = "Illinois"}
	if (y == 306) {s = "Indiana"}
	if (y == 312) {s = "Iowa"}
	if (y == 392) {s = "Maryland"}
	if (y == 418) {s = "Michigan"}
	if (y == 416) {s = "Michigan State"}
	if (y == 428) {s = "Minnesota"}
	if (y == 463) {s = "Nebraska"}
	if (y == 509) {s = "Northwestern"}
	if (y == 518) {s = "Ohio State"}
	if (y == 539) {s = "Penn State"}
	if (y == 559) {s = "Purdue"}
	if (y == 587) {s = "Rutgers"}
	
	#Big West
	if (y == 101) {s = "CSUN"}
	if (y == 90) {s = "Cal Poly"}
	if (y == 97) {s = "Cal St. Fullerton"}
	if (y == 277) {s = "Hawaii"}
	if (y == 99) {s = "Long Beach St."}
	if (y == 108) {s = "UC Davis"}
	if (y == 109) {s = "UC Irvine"}
	if (y == 111) {s = "UC Riverside"}
	if (y == 104) {s = "UC Santa Barbara"}
	
	#Colonial
	if (y == 1014) {s = "Col. of Charleston"}
	if (y == 180) {s = "Delaware"}
	if (y == 1068) {s = "Elon"}
	if (y == 283) {s = "Hofstra"}
	if (y == 317) {s = "James Madison"}
	if (y == 500) {s = "Northeastern"}
	if (y == 711) {s = "Towson"}
	if (y == 460) {s = "UNCW"}
	if (y == 786) {s = "William & Mary"}
	
	#Conference USA
	if (y == 458) {s = "Charlotte"}
	if (y == 231) {s = "FIU"}
	if (y == 229) {s = "Fla. Atlantic"}
	if (y == 366) {s = "Louisiana Tech"}
	if (y == 388) {s = "Marshall"}
	if (y == 419) {s = "Middle Tenn"}
	if (y == 523) {s = "Old Dominion"}
	if (y == 574) {s = "Rice"}
	if (y == 664) {s = "Southern Miss"}
	if (y == 9) {s = "UAB"}
	if (y == 706) {s = "UTSA"}
	if (y == 772) {s = "Western Ky."}
	
	#Horizon
	if (y == 302) {s = "Ill.-Chicago"}
	if (y == 797) {s = "Milwaukee"}
	if (y == 505) {s = "Northern Ky."}
	if (y == 514) {s = "Oakland"}
	if (y == 735) {s = "Valparaiso"}
	if (y == 810) {s = "Wright St."}
	if (y == 817) {s = "Youngstown St."}
	
	#Ivy League
	if (y == 80) {s = "Brown"}
	if (y == 158) {s = "Columbia"}
	if (y == 167) {s = "Cornell"}
	if (y == 172) {s = "Dartmouth"}
	if (y == 275) {s = "Harvard"}
	if (y == 540) {s = "Penn"}
	if (y == 554) {s = "Princeton"}
	if (y == 813) {s = "Yale"}
	
	#Metro Atlantic
	if (y == 116) {s = "Canisius"}
	if (y == 220) {s = "Fairfield"}
	if (y == 310) {s = "Iona"}
	if (y == 381) {s = "Manhattan"}
	if (y == 386) {s = "Marist"}
	if (y == 439) {s = "Monmouth"}
	if (y == 482) {s = "Niagara"}
	if (y == 562) {s = "Quinnipiac"}
	if (y == 576) {s = "Rider"}
	if (y == 617) {s = "Saint Peters"}
	if (y == 639) {s = "Siena"}
	
	#Mid American
	if (y == 47) {s = "Ball St."}
	if (y == 71) {s = "Bowling Green"}
	if (y == 86) {s = "Buffalo"}
	if (y == 129) {s = "Central Mich."}
	if (y == 204) {s = "Eastern Mich."}
	if (y == 331) {s = "Kent St."}
	if (y == 414) {s = "Miami (OH)"}
	if (y == 503) {s = "Northern Ill."}
	if (y == 519) {s = "Ohio"}
	if (y == 709) {s = "Toledo"}
	if (y == 774) {s = "Western Mich."}
	
	#Mid-Eastern
	if (y == 61) {s = "Bethune-Cookman"}
	if (y == 165) {s = "Coppin St."}
	if (y == 178) {s = "Delaware St."}
	if (y == 228) {s = "Florida A&M"}
	if (y == 488) {s = "N.C. A&T"}
	if (y == 489) {s = "N.C. Central"}
	if (y == 485) {s = "Norfolk St."}
	if (y == 632) {s = "Savannah St."}
	if (y == 393) {s = "UMES"}
	
	#Missouri Valley
	if (y == 72) {s = "Bradley"}
	if (y == 1045) {s = "Dallas Baptist"}
	if (y == 219) {s = "Evansville"}
	if (y == 299) {s = "Illinois St."}
	if (y == 305) {s = "Indiana St."}
	if (y == 669) {s = "Missouri St."}
	if (y == 659) {s = "Southern Ill."}
	if (y == 782) {s = "Wichita St."}
	
	#Mountain West
	if (y == 721) {s = "Air Force"}
	if (y == 96) {s = "Fresno St."}
	if (y == 466) {s = "Nevada"}
	if (y == 473) {s = "New Mexico"}
	if (y == 626) {s = "San Diego St."}
	if (y == 630) {s = "San Jose St."}
	if (y == 465) {s = "UNLV"}
	
	#Northeast
	if (y == 81) {s = "Bryant"}
	if (y == 127) {s = "Central Conn. St."}
	if (y == 222) {s = "Fairleigh Dickinson"}
	if (y == 361) {s = "LIU Brooklyn"}
	if (y == 450) {s = "Mt. St. Marys"}
	if (y == 590) {s = "Sacred Heart"}
	if (y == 748) {s = "Wagner"}
	
	#OVC
	if (y == 43) {s = "Austin Peay"}
	if (y == 14927) {s = "Belmont"}
	if (y == 201) {s = "Eastern Ill."}
	if (y == 202) {s = "Eastern Ky."}
	if (y == 315) {s = "Jacksonville St."}
	if (y == 444) {s = "Morehead St."}
	if (y == 454) {s = "Murray St."}
	if (y == 660) {s = "SIUE"}
	if (y == 654) {s = "Southeast Mo. St."}
	if (y == 692) {s = "Tennessee Tech"}
	if (y == 695) {s = "UT Martin"}
	
	#Pac 12
	if (y == 29) {s = "Arizona"}
	if (y == 28) {s = "Arizona St."}
	if (y == 107) {s = "California"}
	if (y == 529) {s = "Oregon"}
	if (y == 528) {s = "Oregon St."}
	if (y == 657) {s = "Southern Cal"}
	if (y == 674) {s = "Stanford"}
	if (y == 110) {s = "UCLA"}
	if (y == 732) {s = "Utah"}
	if (y == 756) {s = "Washington"}
	if (y == 754) {s = "Washington St."}
	
	#Patriot
	if (y == 725) {s = "Army"}
	if (y == 83) {s = "Bucknell"}
	if (y == 285) {s = "Holy Cross"}
	if (y == 342) {s = "Lafayette"}
	if (y == 352) {s = "Lehigh"}
	if (y == 726) {s = "Navy"}
	
	#SEC
	if (y == 8) {s = "Alabama"}
	if (y == 31) {s = "Arkansas"}
	if (y == 37) {s = "Auburn"}
	if (y == 235) {s = "Florida"}
	if (y == 257) {s = "Georgia"}
	if (y == 334) {s = "Kentucky"}
	if (y == 365) {s = "LSU"}
	if (y == 430) {s = "Mississippi St."}
	if (y == 434) {s = "Missouri"}
	if (y == 433) {s = "Ole Miss"}
	if (y == 648) {s = "South Carolina"}
	if (y == 694) {s = "Tennessee"}
	if (y == 697) {s = "Texas A&M"}
	if (y == 736) {s = "Vanderbilt"}
	
	
	#Southern
	if (y == 198) {s = "ETSU"}
	if (y == 244) {s = "Furman"}
	if (y == 406) {s = "Mercer"}
	if (y == 625) {s = "Samford"}
	if (y == 141) {s = "The Citadel"}
	if (y == 459) {s = "UNCG"}
	if (y == 741) {s = "VMI"}
	if (y == 769) {s = "Western Caro."}
	if (y == 2915) {s = "Wofford"}
	
	#Southland
	if (y == 26172) {s = "A&M-Corpus Chris"}
	if (y == 2) {s = "Abilene Christian"}
	if (y == 1004) {s = "Central Ark."}
	if (y == 287) {s = "Houston Baptist"}
	if (y == 2743) {s = "Incarnate Word"}
	if (y == 346) {s = "Lamar"}
	if (y == 402) {s = "McNeese"}
	if (y == 474) {s = "New Orleans"}
	if (y == 483) {s = "Nicholls St."}
	if (y == 508) {s = "Northwestern St."}
	if (y == 676) {s = "SFA"}
	if (y == 624) {s = "Sam Houston St."}
	if (y == 655) {s = "Southeastern LA."}
	
	#Southwestern
	if (y == 6) {s = "Alabama A&M"}
	if (y == 7) {s = "Alabama St."}
	if (y == 17) {s = "Alcorn"}
	if (y == 2678) {s = "Ark. Pine Bluff"}
	if (y == 261) {s = "Grambling"}
	if (y == 314) {s = "Jackson St."}
	if (y == 432) {s = "Mississippi Val."}
	if (y == 553) {s = "Prairie View"}
	if (y == 665) {s = "Southern U."}
	if (y == 699) {s = "Texas Southern"}
	
	#Summit League
	if (y == 308) {s = "Fort Wayne"}
	if (y == 493) {s = "North Dakota St."}
	if (y == 464) {s = "Omaha"}
	if (y == 527) {s = "Oral Roberts"}
	if (y == 649) {s = "South Dakota St."}
	if (y == 771) {s = "Western Ill."}
	
	
	#Sun Belt
	if (y == 27) {s = "Appalachian St."}
	if (y == 30) {s = "Arkansas St."}
	if (y == 149) {s = "Coastal Carolina"}
	if (y == 253) {s = "Georgia Southern"}
	if (y == 254) {s = "Georgia St."}
	if (y == 498) {s = "La.-Monroe"}
	if (y == 32) {s = "Little Rock"}
	if (y == 671) {s = "Louisiana"}
	if (y == 646) {s = "South Ala."}
	if (y == 670) {s = "Texas State"}
	if (y == 716) {s = "Troy"}
	if (y == 702) {s = "UT Arlington"}
	
	#West Coast
	if (y == 77) {s = "BYU"}
	if (y == 260) {s = "Gonzaga"}
	if (y == 370) {s = "Loyola Marymount"}
	if (y == 534) {s = "Pacific"}
	if (y == 541) {s = "Pepperdine"}
	if (y == 551) {s = "Portland"}
	if (y == 610) {s = "Saint Marys (CA)"}
	if (y == 627) {s = "San Diego"}
	if (y == 629) {s = "San Francisco"}
	if (y == 631) {s = "Santa Clara"}
	
	#Western Athletic
	if (y == 94) {s = "CSU Bakersfield"}
	if (y == 136) {s = "Chicago St."}
	if (y == 1104) {s = "Grand Canyon"}
	if (y == 472) {s = "New Mexico St."}
	if (y == 502) {s = "Northern Colo."}
	if (y == 102) {s = "Sacramento St."}
	if (y == 1356) {s = "Seattle U"}
	if (y == 536) {s = "UTRGV"}
	if (y == 30024) {s = "Utah Valley"}
	
	
	
	p_2018 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12973&year_stat_category_id=11954")
	p_2017 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12560&year_stat_category_id=11001")
	p_2016 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12360&year_stat_category_id=10947")
	p_2015 <- paste0("http://stats.ncaa.org/team/", y,"/stats?id=12080&year_stat_category_id=10781")
	
	#2018 totals
	url <- p_2018
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	get_stats = subset(get_stats, select = -c(G) )
	
	pitching_2018 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")
	
	
	pitching_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2018")
	
	pitching_2018r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2018")
	
	pitching_2018r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2018r$Pitches)))
	
	pitching_2018 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ER, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) +3.147,2) FIP FROM pitching_2018r ORDER BY PA DESC")
	
	
	
	#2017 totals
	url <- p_2017
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	get_stats = subset(get_stats, select = -c(G) )
	
	pitching_2017 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")
	
	
	pitching_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2017")
	
	pitching_2017r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2017")
	
	pitching_2017r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2017r$Pitches)))
	
	pitching_2017 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ER, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) +3.147,2) FIP FROM pitching_2017r ORDER BY PA DESC")
	
	
	
	
	#2016 totals
	url <- p_2016
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	get_stats = subset(get_stats, select = -c(G) )
	
	pitching_2016 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")
	
	
	pitching_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, CASE WHEN H IS NULL THEN 0 ELSE H END AS H, CASE WHEN BB IS NULL THEN 0 ELSE BB END AS BB, CASE WHEN SO IS NULL THEN 0 ELSE SO END AS SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2016")
	
	pitching_2016r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER,  H, BB, SO, cast(BF AS float) BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO, ERA FROM pitching_2016")
	
	pitching_2016r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2016r$Pitches)))
	
	pitching_2016 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, cast(BF AS float) PA, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2) FIP FROM pitching_2016r ORDER BY PA DESC")
	
	#2015 totals
	url <- p_2015
	pgsession <- html_session(url)
	pgform <-html_form(pgsession)[[3]]
	filled_form <-set_values(pgform,
						"available_stat_id" = "0"
	)
	
	d <- submit_form(session = pgsession, form=filled_form)
	
	
	
	get_stats <- d %>%
		html_nodes("table") %>%
		.[[3]] %>%
		html_table(header=TRUE)
	
	get_stats = subset(get_stats, select = -c(G) )
	
	pitching_2015 <- sqldf("select * from get_stats WHERE IP > 0 AND player <> 'Totals' AND player <> 'Opponent Totals'")
	
	
	pitching_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, H, BB, SO, BF, CASE WHEN [2B-A] IS NULL THEN 0 ELSE [2B-A] END AS [2B], CASE WHEN [3B-A] IS NULL THEN 0 ELSE [3B-A] END AS [3B], CASE WHEN [HR-A] IS NULL THEN 0 ELSE [HR-A] END AS HR, CASE WHEN HB IS NULL THEN 0 ELSE HB END AS HBP, CASE WHEN IBB IS NULL THEN 0 ELSE IBB END AS IBB, CASE WHEN GO IS NULL THEN 0 ELSE GO END AS GO, CASE WHEN FO IS NULL THEN 0 ELSE FO END AS FO FROM pitching_2015")
	
	pitching_2015r <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, Pitches, ER, ERA, H, BB, SO, BF, (H+SO+GO+FO) AB, H - ([2B] + [3B] + [HR]) AS [1B], [2B], [3B], [HR], HBP, IBB, GO, FO FROM pitching_2015")
	
	pitching_2015r$Pitches <- as.numeric(gsub(",", "", as.character(pitching_2015r$Pitches)))
	
	pitching_2015 <- sqldf("select Player, Jersey, Yr, Pos, GP, GS, IP, BF PA, Pitches, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2)  FIP FROM pitching_2015r")
	
	
	#Get career totals
	pitching_total_r <- sqldf("select p18.player, p18.Jersey, p18.Yr, p18.Pos, p18.GP, case when p18.GS IS NULL THEN 0 ELSE p18.GS END AS GS , p18.IP, p18.BF, p18.Pitches, p18.ER, p18.H, p18.BB, p18.SO, (p18.H + p18.SO + p18.GO + p18.FO) AB, p18.H - (p18.[2B] + p18.[3B] + p18.[HR]) AS [1B], p18.[2B], p18.[3B], p18.[HR], p18.HBP, p18.IBB, p18.GO, p18.FO from pitching_2018r p18 left outer join pitching_2017r p17 on p18.player = p17.player 
						 UNION select p17.player, p17.Jersey, p17.Yr, p17.Pos, p17.GP, case when p17.GS IS NULL THEN 0 ELSE p17.GS END AS GS, p17.IP, p17.BF, p17.Pitches, p17.ER, p17.H, p17.BB, p17.SO, (p17.H + p17.SO + p17.GO + p17.FO) AB, p17.H - (p17.[2B] + p17.[3B] + p17.[HR]) AS [1B], p17.[2B], p17.[3B], p17.[HR], p17.HBP, p17.IBB, p17.GO, p17.FO from pitching_2017r p17 left outer join pitching_2018r p18 on p18.player = p17.player 
						 UNION select p16.player, p16.Jersey, p16.Yr, p16.Pos, p16.GP, case when p16.GS IS NULL THEN 0 ELSE p16.GS END AS GS, p16.IP, p16.BF, p16.Pitches, p16.ER, p16.H, p16.BB, p16.SO, (p16.H + p16.SO + p16.GO + p16.FO) AB, p16.H - (p16.[2B] + p16.[3B] + p16.[HR]) AS [1B], p16.[2B], p16.[3B], p16.[HR], p16.HBP, p16.IBB, p16.GO, p16.FO from pitching_2016r p16 left outer join pitching_2018r p18 on p18.player = p16.player
						 UNION select p15.player, p15.Jersey, p15.Yr, p15.Pos, p15.GP, case when p15.GS IS NULL THEN 0 ELSE p15.GS END AS GS, p15.IP, p15.BF, p15.Pitches, p15.ER, p15.H, p15.BB, p15.SO, (p15.H + p15.SO + p15.GO + p15.FO) AB, p15.H - (p15.[2B] + p15.[3B] + p15.[HR]) AS [1B], p15.[2B], p15.[3B], p15.[HR], p15.HBP, p15.IBB, p15.GO, p15.FO from pitching_2015r p15 left outer join pitching_2018r p18 on p18.player = p15.player")
	
	pitching_total_r1 <- sqldf("select Player, max(Jersey) AS Jersey, max(yr) AS Yr, POS, SUM(GP) AS GP, SUM(GS) AS GS, SUM(IP) IP, SUM(BF) BF, SUM(Pitches) Pitches, SUM(ER) ER, SUM(H) H, SUM(BB) BB, SUM(SO) SO, (SUM(H) + SUM(SO) + SUM(GO) + SUM(FO)) AB, SUM(H) - (SUM([2B]) + SUM([3B]) + SUM([HR])) AS [1B], SUM([2B]) [2B], SUM([3B]) [3B], SUM([HR]) [HR], SUM(HBP) HBP, SUM(IBB) IBB, SUM(GO) GO, SUM(FO) FO FROM pitching_total_r group by Player")
	
	pitching_total <- sqldf("select Player, Jersey, Yr, Pos, GP, IP, BF PA, Pitches, ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) [K%], ROUND((cast(BB AS float) / cast(BF AS float) * 100),2) [BB%], (ROUND((cast(SO AS float) / cast(BF AS float) * 100),2) - ROUND((cast(BB AS float) / cast(BF AS float) * 100),2)) AS [K%-BB%], Round((H / cast((H+SO+GO+FO) AS float)),3) AVG, ROUND((cast((BB + H + HBP) AS float) / BF),3) OBP, ROUND((([1B] + (2*[2B]) + (3 *[3B]) + (4 * HR)) / cast((H + SO + GO + FO)AS float)),3) SLG, ROUND(((([1B] * .878) + ([2b] * 1.242) + ([3B] * 1.569) + (HR * 2.015) + (BB * .691) + (HBP * .721)) / BF),3) AS wOBA, ROUND((cast(GO AS float) / cast(BF AS float) * 100),2) [GO%], ROUND((cast(FO AS float) / cast(BF AS float) * 100),2) [FO%], ROUND(((ER / IP) * 9), 2) ERA, ROUND(( ((13*HR) + (3*(BB+HBP))-(2*SO)) / IP) + 3.147,2)  FIP FROM pitching_total_r1")
	
	Players <- sqldf("select Player FROM pitching_2018r")
	
	pitching_career <- sqldf("select * FROM pitching_total WHERE player IN Players ORDER BY PA DESC")
	
	pitching_career <- sqldf(paste0("select p.player, '", c ,"' AS Conference , '", s ,"' AS School ,p18.Yr, p.Pos, p.IP, p.PA, p.Pitches, p.[K%], p.[BB%], p.[K%-BB%], p.AVG, p.OBP, p.SLG, p.wOBA, p.[GO%], p.[FO%], p.ERA, p.FIP FROM pitching_career p JOIN pitching_2018 p18 ON p.Player = p18.Player group by p.Player order by p.PA desc"))
	
	pitching_2018 <- sqldf(paste0("select p.player, '", c ,"' AS Conference , '", s ,"' AS School ,p.Yr, p.Pos, p.IP, p.PA, p.Pitches, p.[K%], p.[BB%], p.[K%-BB%], p.AVG, p.OBP, p.SLG, p.wOBA, p.[GO%], p.[FO%], p.ERA, p.FIP FROM pitching_2018 p group by p.Player order by p.PA desc"))
	
	pitching_career_master <- sqldf("Select * from pitching_career_master UNION select * from pitching_career")
	
	pitching_2018_master <- sqldf("Select * from pitching_2018_master UNION select * from pitching_2018")}



#Export to excel
#write.csv(x = pitching_career_master, file = "NCAA_Pitching_2018_Career.csv")

#write.csv(x = pitching_2018_master, file = "NCAA_Pitching_2018_Season.csv")

```




