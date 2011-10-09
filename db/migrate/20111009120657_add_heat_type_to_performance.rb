class AddHeatTypeToPerformance < ActiveRecord::Migration
    def up
        add_column :performances, :heat_type, :string, :default => 'final'
    end
    def down
        remove_column :performances, :heat_type
    end
end
