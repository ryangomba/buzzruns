require 'dates'

class Athlete < ActiveRecord::Base

    has_and_belongs_to_many :performances
    after_create :make_new_user
    validates :firstname, :lastname, :sex, :year, :metrics, :presence => true
    def entry_year
        return self[:year] - 4
    end

    def start_date
        return TrainingYear.new(self.entry_year + 1).period.first
    end

    def milage(date)
    end

    def set_milage(date, milage)
    end

    def active(date)
    end

    def set_active(date, is_active)
    end

    def name
        return "#{self.firstname} #{self.lastname}"
    end

    def make_new_user
        User.create(:login=>self.firstname, :password=>"Jackets", :admin=>false, :athlete_id=>self.id)
    end
end
