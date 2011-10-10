class Performance < ActiveRecord::Base

    belongs_to :event
    belongs_to :meet
    belongs_to :athlete

    validates_presence_of :event_id, :athlete_id, :meet_id, :mark, :heat_type, :date
    # okay if place and/or heat is missing
    validates_inclusion_of :pr, :in => [true, false]
    validates_uniqueness_of :athlete_id, :scope => [:meet_id, :event_id, 'heat_type']

    def formatted_mark
        if mark == 0 then return 'DNF' end
        tenths = self[:mark] % 100
        seconds = (self[:mark] / 100) % 60
        string = "%02d.%02d" % [seconds, tenths]
        minutes = self[:mark] / 100 / 60
        if minutes > 0 then string = "#{minutes}:" + string end
        return string
    end

end
