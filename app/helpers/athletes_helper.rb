require 'journal'

module AthletesHelper

    ##### SPLIT ATHLETES BY SEX

    def split_sexes(athletes)
        men = athletes.find_all{|a| a.sex == 'male' }
        women = athletes.find_all{|a| a.sex == 'female' }
        return { :Men => men, :Women => women }
    end

    ##### MAKE JOURNAL ENTRIES FOR A TIMESPAN

    def make_weekly_journal(timespan, entries, performances)

        response = Hash.new do |year, month|
            year[month] = Hash.new do |month, week|
                month[week] = []
            end
        end

        timespan.each do |day|
            if day.wday == 0
                entry = get_entry_for_day(entries, day)
                weekspan = (day..(day+6))
                ps = []
                performances.each do |p|
                    if weekspan === p.date then ps.push(p) end
                end
                this = JournalWeek.new(day, entry, ps)
                response[day.year][day.strftime("%B")].push(this)
            end
        end

        return response
    end

    def get_milage_array(timespan, entries)
        milage_array = []
        timespan.each do |day|
            if day.wday == 0
                entry = get_entry_for_day(entries, day)
                milage_array.push(entry ? entry.milage : 0)
            end
        end
        return milage_array
    end

    def get_entry_for_day(entries, day)
        entries.each do |e|
            if e.date == day then return e end
        end
        return nil
    end

end
