class AddDateToPerformance < ActiveRecord::Migration
    def up
        add_column :performances, :date, :date
    end
    def down
        remove_column :performances, :date
    end
end
