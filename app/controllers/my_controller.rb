class MyController < ApplicationController

    def profile
        redirect_to :controller => 'athlete',
                    :action => 'athlete#profile',
                    :id => session[:user].id
    end

    def journal
        redirect_to :controller => 'athlete',
                    :action => 'athlete#journal',
                    :id => session[:user].id
    end

    def performances
        redirect_to :controller => 'athlete',
                    :action => 'athlete#performances',
                    :id => session[:user].id
    end

end
