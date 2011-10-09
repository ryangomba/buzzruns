import sys
import requests

########## UPDATE THE DATABASE ##########

print sys.argv

if len(sys.argv) == 2 and sys.argv[1] == 'all':
    meets_to_update = requests.get_all_meets()
elif len(sys.argv) == 2:
    meets_to_update = sys.argv[1].rsplit(',')
else:
    meets_to_update = requests.get_new_meets()

print('Updating {} meets:'.format(str(len(meets_to_update))))
for m in meets_to_update:
    print('Adding meet %s:' % m)
    requests.add_meet(m)
    print('Adding results for meet %s:' % m)
    requests.add_performances_for_meet(m)

