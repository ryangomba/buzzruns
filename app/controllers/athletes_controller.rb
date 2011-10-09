class AthletesController < ApplicationController

    # MANY

    def index
        @athletes = Athlete.all
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @athletes }
        end
    end

    # ONE

    def show
        @athlete = Athlete.find(params[:id])
    end

    def journal
        @athlete = Athlete.find(params[:id])
        start_date = params[:start] ? params[:start].to_date : @athlete.start_date
        end_date = params[:end] ? params[:end].to_date : Date.current
        @timespan = (start_date..end_date)
        @entries = Entry.where({:athlete_id => params[:id], :date => @timespan})
        @performances = Performance.where({:athlete_id => params[:id], :date => @timespan})
    end

    def performances
        @athlete = Athlete.find(params[:id])
    end

    # MANAGE

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
        @athlete = Athlete.find(params[:id])
        @athlete.destroy
        redirect_to athletes_url
    end

end
