class MakePerformancesMto1 < ActiveRecord::Migration
    def up
        drop_table :athletes_performances
        add_column :performances, :athlete_id, :integer
    end

    def down
        create_table :athletes_performances do |t|
            t.integer :athlete_id
            t.integer :performance_id
        end
        remove_column :performances, :athlete_id
    end
end
