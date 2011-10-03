class Performance < ActiveRecord::Base
    belongs_to :event
    belongs_to :meet
    has_and_belongs_to_many :athletes
end
