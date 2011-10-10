import datetime

milage = [49,52,30,31,27,32,35,40,40,47,49,55,7,12,7,0,14,18,23,15,23,37,43,23,17,0,13,22,28,32,40,43,47,45,49,50,42,46,39,39,37,41,39,22,0,0,24,25,32,41,32,45,45,50,50,53,50,58,54,57,51,55,62,55,49,58,60,61,47,36,18,19,39,39,46,55,56,57,54,65,59,51,57,43,52,42,58,53,51,57,49,30,39,33,32,35,25,0,0,22,27,31,41,43,46,53,50,59,57,53,58,61,59,70,59,49,11,0]

string = ''
date = datetime.date(2009, 7, 5)
delta = datetime.timedelta(7)

for day in milage:
    string += 'INSERT INTO "entries" ("athlete_id", "created_at", "date", "milage", "notes", "updated_at") VALUES (2, NULL, "' + date.strftime("%Y-%m-%d") + '", ' + str(day) + ', "some notes", NULL);\n'
    date += delta

print string
