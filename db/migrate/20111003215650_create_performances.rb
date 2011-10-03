class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :event
      t.integer :place
      t.integer :mark
      t.references :meet

      t.timestamps
    end
    add_index :performances, :event_id
    add_index :performances, :meet_id
  end
end
