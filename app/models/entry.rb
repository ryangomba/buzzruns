class Entry < ActiveRecord::Base

    belongs_to :athlete

    validates_presence_of :athlete_id, :date, :milage
    # okay if notes is nil

    validates_uniqueness_of :date, :scope => :athlete_id
    validates_each :date do |record, attr, value|
        record.errors.add attr, 'not a sunday.' if value.wday != 0
    end

end
