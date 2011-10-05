class Event < ActiveRecord::Base

    KINDS = ['track', 'field']

    validates :name, :kind, :presence => true
    validates_inclusion_of :kind, :in => KINDS

end
