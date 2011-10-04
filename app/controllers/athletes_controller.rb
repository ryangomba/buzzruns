class AthletesController < ApplicationController

    def index
        @athletes = Athlete.all()
    end

    def profile
        @athlete = Athlete.find(params[:id])
    end

    def journal
        @athlete = Athlete.find(params[:id])
    end

    def performances
        @athlete = Athlete.find(params[:id])
    end

end
