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

    validates :firstname, :lastname, :sex, :year, :metrics, :presence => true

    after_create :make_new_user

    def make_new_user
        User.create(:login=>self.firstname, :password=>"Jackets", :admin=>false, :athlete_id=>self.id)
    end

end
