class MergeDatesForMeets < ActiveRecord::Migration
    def up
        rename_column :meets, :start_date, :date
        remove_column :meets, :end_date
    end

    def down
        rename_column :meets, :date, :start_date
        add_column :meets, :end_date
    end
end
