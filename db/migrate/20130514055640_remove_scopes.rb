class RemoveScopes < ActiveRecord::Migration
  def up
    drop_table :scopes
  end

  def down
    create_table :scopes do |t|
      t.string :name

      t.timestamps
    end
  end
end
