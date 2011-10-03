class AthletesPerformances < ActiveRecord::Migration
    def up
        create_table :athletes_performances, :id => false do |t|
            t.integer :athlete_id
            t.integer :performance_id
        end
    end

    def down
        drop_table :athletes_performances
    end
end
