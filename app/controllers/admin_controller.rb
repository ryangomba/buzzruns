class AdminController < ApplicationController
    
    before_filter :check_admin, :only => [:milage, :performances]
    include ApplicationHelper
    
    def athletes
        if params[:search] && params[:limit]
            @athletes = Athlete.find(:all, :conditions => params[:search], :limit => params[:limit]) 
        elsif params[:search]
            @athletes = Athlete.find(:all, :conditions => params[:search], :limit => 80)
        elsif params[:limit]
            @athletes = Athlete.find(:all, :limit => params[:limit])
        else
            @athletes = Athlete.find(:all, :limit => 80)
        end
        
        respond_to do |format|
            format.html
            format.json
        end
        
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
