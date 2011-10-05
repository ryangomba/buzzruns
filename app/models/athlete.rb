class Athlete < ActiveRecord::Base

    has_and_belongs_to_many :performances

    def entry_year
        return self[:year] - 4
    end

    def milage(date)
    end

    def set_milage(date, milage)
    end

    def active(date)
    end

    def set_active(date, is_active)
    end

end
