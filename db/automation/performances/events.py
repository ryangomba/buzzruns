import urllib
import json

base_url = 'http://127.0.0.1:3000'

# GET EXISTING EVENTS

print('Getting a list of existing events')
buzzruns_events = urllib.urlopen(base_url + '/events.json')
buzzruns_events = json.loads(buzzruns_events.read())
for e in buzzruns_events:
    e['aliases'] = e['aliases'].replace(' ','').lower().rsplit(',')

def get_buzzruns_events():
    return buzzruns_events

# FIND AN EXISTING EVENT

def get_event_id(event_string):
    event_string = event_string.replace(' ','').lower()
    for e in buzzruns_events:
        if e['aliases'].count(event_string):
            return e['id']
