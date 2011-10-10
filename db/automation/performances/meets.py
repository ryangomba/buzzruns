import httplib2 as httplib
import urllib
import BeautifulSoup
import json
import re

import functions as brf

base_url = 'http://127.0.0.1:3000'
team_id = 1365

print('Fetching a list of all meets from BuzzRuns')
buzzruns_html = urllib.urlopen(base_url + '/meets.json')
buzzruns_meets = json.loads(buzzruns_html.read())

def get_buzzruns_meets():
    return buzzruns_meets

def get_meet_id(tfrrs_id):
    for m in get_buzzruns_meets():
        if m['tfrrs_id'] == tfrrs_id:
            return m['id']

def get_all_meets():

    print('Fetching a list of all meets from TFRRS')
    html = urllib.urlopen('http://www.tfrrs.org/teams/{}.html'.format(team_id))
    soup = BeautifulSoup.BeautifulSoup(''.join(html))
    rows = soup.findAll('td', { "class" : "meet" })

    meets = set([])
    for r in rows:
        for link in r.findAll('a'):
            meet_id = brf.id_from_url(link['href'])
            if meet_id: meets.add(meet_id)
    return meets

def get_new_meets():

    tfrrs_meets = get_all_meets()

    buzzruns_meets_set = set([])
    for b in get_buzzruns_meets():
        buzzruns_meets_set.add(b['tfrrs_id'])

    return tfrrs_meets - buzzruns_meets_set

def add_meet(meet_id):

    print('Fetching TFRRS information for meet {}'.format(meet_id))
    tfrrs_html = urllib.urlopen('http://www.tfrrs.org/results/{}.html'.format(meet_id))
    soup = BeautifulSoup.BeautifulSoup(''.join(tfrrs_html))

    name = soup.find('div', {'class': 'title'}).find('h2').text

    date = soup.find('span', text='Date:').parent.parent.text
    date = date.rpartition(':')[2]
    date = brf.format_date(date)

    location = soup.find('span', text='Location:').parent.parent.text
    location = location.rpartition(' - ')[2]
    city, sep, state = location.partition(', ')

    post_params = json.dumps({
        'tfrrs_id': meet_id,
        'name': name,
        'date': date,
        'city': city,
        'state': state,
        })

    print('Attempting to add meet {} to BuzzRuns'.format(meet_id))
    response, content = httplib.Http().request(
        base_url + "/meets.json",
        'POST',
        post_params,
        headers = {'Content-type': 'application/json'})

    print response.status, response.reason
    return response.status in set([201, 302])

