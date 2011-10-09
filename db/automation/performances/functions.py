import datetime

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
    mark = int(seconds) * 100 + int(tenths)
    if len(minutes) > 0:
        mark += int(minutes) * 600
    return mark
