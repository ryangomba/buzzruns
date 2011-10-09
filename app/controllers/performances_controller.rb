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

    def tfrrs_meet
        @meet = Meet.where(:tfrrs_id => params[:id])
        @performances = Performance.where(:meet_id => @meet)
        respond_to do |format|
            format.html # meet.html.erb
            format.json { render :json => @performances }
        end
    end

    def new
    end

    def create
        @performance = Performance.new(params[:performance])
        respond_to do |format|
            if @performance.save
                format.html { redirect_to @performance,
                    :notice => 'Performance was successfully created.' }
                format.json { render :json => @performance,
                    :status => :created, :location => @meet }
            else
                format.html { render :action => "new" }
                format.json { render :json => @performance.errors,
                    :status => :unprocessable_entity }
            end
        end
    end

end
