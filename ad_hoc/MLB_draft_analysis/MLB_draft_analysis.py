from py_db import db
import requests
from bs4 import BeautifulSoup, Comment
import argparse
from time import time,sleep 


db = db('CBBSN')


def initiate():
    start_time = time()

    table = 'draft_pick_analysis'

    # db.query("TRUNCATE TABLE %s;" % (table))
    # db.conn.commit()

    for yr in range(2000, 2019):
        print '\n', yr
        for rnd in range (1,51):
            print '\t', yr, '- round', rnd

            url = "https://www.baseball-reference.com/draft/?year_ID=%s&draft_round=%s&draft_type=junreg&query_type=year_round&from_type_jc=0&from_type_hs=0&from_type_4y=0&from_type_unk=0" % (yr, rnd)

            entries = process_draftRound(yr, rnd, url)

            if entries not in ([], None): 
                raw_input(entries)
                # db.insertRowDict(entries, table, replace=True, insertMany=True, rid=0)
                # db.conn.commit()

    end_time = time()

    elapsed_time = float(end_time - start_time)
    print "time elapsed (in seconds): " + str(elapsed_time)
    print "time elapsed (in minutes): " + str(elapsed_time/60.0)


def process_draftRound(yr, rnd, url):
    page_data = requests.get(url)
    soup = BeautifulSoup(page_data.content, 'lxml')

    player_entries = []
    player_rows = soup.findAll('tr')[1:]
    for player_row in player_rows:
        player_entry = {}
        player_entry['year'] = yr

        player_info = player_row.findAll('td')

        desired_dict = {
        'draft_round':'round',
        'overall_pick':'overall_pick',
        'round_pick':'round_pick',
        'team_ID':'team_name',
        'signed':'signed',
        'player':'player_name',
        'pos':'drafted_position',
        'WAR':'WAR',
        'G_bat':'G_bat',
        'AB':'AB',
        'HR':'HR',
        'batting_avg':'BA',
        'onbase_plus_slugging':'OPS',
        'G_pitch':'G_pitch',
        'W':'W',
        'L':'L',
        'earned_run_avg':'ERA',
        'whip':'WHIP',
        'SV':'SV',
        'from_type':'draft_type',
        'came_from':'drafted_out_of'
        }

        for info in player_info:
            # raw_input(info)
            if info['data-stat'] in desired_dict:
                key = desired_dict.get(info['data-stat'].strip())

                if key == 'player_name':
                    hrefs = info.findAll('a', href=True)
                    if len(hrefs) == 2:
                        player_url_base = "https://www.baseball-reference.com"
                        player_url = player_url_base + str(info.find('a')['href'])
                        player_entry[key] = info.find('a').getText().replace('*','').strip()
                        # seasons_played, first6_WAR, first6_G_bat, first6_G_pitch = process_player(player_url)
                    else:
                        player_entry[key] = info.getText().replace('*','').replace('(minors)','').strip()
                        # seasons_played, first6_WAR, first6_G_bat, first6_G_pitch = (0,0,0,0)

                elif key == 'team_name':
                    team_name = info.getText().split('via')[0].strip()
                    if team_name == 'Devil Rays':
                        team_name = 'Rays'
                    player_entry[key] = team_name

                else:
                    player_entry[key] = info.getText().strip()

        print player_entry['drafted_out_of']

        city = player_entry['drafted_out_of'].split('(')[-1].split(',')[0].strip()
        state = player_entry['drafted_out_of'].split(',')[-1].split(')')[0].split('(')[-1].strip()

        player_entry['city'] = city
        player_entry['state'] = state

        player_entries.append(player_entry)
        print '\t\t', player_entry['round_pick'], '\t', player_entry['team_name'], '---', player_entry['player_name']
        
    return player_entries


# def process_player(url):
#     page_data = requests.get(url)
#     soup = BeautifulSoup(page_data.content, 'lxml')

#     for comments in soup.findAll(text=lambda text:isinstance(text, Comment)):
#         comments.extract()
#         if len(comments) > 1000:
#             # raw_input(comments)

#             com_soup = BeautifulSoup(comments, 'lxml')

#             batting_val_table = com_soup.findAll('table', {'class': 'row_summable sortable stats_table', 'id': 'batting_value'})
#             raw_input(rows)

    return seasons_played, first6_WAR, first6_G_bat, first6_G_pitch


if __name__ == "__main__":     
    parser = argparse.ArgumentParser()

    args = parser.parse_args()
    
    initiate()


