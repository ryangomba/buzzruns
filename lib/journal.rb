##### A weekly summary for one athlete
###### May contain a journal entry and/or performances

class JournalWeek
    attr_reader :date, :entry, :performances
    def initialize(date, entry, performances)
        @date = date
        @entry = entry
        @performances = performances
    end
    def to_s
        return date.strftime("Week of %B %d, %Y")
    end
end
