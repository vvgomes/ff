class AddUsefulToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :useful, :boolean
  end
end
