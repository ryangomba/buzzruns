class AddPrToPerformance < ActiveRecord::Migration
    def up
        add_column :performances, :pr, :boolean, :default => 0
    end
    def down
        remove_column :performances, :pr
    end
end
