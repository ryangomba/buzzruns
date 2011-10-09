class AddSecondaryIdToAthletes < ActiveRecord::Migration
    def up
        add_column :athletes, :tfrrs_id, :integer
    end
    def down
        remove_column :athletes, :tfrrs_id
    end
end
