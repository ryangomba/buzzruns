class MyController < ApplicationController

    def dashboard
        redirect_to :controller => 'athletes',
                    :action => 'dashboard',
                    :id => session[:user_id]
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
