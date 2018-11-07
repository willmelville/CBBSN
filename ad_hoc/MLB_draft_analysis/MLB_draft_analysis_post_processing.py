from py_db import db
import argparse
import csv

db = db('CBBSN')

def process(start_year, end_year, path):
    query = """SELECT 
'MLB_totals' AS team_name, round, 
COUNT(*) AS signed_players, 
SUM(IF(WAR IS NULL,0,1)) AS MLB_players, 
IFNULL(SUM(WAR),0) AS total_WAR, 
SUM(IF(IFNULL(G_bat,0) > IFNULL(G_pitch,0), G_bat,0)) AS batter_games,
SUM(IF(IFNULL(G_bat,0) > IFNULL(G_pitch,0), WAR,0)) AS batter_WAR,
SUM(IF(IFNULL(G_pitch,0) > IFNULL(G_bat,0), G_pitch,0)) AS pitcher_games,
SUM(IF(IFNULL(G_pitch,0) > IFNULL(G_bat,0), WAR,0)) AS pitcher_WAR,
SUM(IF(draft_type='4Yr',1,0)) AS 4yr_count,
SUM(IF(draft_type='HS',1,0)) AS HS_count,
SUM(IF(draft_type='JC',1,0)) AS JC_count,
SUM(IF(region='Southeast',1,0)) AS Southeast_count,
SUM(IF(region='West Coast',1,0)) AS WestCoast_count,
SUM(IF(region='Southwest',1,0)) AS Southwest_count,
SUM(IF(region='Northeast',1,0)) AS Northeast_count,
SUM(IF(region='Midwest',1,0)) AS Midwest_count,
SUM(IF(region='Canada',1,0)) AS Canada_count,
SUM(IF(region='Other',1,0)) AS Other_count
FROM draft_pick_analysis d
JOIN regions r 
WHERE d.state = r.State_Abbreviation
AND team_name IS NOT NULL
AND SIGNED = 'Y'
AND year < 2017
GROUP BY round
UNION ALL
SELECT 
team_name, round, 
COUNT(*) AS signed_players, 
SUM(IF(WAR IS NULL,0,1)) AS MLB_players, 
IFNULL(SUM(WAR),0) AS total_WAR, 
SUM(IF(IFNULL(G_bat,0) > IFNULL(G_pitch,0), G_bat,0)) AS batter_games,
SUM(IF(IFNULL(G_bat,0) > IFNULL(G_pitch,0), WAR,0)) AS batter_WAR,
SUM(IF(IFNULL(G_pitch,0) > IFNULL(G_bat,0), G_pitch,0)) AS pitcher_games,
SUM(IF(IFNULL(G_pitch,0) > IFNULL(G_bat,0), WAR,0)) AS pitcher_WAR,
SUM(IF(draft_type='4Yr',1,0)) AS 4yr_count,
SUM(IF(draft_type='HS',1,0)) AS HS_count,
SUM(IF(draft_type='JC',1,0)) AS JC_count,
SUM(IF(region='Southeast',1,0)) AS Southeast_count,
SUM(IF(region='West Coast',1,0)) AS WestCoast_count,
SUM(IF(region='Southwest',1,0)) AS Southwest_count,
SUM(IF(region='Northeast',1,0)) AS Northeast_count,
SUM(IF(region='Midwest',1,0)) AS Midwest_count,
SUM(IF(region='Canada',1,0)) AS Canada_count,
SUM(IF(region='Other',1,0)) AS Other_count
FROM draft_pick_analysis d
JOIN regions r 
WHERE d.state = r.State_Abbreviation
AND team_name IS NOT NULL
AND SIGNED = 'Y'
AND year >= %s
AND year <= %s
GROUP BY team_name, round;"""

    query = query % (start_year, end_year)
    res = db.query(query)

    csv_title = path + str(start_year) + '_to_' + str(end_year) + '_draftAnalysis.csv'
    csv_file = open(csv_title, 'wb')
    append_csv = csv.writer(csv_file)
    csv_header = ['team_name', 'round', 'signed_players', 'MLB_players', 'total_WAR', 'batter_games', 'batter_WAR', 'pitcher_games', 'pitcher_WAR', '4yr_count', 'HS_count', 'JC_count', 'Southeast_count', 'WestCoast_count,', 'Southwest_count', 'Northeast_count', 'Midwest_count', 'Canada_count', 'Other_count']
    append_csv.writerow(csv_header)

    for row in res:
        append_csv.writerow(row)


if __name__ == "__main__":        

    parser = argparse.ArgumentParser()
    parser.add_argument('--start_year',default=2007)
    parser.add_argument('--end_year',default=2016)
    parser.add_argument('--path',default='/Users/connordog/Dropbox/Desktop_Files/Work_Things/CBBSN/ad_hoc/MLB_draft_analysis/')    
    args = parser.parse_args()
    
    process(args.start_year, args.end_year, args.path)