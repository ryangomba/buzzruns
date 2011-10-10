import urllib
import json
import re

import functions as brf

base_url = 'http://127.0.0.1:3000'

# GET EXISTING ATHLETES

print('Getting a list of existing athletes')
buzzruns_athletes = urllib.urlopen(base_url + '/athletes.json')
buzzruns_athletes = json.loads(buzzruns_athletes.read())

def get_buzzruns_athletes():
    return buzzruns_athletes

# FIND AN EXISTING ATHLETE

def get_athlete_id(tfrrs_id):
    for a in buzzruns_athletes:
        if a['tfrrs_id'] == tfrrs_id:
            return a['id']

