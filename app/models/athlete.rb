class Athlete < ActiveRecord::Base
    has_and_belongs_to_many :performances
end
