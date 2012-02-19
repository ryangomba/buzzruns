class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
