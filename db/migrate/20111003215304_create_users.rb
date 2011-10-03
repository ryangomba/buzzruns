class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.references :athlete
      t.boolean :admin

      t.timestamps
    end
    add_index :users, :athlete_id
  end
end
