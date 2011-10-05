class AthletesController < ApplicationController

    # MANY

    def index
        @athletes = Athlete.all()
    end

    # ONE

    def show
        @athlete = Athlete.find(params[:id])
    end

    def journal
        @athlete = Athlete.find(params[:id])
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
