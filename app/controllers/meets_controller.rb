class MeetsController < ApplicationController
    def index
        @meets = Meet.all
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @meets }
        end
    end

  def show
  end

  def new
  end

    def create
        @meet = Meet.new(params[:meet])
        respond_to do |format|
            if @meet.save
                format.html { redirect_to @meet, :notice => 'Meet was successfully created.' }
                format.json { render :json => @meet, :status => :created, :location => @meet }
            elsif !@meet.errors[:id].nil?
                puts 'Meet already exists'
                format.html { render :action => "new" }
                format.json { render :json => @meet.errors,
                    :status => :found }
            else
                format.html { render :action => "new" }
                format.json { render :json => @meet.errors, :status => :unprocessable_entity }
            end
        end
    end

  def edit
  end

  def destroy
  end

end
