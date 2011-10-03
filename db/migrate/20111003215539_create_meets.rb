class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
