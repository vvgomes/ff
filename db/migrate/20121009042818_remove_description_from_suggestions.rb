class RemoveDescriptionFromSuggestions < ActiveRecord::Migration
  def up
    remove_column :suggestions, :description
      end

  def down
    add_column :suggestions, :description, :text
  end
end
