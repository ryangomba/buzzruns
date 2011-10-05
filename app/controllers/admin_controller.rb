class AdminController < ApplicationController

    def athletes
        redirect_to :controller => 'athletes',
                    :action => 'index'
    end

    def milage
        # todo
    end

    def performances
        # todo
    end

end
