import datetime
import string
import re

def id_from_url(url):
    match = re.compile(r'/(?P<id>\d+).html').search(url)
    if match:
        return int(match.group('id'))

def clean_int(s):
    return re.sub('[%s]' % re.escape(string.punctuation), '', s)

def format_date(date_string):
    parts = date_string.replace('-', '/').rsplit('/')
    date = '20'+parts.pop() + '-' + parts[0] + '-' + parts[1]
    return date

def make_date(date_string):
    date_string = date_string.replace('-', '/')
    parts = date_string.rsplit('/')
    return datetime.date(int('20'+parts.pop()), int(parts[0]), int(parts[1]))

def format_mark(mark_string):
    
    mark = mark_string.replace('m','')
    seconds, sep, tenths = mark.partition('.')
    minutes, sep, seconds = seconds.rpartition(':')

    try:
        numeric_mark = int(seconds) * 100
        if len(tenths) > 0:
            numeric_mark += int(tenths)
        if len(minutes) > 0:
            numeric_mark += int(minutes) * 6000
        return numeric_mark
    except:
        dnfs = set(['NH','ND','NT'])
        if mark_string not in dnfs:
            print ('No numeric conversion for mark %s' % mark)
        return 0

