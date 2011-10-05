module AthletesHelper

    def split_sexes(athletes)
        men = athletes.find_all{|a| a.sex == 'male' }
        women = athletes.find_all{|a| a.sex == 'female' }
        return { :Men => men, :Women => women }
    end

end
