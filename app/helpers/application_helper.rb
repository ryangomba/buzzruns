module ApplicationHelper

    ##### AUTHENTICATION

    def is_athlete(user)
        !user.nil? and !user.athlete_id.nil?
    end

    def is_admin(user)
        !user.nil? and user.admin == true
    end

end
