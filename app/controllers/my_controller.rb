class MyController < ApplicationController

    def dashboard
        @athlete = User.find_by_id(session[:user_id]).athlete
    end

    def journal
        redirect_to :controller => 'athletes',
                    :action => 'journal',
                    :id => session[:user_id]
    end

    def performances
        redirect_to :controller => 'athletes',
                    :action => 'performances',
                    :id => session[:user_id]
    end

end
