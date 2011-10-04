class ApplicationController < ActionController::Base

    protect_from_forgery

    def current_user
        session[:user]
    end

    def login_required
        if session[:user]
            return true
        end
        flash[:warning]='Please login to continue'
        session[:return_to]=request.request_uri
        redirect_to :controller => "user", :action => "login"
        retrun false
    end

    def redirect_to_stored
        if return_to = session[:return_to]
            session[:return_to]= nil
            redirect_to_url(return_to)
        else
            redirect_to :controller => "user", :action => "dashboard"
    end

end
