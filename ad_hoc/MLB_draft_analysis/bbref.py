import csv
import pandas as pd
import re

cities = pd.read_csv("/Users/jasonrubenstein/Desktop/GeoLiteCity-Location.csv", encoding = "ISO-8859-1")

US = cities[(cities["country"] == "US")]
US["city_state"] = US["city"] + ", " + US["region"]
US = US.drop_duplicates(subset=['city_state'])

US.to_csv('US_cities', index=False)

drafted = pd.read_csv("/Users/jasonrubenstein/Downloads/2000-2018_MLB_draft_picks (1).csv")
drafted["city_state"] = drafted["city"] + ", " + drafted["state"]



draft_w_location = pd.merge(drafted, US, on="city_state")
draft_w_location = draft_w_location.drop_duplicates(subset=['player_name', 'city_state'])

draft_w_location.to_csv('draft_w_location', index=False)

drafted = pd.read_csv("/Users/jasonrubenstein/Desktop/CBBSN/draft_w_location.csv")
war_by_year = drafted.groupby(['year', 'round'], as_index=False)['WAR'].agg('sum')
war_by_year['WAR_per_team'] = war_by_year['WAR']/30
war_by_year['draft_year'] = war_by_year['year']
war_by_year.to_csv('war_by_year_round', index=0)

