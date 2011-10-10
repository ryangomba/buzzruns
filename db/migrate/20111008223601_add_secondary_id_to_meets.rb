class AddSecondaryIdToMeets < ActiveRecord::Migration
    def up
        add_column :meets, :tfrrs_id, :integer
    end
    def down
        remove_column :meets, :tfrrs_id
    end
end
