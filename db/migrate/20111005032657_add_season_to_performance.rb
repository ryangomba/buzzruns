class AddSeasonToPerformance < ActiveRecord::Migration
    def up
        add_column :performances, :season_type, :integer, :default => 2
    end

    def down
        remove_column :performances, :season_type
    end
end
