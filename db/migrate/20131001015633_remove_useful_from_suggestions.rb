class RemoveUsefulFromSuggestions < ActiveRecord::Migration
  def up
    remove_column :suggestions, :useful
  end

  def down
    add_column :suggestions, :useful, :boolean
  end
end
