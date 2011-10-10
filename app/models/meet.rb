class Meet < ActiveRecord::Base
    validates_uniqueness_of :tfrrs_id
end
