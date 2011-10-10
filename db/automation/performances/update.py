import sys
import httplib2 as httplib
import json
import time

import meets as brm
import events as bre
import athletes as bra
import performances as brp

base_url = 'http://127.0.0.1:3000'

########## SAVE A PERFORMANCE ##########

def save_performance(p):

    response, content = httplib.Http().request(
        base_url + "/performances.json",
        'POST',
        p,
        headers = {'Content-type': 'application/json'})

    if response.status not in set([201, 302]):
        print response.status, response.reason
        failed_performances.append(json.loads(p))

########## LINK A PERFORMANCE ##########

def add_performance(p):

    meet_id = brm.get_meet_id(p['tfrrs_meet_id'])
    athlete_id = bra.get_athlete_id(p['tfrrs_athlete_id'])
    event_id = bre.get_event_id(p['event_name'])

    if meet_id == None:
        print('No meet found (TFRRS ID #{})'.format(p['tfrrs_meet_id']))
        new_meets.add(p['tfrrs_meet_id'])
        failed_performances.append(p)
    if athlete_id == None:
        print('No athlete found (TFRRS ID #{})'.format(p['tfrrs_athlete_id']))
        new_athletes.add(p['tfrrs_athlete_id'])
        failed_performances.append(p)
    if event_id == None:
        print('No event found ({})'.format(p['event_name']))
        new_events.add(p['event_name'])
        failed_performances.append(p)
    
    if meet_id != None and athlete_id != None and event_id != None:
        save_performance(json.dumps({
            'meet_id': meet_id,
            'athlete_id': athlete_id,
            'event_id': event_id,
            'mark': p['mark'],
            'place': p['place'],
            'heat_type': p['heat_type'],
            'heat': p['heat'],
        }))

########## ITERATORS ##########

def add_performances(performances):
    print('Retreived %d performances. Adding now...' % len(performances))
    for p in performances:
        add_performance(p)

def add_meets(meets_to_update):
    print('Updating {} meets'.format(str(len(meets_to_update))))
    for m in meets_to_update:
        if brm.add_meet(m):
            print('Fetching results for meet %s' % m)
            add_performances(brp.get_performances_for_meet(m))

########## RUN THE PROGRAM ##########

failed_performances = []
new_meets = set([])
new_athletes = set([])
new_events = set([])

if len(sys.argv) == 2 and sys.argv[1] == 'all':
    print('FETCHING INFO FOR ALL MEETS')
    add_meets(brm.get_all_meets())

elif len(sys.argv) == 3 and sys.argv[1] == 'retry':
    print('LOADING PERFORMANCES FROM LOGS')
    p_in = open('logs/{}.json'.format(sys.argv[2]), 'r')
    logged_performances = json.loads(p_in.read())
    p_in.close()
    add_performances(logged_performances)

elif len(sys.argv) == 3 and sys.argv[1] == 'meets':
    print('FETCHING INFO FOR SPECIFIED MEETS')
    add_meets(set(sys.argv[2].rsplit(',')))

else:
    print('FETCHING INFO FOR NEW MEETS ONLY')
    add_meets(brm.get_new_meets())

timestamp = int(time.time())
p_out = open('logs/{}.json'.format(timestamp), 'w+')
p_out.write(json.dumps(failed_performances))
p_out.close()

print('MEETS DNE: {}'.format(new_meets))
print('EVENTS DNE: {}'.format(new_events))
print('ATHLETES DNE: {}'.format(new_athletes))

print('{} failed lookups. Run "retry {}" to retry'.format(len(failed_performances),timestamp))

