require 'dates'

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

        f = params[:performance]

        @date = Meet.where(:id => params[:meet_id]).first.date
        f[:date] = @date
        f[:season_type] = season_kind_for_date(@date).id

        f[:pr] = 1
        @performances = Performance.where({:athlete_id => f[:athlete_id], :event_id => f[:event_id], :pr => 1})
        @performances.each do |p|
            if p.mark < f[:mark] and p.date < f[:date]
                f[:pr] = 0
            elsif p.mark > f[:mark] and p.date > f[:date]
                # need to update other performance as not a PR
            end
        end

        @performance = Performance.new(f)
        
        respond_to do |format|
            if @performance.save
                format.html { redirect_to @performance,
                    :notice => 'Performance was successfully created.' }
                format.json { render :json => @performance,
                    :status => :created, :location => @meet }
            elsif !@performance.errors[:athlete_id].nil?
                puts 'Performance already exists'
                format.html { render :action => "new" }
                format.json { render :json => @performance.errors,
                    :status => :found }
            else
                puts 'Performance could not be added'
                puts @performance.errors[:athlete_id]
                format.html { render :action => "new" }
                format.json { render :json => @performance.errors,
                    :status => :unprocessable_entity }
            end
        end
    end

end
