class AddAliasesToEvents < ActiveRecord::Migration
    def up
        add_column :events, :aliases, :text
    end
    def down
        remove_column :events, :aliases
    end
end
