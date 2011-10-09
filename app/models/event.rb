class Event < ActiveRecord::Base

    KINDS = ['track', 'field']

    validates_presence_of :name, :team, :kind
    validates_inclusion_of :kind, :in => KINDS

    def to_s
        self[:name]
    end

end
