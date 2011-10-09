import httplib2 as httplib
import urllib
import re
import json
import BeautifulSoup

import functions as brf

base_url = 'http://127.0.0.1:3000'
team_name = 'Georgia Tech'

heat_types = {
        1: 'final',
        2: 'semi',
        3: 'prelim',
        }

def make_performances_for_meet(meet_id, sex):

    # GET THE PAGE
    success = False
    while success == False:
        try:
            tfrrs_html = urllib.urlopen('http://www.tfrrs.org/results/{}_{}.html'.format(meet_id, sex))
            success = True
        except:
            print('Bad request. Retrying')
    soup = BeautifulSoup.BeautifulSoup(''.join(tfrrs_html))

    # GET EVENTS
    page_events = soup.find('div', {'class': 'eventname'}).find('li').findAll('a')
    events = {}
    for e in page_events:
        events[e['href'].replace('#','')] = e.text

    # DOM ELEMENTS -> DICTIONARIES
    event_tables = soup.findAll('div', {'class': 'data'})
    cur_event_id = None
    cur_round_num = None
    heat_type = None
    ps = []
    # for each event
    for t in event_tables:
        # determine the event id, heat type, and heat number
        e_parts = t['id'].rsplit('_')
        event_id, round_num, heat = (e_parts[0], e_parts[1], e_parts[2])
        if event_id != cur_event_id:
            heat_type = 1
        elif round_num != cur_round_num:
            heat_type += 1
        cur_event_id = event_id
        cur_round_num = round_num
        # for each performance in the event
        rows = t.findAll('tr')
        for r in rows:
            # save the event data
            p = {'event': events[event_id],
                'heat_type': heat_types[heat_type],
                'heat': heat}
            # extract the column data
            cols = r.findAll('td')
            for c in cols:
                if c.has_key('class'):
                    text = c.text
                    attr = c['class'].rsplit(' ')[0]
                    # include link urls
                    link = c.find('a')
                    if link != None:
                        text += link.text
                        link_text = link['href']
                        p[attr+'_link'] = link_text
                    p[attr] = c.text
            ps.append(p)

    # CLEAN THE DICTIONARIES
    performances = []
    for p in ps:
        # check for valid school and athlete
        if p.has_key('team') and p['team'] == team_name and p.has_key('name_link'):
            performances.append({
                'event_name': str(p['event']),
                'tfrrs_athlete_id': brf.id_from_url(p['name_link']),
                'place': brf.clean_int(p['place']),
                'mark': brf.format_mark(p['time']),
                'tfrrs_meet_id': int(meet_id),
                'heat_type': str(p['heat_type']),
                'heat': int(p['heat']),
            })

    return performances

def get_performances_for_meet(meet_id):

    performances = []
    for sex in ['m', 'f']:
        performances += make_performances_for_meet(meet_id, sex)
    return performances

