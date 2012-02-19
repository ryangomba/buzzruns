import sys
import datetime

athlete_id = sys.argv[1]
date = sys.argv[2].rsplit('-')
date = datetime.date(int(date[0]), int(date[1]), int(date[2]))
milage = sys.argv[3].rsplit(',')

string = ''
delta = datetime.timedelta(7)

for day in milage:
    if day != 'None':
        string += 'INSERT INTO "entries" ("athlete_id", "created_at", "date", "milage", "notes", "updated_at") VALUES (' + athlete_id + ', NULL, "' + date.strftime("%Y-%m-%d") + '", ' + str(day) + ', "some notes", NULL);\n'
    date += delta

print string
