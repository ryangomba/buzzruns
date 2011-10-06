class SessionsController < ApplicationController
    def create
        user = User.find_by_login(params[:login])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, :notice => "Logged in!"
        elsif params[:login]
            params[:notice] = "Invalid login or password"
            render "new"
        else
            params[:notice] = "Please log in" 
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out!"
    end
end
