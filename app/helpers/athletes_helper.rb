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
                entry = entries.find_by_date(day)
                p = performances.find(:all, :conditions => ["date between ? and ?", day, day.change(:day => 6)])
                this = JournalWeek.new(day, entry, p)
                response[day.year][day.strftime("%B")].push(this)
            end
        end

        return response
    end

end
