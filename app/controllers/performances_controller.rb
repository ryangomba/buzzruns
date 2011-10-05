class PerformancesController < ApplicationController

    def index
        @performances = Performance.all()
    end

    def calendar
    end

    def year
    end

    def season
    end

end
