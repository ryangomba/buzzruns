class MyController < ApplicationController

    def profile
        redirect_to :controller => 'athlete',
                    :action => 'athlete#profile',
                    :id => session[:user_id]
    end

    def journal
        redirect_to :controller => 'athlete',
                    :action => 'athlete#journal',
                    :id => session[:user_id]
    end

    def performances
        redirect_to :controller => 'athlete',
                    :action => 'athlete#performances',
                    :id => session[:user_id]
    end

end
