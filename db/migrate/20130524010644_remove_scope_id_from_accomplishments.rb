class RemoveScopeIdFromAccomplishments < ActiveRecord::Migration
  def up
    remove_column :accomplishments, :scope_id
  end

  def down

  end
end
