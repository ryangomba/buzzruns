class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.boolean :admin
      t.references :athlete

      t.timestamps
    end
    add_index :users, :athlete_id
  end
end
