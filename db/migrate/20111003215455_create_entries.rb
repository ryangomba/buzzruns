class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :athlete
      t.integer :milage
      t.text :notes
      t.date :date

      t.timestamps
    end
    add_index :entries, :athlete_id
  end
end
