import httplib2 as httplib
import urllib
import json
import BeautifulSoup
import functions

base_url = 'http://127.0.0.1:3000'
team_name = 'Georgia Tech'
team_link= 'http://www.tfrrs.org/teams/1365.html'

# GET EXISTING EVENTS
print('Getting a list of existing events')
buzzruns_events = urllib.urlopen(base_url + '/events.json')
existing_events = json.loads(buzzruns_events.read())

# GET EXISTING ATHLETES
print('Getting a list of existing athletes')
buzzruns_athletes = urllib.urlopen(base_url + '/athletes.json')
existing_athletes = json.loads(buzzruns_athletes.read())

########## HELPER FUNCTIONS ##########

def get_all_meets():

    html = urllib.urlopen(team_link)
    soup = BeautifulSoup.BeautifulSoup(''.join(html))
    rows = soup.findAll('td', { "class" : "meet" })
    
    meets = []
    for r in rows:
        link = r.find('a')
        try:
            meet_id = int(link['href'].partition('.html')[0].rpartition('/')[2])
            if meets.count(meet_id) == 0:
                meets.append(meet_id)
        except:
            pass
    return meets

def get_new_meets():
    
    html = urllib.urlopen(base_url + '/meets.json')
    buzzruns_meets = json.loads(html.read())
    existing_meets = []
    for b in buzzruns_meets:
        existing_meets.append(b['tfrrs_id'])

    all_meets = get_all_meets()
    

def add_meet(meet_id):

    html = urllib.urlopen('http://www.tfrrs.org/results/' + str(meet_id) + '.html')
    soup = BeautifulSoup.BeautifulSoup(''.join(html))

    name = soup.find('div', {'class': 'title'})
    name = name.find('h2').text

    date = soup.find('span', text='Date:')
    date = date.parent.parent.text.partition(':')[2]
    date = functions.format_date(date)

    city = None
    state = None
    location = soup.find('span', text='Location:')
    if location != None:
        location = location.parent.parent.text
        location = location.partition(' - ')[2]
        city, sep, state = location.partition(', ')

    info = {'tfrrs_id': meet_id,
            'name': name,
            'date': date,
            'city': city,
            'state': state,
            }

    params = json.dumps(info)
    conn = httplib.Http()
    response, content = conn.request(base_url + "/meets.json",
            'POST',
            params,
            headers={'Content-type': 'application/json'})
    print response.status, response.reason

def get_event_id(event_string):
    event_string = event_string.replace(' ','').lower()
    for e in existing_events:
        aliases = e['aliases'].rsplit(',')
        if aliases.count(event_string):
            return e['id']

def get_athlete_id(athlete_link):
    tfrrs_id = athlete_link.partition('.html')[0]
    tfrrs_id = tfrrs_id.rsplit('/').pop()
    for a in existing_athletes:
        if a['tfrrs_id'] == int(tfrrs_id):
            return a['id']

def make_performances_for_meet(meet_id, sex):

    # GET THE PAGE
    html = urllib.urlopen('http://www.tfrrs.org/results/' + \
        str(meet_id) + '_' + sex + '.html')
    soup = BeautifulSoup.BeautifulSoup(''.join(html))

    # GET PAGE EVENTS
    page_events = soup.find('div', {'class': 'eventname'})
    page_events = page_events.find('li').findAll('a')
    events = {}
    for e in page_events:
        events[e['href'].replace('#','')] = e.text

    # GATHER THE ROWS
    ps = []
    tables = soup.findAll('div', {'class': 'data'})
    for t in tables:
        event = t['id'].partition('_')[0]
        rows = t.findAll('tr')
        for r in rows:
            ps.append((r, event))

    # MAKE THE DICTIONARIES
    performances = []
    for p, e in ps:
        parts = {'event': events[e]}
        cols = p.findAll('td')
        for c in cols:
            text = c.text
            attr = c['class'].rsplit(' ')[0]
            link = c.find('a')
            if link != None:
                text += link.text
                link_text = link['href']
                parts[attr+'_link'] = link_text
            parts[attr] = c.text
        performances.append(parts)

    # CLEAN THE DICTIONARIES
    new_performances = []
    for p in performances:
        if p['team'] == team_name and p.has_key('name_link'):
            event = get_event_id(p['event'])
            athlete = get_athlete_id(p['name_link'])
            post = {
                'athlete_id': athlete,
                'place': p['place'],
                'mark': functions.format_mark(p['time']),
                'event_id': event,
                'tfrrs_id': meet_id,
                }
            if event == None:
                print ('Could not save performance. No event for "%s"' % p['event'])
            elif athlete == None:
                print ('Could not save performance. No athlete (%s)' % p['name_link'])
            else:
                print post

    # MAKE THE OBJECTS
    #

def add_performances_for_meet(meet_id):

    buzzruns_performances = urllib.urlopen(base_url + \
        '/performances/tfrrs/' + str(meet_id) + '.json')
    existing_performances = json.loads(buzzruns_performances.read())

    male_performances = make_performances_for_meet(meet_id, 'm')
    female_performances = make_performances_for_meet(meet_id, 'f')

    #

