class RemoveUsers < ActiveRecord::Migration
  def up
      drop_table :users
  end

  def down

  end
end
