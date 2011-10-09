class Performance < ActiveRecord::Base

    belongs_to :event
    belongs_to :meet
    has_many :athletes

end
