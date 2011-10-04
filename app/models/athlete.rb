class Athlete < ActiveRecord::Base

    has_and_belongs_to_many :performances
    validates :firstname, :lastname, :sex, :year, :metrics, :presence => true

end
