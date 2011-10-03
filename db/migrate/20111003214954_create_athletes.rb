class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :firstname
      t.string :lastname
      t.string :sex
      t.integer :year
      t.string :metrics

      t.timestamps
    end
  end
end
