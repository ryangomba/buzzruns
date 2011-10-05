class AdminController < ApplicationController
    before_filter :check_admin, :only => [:milage, :performances]
    include ApplicationHelper
    def athletes
        redirect_to :controller => 'athletes',
                    :action => 'index'
    end

    def milage
        # todo
    end

    def performances
        # todo
    end

    def check_admin
        if !session[:user_id] || !is_admin(User.find(session[:user_id]))
            redirect_to :controller => 'sessions',
                        :action => 'create',
                        :notice => "Admin users only"
        end
    end

end
