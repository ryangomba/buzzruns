class Event < ActiveRecord::Base

    KINDS = ['track', 'field']

    validates :name, :kind, :presence => true
    validates_inclusion_of :kind, :in => KINDS

    def to_s
        self[:name]
    end

end
