class EventsController < ApplicationController

    def index
        @events = Event.all
        @event = Event.new
    end

    def create
        @event = Event.new(params[:event])
        if @event.save
            redirect_to events_path, :notice => 'Event was successfully created.'
        else
            render :action => 'index'
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path, :notice => 'Event was successfully deleted.'
    end

end
